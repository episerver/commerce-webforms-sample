using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using EPiServer.Commerce.Sample.BaseControls;
using EPiServer.Commerce.Sample.Helpers;
using EPiServer.Core;
using EPiServer.Editor;
using EPiServer.Web.Routing;
using Mediachase.BusinessFoundation.Data.Business;
using Mediachase.Commerce;
using Mediachase.Commerce.Core;
using Mediachase.Commerce.Customers;
using Mediachase.Commerce.Inventory;
using Mediachase.Commerce.Marketing;
using Mediachase.Commerce.Orders;
using Mediachase.Commerce.Orders.Dto;
using Mediachase.Commerce.Orders.Exceptions;
using Mediachase.Commerce.Orders.Managers;
using Mediachase.Commerce.Security;
using Mediachase.Commerce.Website;
using Mediachase.Commerce.Website.Controls;
using Mediachase.Commerce.Website.Helpers;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.CartCheckout
{
    public partial class SingleShipmentCheckout : CheckoutControl
    {
        /// <summary>
        /// Get the shipment.
        /// </summary>
        protected Shipment Shipment
        {
            get
            {
                return Cart.OrderForms[0].Shipments[0];
            }
        }

        /// <summary>
        /// Get the multi shipment page link.
        /// </summary>
        protected string MultiShipmentPageUrl
        {
            get
            {
                var multiShipmentPage = CurrentPage.Property["MultiShipmentCheckout"].Value as PageReference;
                return new UrlResolver().GetUrl(multiShipmentPage, SiteContext.Current.LanguageName);
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

            if (CartHelper.IsEmpty)
            {
                Context.RedirectFast(GetUrl(Settings.CartPage));
                return;
            }

            if (CartHelper.OrderForm.LineItems.Count == 0)
            {
                Context.RedirectFast(ResolveUrl("~/Shopping-Overview/"));
                return;
            }

            OrderSubtotalID.IsCheckout = false;
        }

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (CartHelper.IsEmpty)
            {
                return;
            }

            if (!this.IsPostBack)
            {
                CreateDataShipment();

                if (!IsValidSingleShippment())
                {
                    CheckoutButton.Enabled = false;
                    CheckoutButton.CssClass += " disabled";
                    ErrorManager.GenerateError("Cart includes item(s) picked up from multiple stores, use \"Ship Items to Multiple Addresses\" instead.");
                    return;
                }

                SetBillingAddresses();
                SetShippingAddresses();

                bool bindShippingOptions = true;
                List<string> warehouseCodes = GetWarehousesForCart();
                if (warehouseCodes.Count == 1)
                {
                    IWarehouse warehouse = WarehouseHelper.GetWarehouse(warehouseCodes.FirstOrDefault());
                    bindShippingOptions = warehouse.IsFulfillmentCenter || !warehouse.IsPickupLocation;
                }

                if (Cart.OrderForms.Count > 0 && Cart.OrderForms[0].Shipments.Count > 0
                    && ShippingManager.IsHandoffShippingMethod(Cart.OrderForms[0].Shipments[0].ShippingMethodName))
                {
                    ShippingAddressInfo.UseWarehouseAddress = true;
                    if (!bindShippingOptions)
                    {
                        shippingOptions.DataBind();
                        var litMessage = shippingOptions.Controls.Count == 0 ? null : shippingOptions.Controls[0].FindControl("litMessage") as Literal;
                        if (litMessage != null)
                        {
                            litMessage.Text = ShippingManager.PickupShippingMethodName;
                        }
                    }
                    else
                    {
                        SetShippingMethod(BindShippingMethods());
                    }
                }
                else
                {
                    SetShippingMethod(BindShippingMethods());
                }
            }
        }

        /// <summary>
        /// Handles the Cancel event of the CancelButton control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Cancel_Click(object sender, EventArgs e)
        {
            CartHelper.Reset();
            Cart.AcceptChanges();
            Context.RedirectFast(GetUrl(Settings.CheckoutPage));
        }

        /// <summary>
        /// OnChange the Shipping.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void ChooseShipping_OnChange(object sender, EventArgs e)
        {
            ChangeShippingMethod();

            //redirect after post
            Context.RedirectFast(Request.RawUrl + "#ShippingRegion");
        }

        /// <summary>
        /// Change shipping method
        /// </summary>
        protected void ChangeShippingMethod()
        {
            string shippingMethodId = string.Empty;
            foreach (ListViewDataItem item in shippingOptions.Items)
            {
                var rdo = item.FindControl("rdoChooseShipping") as GlobalRadioButton;
                if (rdo != null)
                {
                    if (rdo.Checked)
                    {
                        var hidden = item.FindControl("hiddenShippingId") as HtmlInputControl;
                        if (hidden != null)
                        {
                            shippingMethodId = hidden.Value;
                            break;
                        }
                    }
                }
            }

            var oldShipmentMethod = Shipment.ShippingMethodId;
            var oldShipmentMethodName = string.Empty;
            ShippingMethodDto oldDto = ShippingManager.GetShippingMethod(oldShipmentMethod);
            if (oldDto != null && oldDto.ShippingMethod != null && oldDto.ShippingMethod.Count > 0)
            {
                oldShipmentMethodName = oldDto.ShippingMethod[0].Name;
            }

            Shipment.ShippingMethodId = new Guid(shippingMethodId);
            ShippingMethodDto dto = ShippingManager.GetShippingMethod(Shipment.ShippingMethodId);
            if (dto != null && dto.ShippingMethod != null && dto.ShippingMethod.Count > 0)
            {
                Shipment.ShippingMethodName = dto.ShippingMethod[0].Name;
            }

            if (ShippingManager.IsHandoffShippingMethod(oldShipmentMethodName) && !ShippingManager.IsHandoffShippingMethod(Shipment.ShippingMethodName))
            {
                Shipment.ShippingAddressId = String.Empty;
            }

            // restore coupon code to context
            string couponCode = Session[Constants.LastCouponCode] as string;
            if (!String.IsNullOrEmpty(couponCode))
            {
                MarketingContext.Current.AddCouponToMarketingContext(couponCode);
            }

            //Calculate shipping, disocunts, totals, etc
            OrderGroupWorkflowManager.RunWorkflow(Cart, OrderGroupWorkflowManager.CartPrepareWorkflowName);
            Cart.AcceptChanges();
        }

        /// <summary>
        /// Handles the Click event of the CheckoutButton control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Order_Click(object sender, EventArgs e)
        {
            try
            {
                // Note: in order to support "2-phrase" checkout (for example, in PayPal, the payment process will be processed in PayPal's system),
                // we won't use execute this block in transaction. We will use transaction in PlaceOrder method instead.
                if (string.IsNullOrEmpty(Cart.OrderForms[0].BillingAddressId)
                    || Cart.OrderAddresses.ToArray().FirstOrDefault(x => x.Name.Equals(Cart.OrderForms[0].BillingAddressId)) == null)
                {
                    ErrorManager.GenerateError("Billing Address is not defined.");
                    return;
                }

                if (Cart.OrderForms[0].Shipments.Count == 0)
                {
                    ErrorManager.GenerateError("Shipping Address is not defined.");
                    return;
                }

                Shipment ship = Cart.OrderForms[0].Shipments.ToArray().FirstOrDefault();
                if (ship == null
                    || string.IsNullOrEmpty(ship.ShippingAddressId)
                    || Cart.OrderAddresses.ToArray().FirstOrDefault(x => x.Name.Equals(ship.ShippingAddressId)) == null)
                {
                    ErrorManager.GenerateError("Shipping Address is not defined.");
                    return;
                }

                ShippingMethodDto dto = ShippingManager.GetShippingMethod(ship.ShippingMethodId);
                if (dto != null && dto.ShippingMethod != null && dto.ShippingMethod.Count > 0)
                {
                    ship.ShippingMethodId = dto.ShippingMethod[0].ShippingMethodId;
                    ship.ShippingMethodName = dto.ShippingMethod[0].Name;
                }
                else
                {
                    ErrorManager.GenerateError("Please choose a shipping method.");
                    return;
                }

                string billingAddressId = Cart.OrderForms[0].BillingAddressId;
                foreach (Payment payment in CartHelper.OrderForm.Payments)
                {
                    payment.Delete();
                }

                if (!PaymentOptionsID.FullfilPayment())
                {
                    return;
                }

                PlaceOrder();
            }
            catch (PaymentException ex)
            {
                ErrorManager.GenerateError(ex.Message);
                return;
            }

            Session.Remove(Constants.LastCouponCode);

            // Redirect customer to receipt page
            if (!Request.IsAuthenticated)
            {
                Context.RedirectFast("~/Templates/Sample/Pages/CheckoutConfirmationStep.aspx");
            }
            else
            {
                Context.RedirectFast(GetUrl(Settings.YourOrdersPage));
            }

        }


        /// <summary>
        /// Create shipment for the first time.
        /// </summary>
        private void CreateDataShipment()
        {
            if (Cart.OrderForms.Count > 0)
            {
                // If switch from MultiShipment to SingleShipment (just demo showcase), remove existing Shipment and Address
                if (Cart.OrderForms[0].Shipments.Count > 1)
                {
                    foreach (Shipment shipment in Cart.OrderForms[0].Shipments)
                    {
                        shipment.Delete();
                    }
                    foreach (OrderAddress address in Cart.OrderAddresses)
                    {
                        address.Delete();
                    }
                    Cart.AcceptChanges();
                }

                Shipment ship = Cart.OrderForms[0].Shipments.ToArray().FirstOrDefault();

                if (ship == null)
                {
                    ship = Cart.OrderForms[0].Shipments.AddNew();
                    ship.CreatorId = SecurityContext.Current.CurrentUserId.ToString();
                    ship.Created = DateTime.UtcNow;

                    // Add LineItem to Shipment.
                    int index = 0;
                    foreach (LineItem item in Cart.OrderForms[0].LineItems)
                    {
                        string key = index.ToString();
                        if (ship.LineItemIndexes.Contains(key))
                            ship.RemoveLineItemIndex(key);

                        ship.AddLineItemIndex(index, item.Quantity);
                        index++;
                    }
                }
            }
        }

        private bool IsValidSingleShippment()
        {
            // Check valid line item for Single Shipment
            if (Cart.OrderForms.Count > 0)
            {
                List<string> warehouseCodes = GetWarehousesForCart();

                // Cart only has one warehouse instore pickup 
                if (warehouseCodes.Count == 1)
                {
                    // Shipping method is "In store pickup", add address to Cart & Shipment
                    IWarehouse warehouse = WarehouseHelper.GetWarehouse(warehouseCodes.FirstOrDefault());

                    if (ShouldSetStoreAsPickupAddressForShipment(warehouse, Shipment))
                    {
                        Shipment.WarehouseCode = warehouse.Code;

                        if (CartHelper.FindAddressByName(warehouse.Name) == null)
                        {
                            var address = warehouse.ContactInformation.ToOrderAddress();
                            address.Name = warehouse.Name;
                            Cart.OrderAddresses.Add(address);
                        }

                        Shipment.ShippingAddressId = warehouse.Name;
                        Shipment.ShippingMethodName = ShippingManager.PickupShippingMethodName;

                        var instorepickupShippingMethod = ShippingManager.GetShippingMethods(SiteContext.Current.LanguageName).ShippingMethod.ToArray().Where(m => m.Name.Equals(ShippingManager.PickupShippingMethodName)).FirstOrDefault();
                        if (instorepickupShippingMethod != null)
                        {
                            Shipment.ShippingMethodId = instorepickupShippingMethod.ShippingMethodId;
                        }

                        Cart.AcceptChanges();
                    }
                }
                else
                {
                    foreach (string warehouseCode in warehouseCodes)
                    {
                        IWarehouse warehouse = WarehouseHelper.GetWarehouse(warehouseCode);
                        if (warehouse != null && warehouse.IsPickupLocation)
                        {
                            return false;
                        }
                    }
                }
            }
            return true;
        }

        private List<string> GetWarehousesForCart()
        {
            List<string> warehouseCodes = new List<string>();
            var lineItems = Cart.OrderForms[0].LineItems;
            foreach (LineItem lineItem in lineItems)
            {
                if (!warehouseCodes.Contains(lineItem.WarehouseCode))
                {
                    warehouseCodes.Add(lineItem.WarehouseCode);
                }
            }
            return warehouseCodes;
        }

        /// <summary>
        /// Binds the shipping methods.
        /// </summary>
        private string BindShippingMethods()
        {
            var defaultShippingMethodId = String.Empty;
            var dtShippingMethods = new DataTable();
            dtShippingMethods.Columns.Add(new DataColumn("ShippingName"));
            dtShippingMethods.Columns.Add(new DataColumn("Description"));
            dtShippingMethods.Columns.Add(new DataColumn("ShippingMethodId"));

            ShippingMethodDto shippingMethods = ShippingManager.GetShippingMethods(SiteContext.Current.LanguageName);
            if (shippingMethods != null && shippingMethods.ShippingMethod != null &&
                shippingMethods.ShippingMethod.Count > 0)
            {
                foreach (var shippingMethod in shippingMethods.ShippingMethod.OrderBy(c => c.Ordering))
                {
                    string shippingMethodName;
                    if (shippingMethod.BasePrice == 0m)
                    {
                        shippingMethodName = string.Format("{0} - Free", shippingMethod.DisplayName);
                    }
                    else
                    {
                        Money currentPrice = SampleStoreHelper.ConvertCurrency(new Money(shippingMethod.BasePrice, shippingMethod.Currency), SiteContext.Current.Currency);
                        if (!string.IsNullOrEmpty(Shipment.ShippingAddressId))
                        {
                            var shipment = Cart.OrderForms[0].Shipments.ToArray().FirstOrDefault();
                            currentPrice = SampleStoreHelper.GetShippingCost(shippingMethod, shipment);
                        }
                        shippingMethodName = string.Format("{0} - {1}", shippingMethod.DisplayName, currentPrice.ToString());
                    }
                    dtShippingMethods.Rows.Add(shippingMethodName, shippingMethod.IsDescriptionNull() ? string.Empty : shippingMethod.Description, shippingMethod.ShippingMethodId);
                    if (shippingMethod.IsDefault)
                    {
                        defaultShippingMethodId = shippingMethod.ShippingMethodId.ToString();
                    }
                }

                shippingOptions.DataSource = dtShippingMethods;
                shippingOptions.DataBind();
            }

            return defaultShippingMethodId;
        }

        /// <summary>
        /// Sets the billing addresses.
        /// </summary>
        private void SetBillingAddresses()
        {
            OrderAddress address = null;

            if (Cart.OrderAddresses.ToArray().Length > 0)
            {
                string billingAddressId = Cart.OrderForms[0].BillingAddressId;
                address = CartHelper.FindAddressByName(billingAddressId);
            }
            else
            {
                var currentContact = CustomerContext.Current.CurrentContact;

                var defaultBillingAddress = currentContact == null ? null : currentContact.ContactAddresses.FirstOrDefault(
                                                                                a => currentContact.PreferredBillingAddressId.HasValue &&
                                                                                     currentContact.PreferredBillingAddressId.Value == a.PrimaryKeyId.Value);
                // Set default billing address to new order.
                if (defaultBillingAddress != null)
                {
                    address = new OrderAddress();
                    CustomerAddress.CopyCustomerAddressToOrderAddress(defaultBillingAddress, address);

                    Cart.OrderAddresses.Add(address);
                    Cart.OrderForms[0].BillingAddressId = address.Name;
                }
            }

            BillingAddressInfo.OrderAddress = address;
            BillingAddressInfo.DataBind();
        }

        /// <summary>
        /// Sets the shipping addresses.
        /// </summary>
        private void SetShippingAddresses()
        {
            OrderAddress address = null;

            var currentContact = CustomerContext.Current.CurrentContact;

            if (Cart.OrderForms[0].Shipments.Count > 0 && !string.IsNullOrEmpty(CartHelper.Cart.OrderForms[0].Shipments[0].ShippingAddressId))
            {
                string shippingAddressId = CartHelper.Cart.OrderForms[0].Shipments[0].ShippingAddressId;

                var customerAddress = currentContact == null ? null : currentContact.ContactAddresses.FirstOrDefault(ca => ca.Name.ToString().Equals(shippingAddressId));
                if (customerAddress != null)
                {
                    address = new OrderAddress();
                    CustomerAddress.CopyCustomerAddressToOrderAddress(customerAddress, address);
                }
                else
                {
                    address = CartHelper.FindAddressByName(shippingAddressId);
                }
            }
            else
            {
                var defaultShippingAdd = currentContact == null ? null : currentContact.ContactAddresses.FirstOrDefault(
                                                                                       a => currentContact.PreferredShippingAddressId.HasValue &&
                                                                                            currentContact.PreferredShippingAddressId.Value == a.PrimaryKeyId.Value);
                // Set default shipping address to new order.
                if (defaultShippingAdd != null)
                {
                    address = new OrderAddress();
                    CustomerAddress.CopyCustomerAddressToOrderAddress(defaultShippingAdd, address);

                    var shipment = Cart.OrderForms[0].Shipments[0];

                    shipment.ShippingAddressId = address.Name;

                    Cart.OrderAddresses.Add(address);
                }
            }

            ShippingAddressInfo.OrderAddress = address;
            ShippingAddressInfo.DataBind();
        }

        /// <summary>
        /// Sets the Shipping Method. 
        /// </summary>
        /// <param name="defaultShippingMethodId">Default shipping method Id</param>
        private void SetShippingMethod(string defaultShippingMethodId)
        {
            string shippingMethodId = string.Empty;
            if (Cart.OrderForms.Count > 0
                && Cart.OrderForms[0].Shipments.Count > 0
                && Cart.OrderForms[0].Shipments.ToArray().FirstOrDefault().ShippingMethodId != null)
            {
                shippingMethodId = Cart.OrderForms[0].Shipments.ToArray().FirstOrDefault().ShippingMethodId.ToString();
            }

            var shippingMethod = !string.IsNullOrEmpty(shippingMethodId) && !shippingMethodId.Equals(Guid.Empty.ToString())
                                                                ? shippingMethodId : defaultShippingMethodId;
            if (!string.IsNullOrEmpty(shippingMethod))
            {
                foreach (ListViewDataItem item in shippingOptions.Items)
                {
                    var rdo = item.FindControl("rdoChooseShipping") as GlobalRadioButton;
                    var hidden = item.FindControl("hiddenShippingId") as HtmlInputControl;
                    if (rdo != null && hidden != null)
                    {
                        if (hidden.Value == shippingMethod)
                        {
                            rdo.Checked = true;
                            ChangeShippingMethod();
                            break;
                        }
                    }
                }
            }
        }
    }
}
