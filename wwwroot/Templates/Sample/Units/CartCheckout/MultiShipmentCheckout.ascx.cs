using EPiServer.Commerce.Sample.BaseControls;
using EPiServer.Commerce.Sample.Helpers;
using EPiServer.Commerce.Sample.Templates.Sample.Units.CartCheckout.SharedModules;
using EPiServer.Security;
using Mediachase.Commerce.Customers;
using Mediachase.Commerce.Inventory;
using Mediachase.Commerce.Orders;
using Mediachase.Commerce.Orders.Exceptions;
using Mediachase.Commerce.Orders.Managers;
using Mediachase.Commerce.Security;
using Mediachase.Commerce.Website;
using Mediachase.MetaDataPlus;
using System;
using System.Linq;
using EPiServer.Editor;
using Mediachase.Commerce.Core;
using EPiServer.Core;
using EPiServer.Web.Routing;
using System.Collections.Generic;


namespace EPiServer.Commerce.Sample.Templates.Sample.Units.CartCheckout
{
    public partial class MultiShipmentCheckout : CheckoutControl
    {


        /// <summary>
        /// Get the single shipment page link.
        /// </summary>
        protected string SingleShipmentPageUrl
        {
            get {
                var singleShipmentPage = CurrentPage.Property["SingleShipmentCheckout"].Value as PageReference;
                return GetUrl(singleShipmentPage, SiteContext.Current.LanguageName);
            }
        }

        #region Event Handlers
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

            Initialize();

            var errorMessage = Session[Constants.CheckoutCartErrorName] as string;
            if (!string.IsNullOrEmpty(errorMessage))
            {
                ErrorManager.GenerateError(errorMessage);
                Session.Remove(Constants.CheckoutCartErrorName);
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
        /// Merge shipment when shipping address & shipping method is the same.
        /// </summary>
        private void MergeShipment()
        {
            var form = Cart.OrderForms[0];

            // Combine shipment when input same shipping address & shipping method
            var shipmentToRemove = new List<Shipment>();
            for (int i = 0; i < form.Shipments.Count - 1; i++)
            {
                for (int j = i + 1; j < form.Shipments.Count; j++)
                {
                    if (form.Shipments[i].ShippingAddressId.Equals(form.Shipments[j].ShippingAddressId) &&
                        form.Shipments[i].ShippingMethodId.Equals(form.Shipments[j].ShippingMethodId))
                    {
                        var targetShipment = form.Shipments[i];
                        var removedShipment = form.Shipments[j];
                        foreach (var item in removedShipment.LineItemIndexes)
                        {
                            var lineItem = form.LineItems[Convert.ToInt32(item)];
                            if (lineItem != null)
                            {
                                // Get quantity with line item id.
                                targetShipment.AddLineItemIndex(int.Parse(item), Shipment.GetLineItemQuantity(removedShipment, lineItem.LineItemId));
                                removedShipment.RemoveLineItemIndex(item);
                            }
                        }
                        shipmentToRemove.Add(removedShipment);
                    }
                }
            }
            foreach (var shipment in shipmentToRemove)
            {
                shipment.Delete();
            }

            OrderGroupWorkflowManager.RunWorkflow(Cart, OrderGroupWorkflowManager.OrderCalculateTotalsWorflowName);

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
                var billingAddressId = Cart.OrderForms[0].BillingAddressId;
                var billingAddress = Cart.OrderAddresses.ToArray().FirstOrDefault(x => x.Name.Equals(billingAddressId));
                if (billingAddress == null)
                {
                    ErrorManager.GenerateError("Billing Address is not defined.");
                    return;
                }

                var shipmentIndex = 1;
                foreach (Shipment shipment in Cart.OrderForms[0].Shipments)
                {
                    if (string.IsNullOrEmpty(shipment.ShippingAddressId))
                    {
                        ErrorManager.GenerateError(string.Format("In Shipment part {0}, Shipping Address is not defined. ", shipmentIndex));
                        return;
                    }
                    var shippingAddress = Cart.OrderAddresses.ToArray().FirstOrDefault(x => x.Name.Equals(shipment.ShippingAddressId));
                    if (shippingAddress == null)
                    {
                        ErrorManager.GenerateError(string.Format("In Shipment part {0}, Shipping Address is not defined. ", shipmentIndex));
                        return;
                    }

                    var dto = ShippingManager.GetShippingMethod(shipment.ShippingMethodId);
                    if (dto != null && dto.ShippingMethod != null && dto.ShippingMethod.Count > 0)
                    {
                        shipment.ShippingMethodId = dto.ShippingMethod[0].ShippingMethodId;
                        shipment.ShippingMethodName = dto.ShippingMethod[0].Name;
                    }
                    else
                    {
                        ErrorManager.GenerateError(string.Format("In Shipment part {0}, Please choose a shipping method. ", shipmentIndex));
                        return;
                    }
                    shipmentIndex++;
                }

                // Merge shipments before create payments.
                MergeShipment();

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
            catch (OrderException ex)
            {
                //Keep error message before redirect page
                Session.Add(Constants.CheckoutCartErrorName, ex.Message);
                Context.RedirectFast(Request.RawUrl);
                return;
            }

            Session.Remove(Constants.LastCouponCode);
            Session.Remove(Constants.CheckoutCartErrorName);
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
        /// Default bind data method.
        /// </summary>
        private void BindDataSplitShipment()
        {
            lvSplitShipment.DataSource = Cart.OrderForms[0].Shipments;
            lvSplitShipment.DataBind();

            var defaultShippingAddress = GetDefaultShippingAddresses();
            var shipmentIndex = 0;
            OrderAddress address = null;
            var cartOrderAddress = Cart.OrderAddresses.ToArray();

            foreach (var item in lvSplitShipment.Items)
            {
                address = GetShippingAddress(shipmentIndex) ?? defaultShippingAddress;
                if (address != null)
                {
                    CartHelper.Cart.OrderForms[0].Shipments[shipmentIndex].ShippingAddressId = address.Name;
                    if (!cartOrderAddress.Any(oa => oa.Name == address.Name))
                    {
                        Cart.OrderAddresses.Add(address);
                    }
                }

                var itemControl = item.FindControl("SplitShipmentControlID");
                if (itemControl != null)
                {
                    (itemControl as SplitShipmentControl).SetShippingAddresses(address);
                }
                shipmentIndex++;
            }
        }

        /// <summary>
        /// Create split shipment for the first time.
        /// </summary>
        private void CreateDataSplitShipment()
        {
            // Create shipment for each lineitem for the first time to demo showcase multishipment.
            if (Cart.OrderForms.Count > 0)
            {
                var lineItems = Cart.OrderForms[0].LineItems.Where(lineItem => !lineItem.IsGiftItem()).ToList();
                //In case of redirection (eg. from a checkout error), we keep all shipments's status.
                string error = Session[Constants.CheckoutCartErrorName] as string;
                if (Cart.OrderForms[0].Shipments.Count != lineItems.Count() && string.IsNullOrEmpty(error))
                {
                    foreach (MetaObject shipment in Cart.OrderForms[0].Shipments)
                    {
                        shipment.Delete();
                    }

                    foreach (LineItem lineItem in lineItems)
                    {
                        Shipment shipment = new Shipment();
                        shipment.CreatorId = PrincipalInfo.CurrentPrincipal.GetContactId().ToString();
                        shipment.Created = DateTime.UtcNow;
                        shipment.AddLineItemIndex(lineItems.IndexOf(lineItem), lineItem.Quantity);
                        shipment.WarehouseCode = lineItem.WarehouseCode;

                        // For Shipping method "In store pickup"
                        IWarehouse warehouse = WarehouseHelper.GetWarehouse(lineItem.WarehouseCode);
                        if (!warehouse.IsFulfillmentCenter && warehouse.IsPickupLocation)
                        {
                            if (CartHelper.FindAddressByName(warehouse.Name) == null)
                            {
                                var address = warehouse.ContactInformation.ToOrderAddress();
                                address.Name = warehouse.Name;
                                Cart.OrderAddresses.Add(address);
                            }

                            shipment.ShippingAddressId = warehouse.Name;
                            shipment.ShippingMethodName = ShippingManager.PickupShippingMethodName;

                            var instorepickupShippingMethod = ShippingManager.GetShippingMethodsByMarket(CurrentMarket.GetCurrentMarket().MarketId.Value, false).ShippingMethod.ToArray().Where(m => m.Name.Equals(ShippingManager.PickupShippingMethodName)).FirstOrDefault();
                            if (instorepickupShippingMethod != null)
                            {
                                shipment.ShippingMethodId = instorepickupShippingMethod.ShippingMethodId;
                            }
                        }

                        Cart.OrderForms[0].Shipments.Add(shipment);
                    }
                }

                Cart.AcceptChanges();
            }
        }

        /// <summary>
        /// Initialize the page
        /// </summary>
        private void Initialize()
        {
            // Need to Set BillingAddress before getting ShippingAddress to get the correct Billing Address.
            SetBillingAddresses();
            CreateDataSplitShipment();

            foreach (Shipment shipment in Cart.OrderForms[0].Shipments)
            {
                // Shipping method is "In store pickup", add warehouse address to Cart & Shipment
                if (ShippingManager.IsHandoffShippingMethod(shipment.ShippingMethodName) && !string.IsNullOrEmpty(shipment.WarehouseCode))
                {
                    IWarehouse warehouse = WarehouseHelper.GetWarehouse(shipment.WarehouseCode);
                    if (warehouse != null && ShouldSetStoreAsPickupAddressForShipment(warehouse, shipment))
                    {
                        SetStoreAsPickupAddressForShipment(warehouse, shipment);
                    }
                }
            }

            BindDataSplitShipment();
        }
        #endregion

        #region Helper Methods
        /// <summary>
        /// Sets the billing addresses.
        /// </summary>
        private void SetBillingAddresses()
        {
            OrderAddress address = null;

            if (Cart.OrderAddresses.ToArray().Length > 0)
            {
                string billingAddressId = CartHelper.Cart.OrderForms[0].BillingAddressId;
                if (!string.IsNullOrEmpty(billingAddressId))
                {
                    address = CartHelper.FindAddressByName(billingAddressId);
                }
            }

            if (address == null)
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
        /// Gets the default shipping addresses.
        /// </summary>
        private OrderAddress GetDefaultShippingAddresses()
        {
            OrderAddress address = null;

            var currentContact = CustomerContext.Current.CurrentContact;
            {
                var defaultShippingAdd = currentContact == null ? null : currentContact.ContactAddresses.FirstOrDefault(
                                                                                       a => currentContact.PreferredShippingAddressId.HasValue &&
                                                                                            currentContact.PreferredShippingAddressId.Value == a.PrimaryKeyId.Value);
                // Set default shipping address to new order.
                if (defaultShippingAdd != null)
                {
                    address = new OrderAddress();
                    CustomerAddress.CopyCustomerAddressToOrderAddress(defaultShippingAdd, address);
                }
            }

            return address;
        }

        /// <summary>
        /// Get shipping address
        /// </summary>
        /// <param name="shipmentIndex">Shipment Index</param>
        /// <returns></returns>
        private OrderAddress GetShippingAddress(int shipmentIndex)
        {
            OrderAddress address = null;

            var currentContact = CustomerContext.Current.CurrentContact;

            if (Cart.OrderForms[0].Shipments.Count > 0 && !string.IsNullOrEmpty(CartHelper.Cart.OrderForms[0].Shipments[shipmentIndex].ShippingAddressId))
            {
                string shippingAddressId = CartHelper.Cart.OrderForms[0].Shipments[shipmentIndex].ShippingAddressId;

                var cusomterAddress = currentContact == null ? null : currentContact.ContactAddresses.FirstOrDefault(ca => ca.Name.ToString().Equals(shippingAddressId));
                if (cusomterAddress != null)
                {
                    address = new OrderAddress();
                    CustomerAddress.CopyCustomerAddressToOrderAddress(cusomterAddress, address);
                }
                else
                {
                    address = CartHelper.FindAddressByName(shippingAddressId);
                }
            }

            return address;
        }
        #endregion
    }
}
