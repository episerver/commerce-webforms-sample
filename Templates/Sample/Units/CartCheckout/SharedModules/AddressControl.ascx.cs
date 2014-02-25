using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Sample.BaseControls;
using Mediachase.BusinessFoundation.Data.Business;
using Mediachase.Commerce.Core;
using Mediachase.Commerce.Customers;
using Mediachase.Commerce.Orders;
using Mediachase.Commerce.Orders.Dto;
using Mediachase.Commerce.Orders.Managers;
using Mediachase.Commerce.Security;
using Mediachase.Commerce.Website.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using EPiServer.Editor;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.CartCheckout.SharedModules
{
    public partial class AddressControl : RendererControlBase<CatalogContentBase>
    {
        private CustomerContact _currentContact;
        private readonly CartHelper _cartHelper = new CartHelper(Cart.DefaultName);
        private readonly CountryDto _countries = CountryManager.GetCountries();

        private Cart Cart
        {
            get
            {
                return _cartHelper.Cart;
            }
        }

        protected bool AllowSaveAddressBook 
        {
            get { return CustomerContext.Current.CurrentContact != null; }
        }

        /// <summary>
        /// Gets the countries.
        /// </summary>
        /// <value>The countries.</value>
        private CountryDto Countries
        {
            get
            {
                return _countries;
            }
        }

        /// <summary>
        /// Handles the Init event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Init(object sender, EventArgs e)
        {
            if (PageEditing.PageIsInEditMode)
            {
                return;
            }

            if (_cartHelper.IsEmpty)
            {
                Context.RedirectFast(GetUrl(Settings.CartPage));
                return;
            }

            if (_cartHelper.OrderForm.LineItems.Count == 0)
            {
                Context.RedirectFast(ResolveUrl("~/Shopping-Overview/"));
                return;
            }

            _currentContact = CustomerContext.Current.CurrentContact;
            addressBook.ItemCommand += (addressBook_ItemCommand);
            addressBook.ItemDataBound += (addressBook_ItemDataBound);

            AddAddressToContact.Checked = AllowSaveAddressBook;
        }

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCountries();
            }
            BindAddresses();
        }

        /// <summary>
        /// Saves the address.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void SaveAddress(object sender, EventArgs e)
        {
            AddOrderAddress(addressType.Value);
            if (AddAddressToContact.Checked)
            {
                var orderAddress = _cartHelper.FindAddressByName(Name.Text);
                AddCustomerAddress(orderAddress);
            }
            //redirect after post
            Context.RedirectFast(Request.RawUrl + "#ShippingRegion" + shipmentId.Value);
        }

        /// <summary>
        /// Handles the ItemDataBound event of the addressBook control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.ListViewItemEventArgs"/> instance containing the event data.</param>
        static void addressBook_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType != ListViewItemType.DataItem)
                return;

            var item = e.Item as ListViewDataItem;
            var address = item != null ? item.DataItem as CustomerAddress : null;
            if (address == null)
                return;

            var lit = item.FindControl("address") as Literal;
            if (lit != null)
                lit.Text = HttpUtility.HtmlEncode(address.GetAddressString());
        }

        /// <summary>
        /// Handles the ItemCommand event of the addressBook control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.ListViewCommandEventArgs"/> instance containing the event data.</param>
        void addressBook_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (string.IsNullOrEmpty(e.CommandArgument.ToString()) || _currentContact == null)
                return;

            var addressId = e.CommandArgument.ToString();
            var ca = _currentContact.ContactAddresses.FirstOrDefault(x => x.AddressId.ToString().ToLower().Equals(addressId.ToLower()));
            if (ca == null)
                return;

            var address = _cartHelper.FindAddressByName(ca.Name);
            if (address == null)
            {
                address = ConvertCustomerToOrderAddress(ca);
                Cart.OrderAddresses.Add(address);
            }
            else
            {
                CustomerAddress.CopyCustomerAddressToOrderAddress(ca, address);
            }

            // Add address to BillingAddressId/ShippingAddressId
            if (addressType.Value.Equals("billing"))
            {
                Cart.OrderForms[0].BillingAddressId = address.Name;
            }
            else
            {
                int shipId;
                if (int.TryParse(shipmentId.Value, out shipId))
                {
                    var shipment = Cart.OrderForms[0].Shipments.ToArray().FirstOrDefault(s => s.Id == shipId);
                    if (shipment != null)
                    {
                        shipment.ShippingAddressId = ca.Name;
                        OrderGroupWorkflowManager.RunWorkflow(Cart, OrderGroupWorkflowManager.CartPrepareWorkflowName);
                    }
                }
                else
                {
                    var shipment = Cart.OrderForms[0].Shipments.ToArray().FirstOrDefault()
                        ?? new Shipment()
                        {
                            CreatorId = SecurityContext.Current.CurrentUserId.ToString(),
                            Created = DateTime.UtcNow
                        };

                    shipment.ShippingAddressId = address.Name;

                    if (Cart.OrderForms[0].Shipments.Count < 1)
                    {
                        Cart.OrderForms[0].Shipments.Add(shipment);
                    }

                    if (!shipment.ShippingMethodId.Equals(Guid.Empty))
                    {
                        //Calculate shipping in case choosing shipping method first.
                        OrderGroupWorkflowManager.RunWorkflow(Cart, OrderGroupWorkflowManager.CartPrepareWorkflowName);
                    }
                }
                 
            }

            Cart.AcceptChanges();
            //redirect after post
            Context.RedirectFast(Request.RawUrl + "#ShippingRegion" + shipmentId.Value);
        }

        /// <summary>
        /// Binds the addresses.
        /// </summary>
        private void BindAddresses()
        {
            if (_currentContact != null && _currentContact.ContactAddresses != null && _currentContact.ContactAddresses.Any())
            {
                addressBook.DataSource = _currentContact.ContactAddresses;
                addressBook.DataBind();
            }
            else
            {
                addressBook.DataSource = new List<CustomerAddress>();
                addressBook.DataBind();
            }
        }

        /// <summary>
        /// Binds the countries.
        /// </summary>
        private void BindCountries()
        {
            if (Countries == null)
                return;

            Country.DataSource = Countries;
            Country.DataBind();

        }

        /// <summary>
        /// Adds the address.
        /// </summary>
        /// <param name="addressType">The address type.</param>
        private void AddOrderAddress(string addressType)
        {
            var orderAddress = _cartHelper.FindAddressByName(Name.Text);
            if (orderAddress == null)
            {
                orderAddress = new OrderAddress()
                {
                    ModifierId = SecurityContext.Current.CurrentUserId.ToString(),
                    Modified = DateTime.Now.ToUniversalTime()
                };

                Cart.OrderAddresses.Add(orderAddress);
            }

            orderAddress.FirstName = FirstName.Text;
            orderAddress.LastName = LastName.Text;
            orderAddress.Email = Email.Text;
            orderAddress.DaytimePhoneNumber = Phone.Text;
            orderAddress.Line1 = StreetAddress.Text;
            orderAddress.Line2 = Apartment.Text;
            orderAddress.City = City.Text;
            orderAddress.State = State.Text;
            orderAddress.PostalCode = Zip.Text;
            orderAddress.Name = Name.Text;
            orderAddress.CountryCode = Country.SelectedValue;

            if (addressType.Equals("billing"))
            {
                Cart.OrderForms[0].BillingAddressId = orderAddress.Name;
            }
            else
            {
                int shipId;
                if (int.TryParse(shipmentId.Value, out shipId))
                {
                    var shipment = Cart.OrderForms[0].Shipments.ToArray().First(s => s.Id == shipId);
                    shipment.ShippingAddressId = orderAddress.Name;
                }
                else
                {
                    var shipment = Cart.OrderForms[0].Shipments.ToArray().FirstOrDefault() ??
                                   new Shipment()
                                   {
                                       CreatorId = SecurityContext.Current.CurrentUserId.ToString(),
                                       Created = DateTime.UtcNow
                                   };
                    shipment.ShippingAddressId = orderAddress.Name;

                    if (Cart.OrderForms[0].Shipments.Count < 1)
                    {
                        Cart.OrderForms[0].Shipments.Add(shipment);
                    }
                }
            }

            Cart.AcceptChanges();
        }

        /// <summary>
        /// Converts the customer to order address.
        /// </summary>
        /// <param name="address">The address.</param>
        /// <returns></returns>
        private static OrderAddress ConvertCustomerToOrderAddress(AddressEntity address)
        {
            return new OrderAddress(address);
        }

        /// <summary>
        /// Adds the customer address.
        /// </summary>
        /// <param name="orderAddress">The order address.</param>
        /// <returns></returns>
        private static void AddCustomerAddress(OrderAddress orderAddress)
        {
            var contact = CustomerContext.Current.GetContactById(SecurityContext.Current.CurrentUserId);
            if (contact == null)
                return;

            var address = contact.ContactAddresses.FirstOrDefault(x => x.Name.Equals(orderAddress.Name));
            if (address == null)
            {
                address = CustomerAddress.CreateForApplication(AppContext.Current.ApplicationId);
                address.AddressType = CustomerAddressTypeEnum.Public;
                address.CreatorId = SecurityContext.Current.CurrentUserId;
                address.Created = DateTime.Now.ToUniversalTime();
                address.PrimaryKeyId = BusinessManager.Create(address);
                if (!contact.ContactAddresses.Any(x => x.PrimaryKeyId == address.PrimaryKeyId))
                    address.ContactId = contact.PrimaryKeyId;
            }

            address.ModifierId = SecurityContext.Current.CurrentUserId;
            address.Modified = DateTime.Now.ToUniversalTime();
            OrderAddress.CopyOrderAddressToCustomerAddress(orderAddress, address);
            BusinessManager.Update(address);
        }

    }
}