using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.UI.Controllers;
using Mediachase.Commerce;
using Mediachase.Commerce.Customers;
using Mediachase.Commerce.Engine.Template;
using Mediachase.Commerce.Orders;
using Mediachase.Commerce.Orders.Managers;
using Mediachase.Commerce.Security;
using Mediachase.Commerce.Website.Helpers;
using System;
using System.Collections.Generic;
using System.Net.Mail;
using System.Threading;
using Mediachase.Commerce.Orders.Exceptions;
using Mediachase.Commerce.Inventory;
using log4net;

namespace EPiServer.Commerce.Sample.BaseControls
{
    public class CheckoutControl : RendererControlBase<CatalogContentBase>
    {
        protected CartHelper CartHelper = new CartHelper(Cart.DefaultName);
        public const string SessionLatestOrderIdKey = "LatestOrderId";
        public const string SessionLatestOrderNumberKey = "LatestOrderNumber";
        public const string SessionLatestOrderTotalKey = "LatestOrderTotal";
        private const string _storeEmail = "sample@episerver.com";
        private const string _storeTitle = "Sample Commerce";

        private readonly CustomerContact _currentContact = CustomerContext.Current.CurrentContact;

        protected Cart Cart
        {
            get
            {
                return CartHelper.Cart;
            }
        }

        /// <summary>
        /// Sends the order noticfication and confirmation.
        /// </summary>
        /// <param name="order">The order.</param>
        /// <param name="email">The email.</param>
        /// <returns></returns>
        protected bool SendOrderNotificationAndConfirmation(PurchaseOrder order, string email)
        {
            try
            {
                // Add input parameter
                var dic = new Dictionary<string, object>()
                {
                    {"OrderGroup", order}
                };

                // Send out emails
                // Create smtp client
                var client = new SmtpClient();

                var msg = new MailMessage();
                msg.From = new MailAddress(_storeEmail, _storeTitle);
                msg.IsBodyHtml = true;

                // Send confirmation email
                msg.Subject = String.Format("{0}: Order Confirmation for {1}", _storeTitle, order.CustomerName);
                msg.To.Add(new MailAddress(email, order.CustomerName));
                msg.Body = TemplateService.Process("order-purchaseorder-confirm", Thread.CurrentThread.CurrentCulture, dic);

                // send email
                client.Send(msg);
                AddNoteToPurchaseOrder("Order notification send to {0}", order, email);
                order.AcceptChanges();
                return true;
            }
            catch (Exception ex)
            {
                LogManager.GetLogger(this.GetType()).Error(ex.Message, ex);
                return false;
            }
        }

        /// <summary>
        /// Adds the note to purchase order.
        /// </summary>
        /// <param name="note">Name of the note.</param>
        /// <param name="purchaseOrder">The purchase order.</param>
        /// <param name="parmeters">The parmeters.</param>
        protected void AddNoteToPurchaseOrder(string note, PurchaseOrder purchaseOrder, params string[] parmeters)
        {
            var noteDetail = String.Format(note, parmeters);
            OrderNotesManager.AddNoteToPurchaseOrder(purchaseOrder, noteDetail, OrderNoteTypes.System, SecurityContext.Current.CurrentUserId);
        }
        /// <summary>
        /// Places the order.
        /// </summary>
        protected void PlaceOrder()
        {
            MergeShipment();

            // Make sure to execute within transaction
            using (var scope = new Mediachase.Data.Provider.TransactionScope())
            {
                try
                {
                    OrderGroupWorkflowManager.RunWorkflow(Cart, OrderGroupWorkflowManager.CartCheckOutWorkflowName);
                }
                catch (Exception ex)
                {
                    if (ex is PaymentException)
                    {
                        throw ex;
                    }
                    else if (ex.InnerException != null && ex.InnerException is PaymentException)
                    {
                        throw ex.InnerException;
                    }
                }

                Cart.CustomerId = SecurityContext.Current.CurrentUserId;
                var po = Cart.SaveAsPurchaseOrder();

                if (_currentContact != null)
                {
                    _currentContact.LastOrder = po.Created;
                    _currentContact.SaveChanges();
                    Cart.CustomerName = _currentContact.FullName;
                }

                // Add note to purchaseOrder
                AddNoteToPurchaseOrder("New order placed by {0} in {1}", po, SecurityContext.Current.CurrentUserName, "Public site");
                po.AcceptChanges();

                PurchaseOrderManager.UpdatePromotionUsage(Cart, po);

                // Save latest order id
                Session[SessionLatestOrderIdKey] = po.OrderGroupId;
                Session[SessionLatestOrderNumberKey] = po.TrackingNumber;
                Session[SessionLatestOrderTotalKey] = new Money(po.Total, po.BillingCurrency).ToString();

                // Increase the coressponding KPI in CMO.
                IncreaseKpi();

                // Remove old cart
                Cart.Delete();
                Cart.AcceptChanges();

                // Commit changes
                scope.Complete();
            }
        }
        
        /// <summary>
        /// Increases the KPI if placing order successfully.
        /// </summary>
        private void IncreaseKpi()
        {
            CmoGadgetController.IncreaseOrder(CartHelper.LineItems);
        }

        /// <summary>
        /// Merge shipment when shipping address & shipping method is the same.
        /// </summary>
        private void MergeShipment()
        {
            // Combine shipment when input same shipping address & shipping method
            var shipmentToRemove = new List<Shipment>();
            for (int i = 0; i < Cart.OrderForms[0].Shipments.Count - 1; i++)
            {
                for (int j = i + 1; j < Cart.OrderForms[0].Shipments.Count; j++)
                {
                    if (Cart.OrderForms[0].Shipments[i].ShippingAddressId.Equals(Cart.OrderForms[0].Shipments[j].ShippingAddressId) &&
                        Cart.OrderForms[0].Shipments[i].ShippingMethodId.Equals(Cart.OrderForms[0].Shipments[j].ShippingMethodId))
                    {
                        var targetShipment = Cart.OrderForms[0].Shipments[i];
                        var removedShipment = Cart.OrderForms[0].Shipments[j];
                        foreach (var item in removedShipment.LineItemIndexes)
                        {
                            targetShipment.AddLineItemIndex(int.Parse(item), Shipment.GetLineItemQuantity(removedShipment, int.Parse(item)));
                            removedShipment.RemoveLineItemIndex(item);
                        }
                        shipmentToRemove.Add(removedShipment);
                    }
                }
            }
            foreach (var shipment in shipmentToRemove)
            {
                shipment.Delete();
            }

            Cart.AcceptChanges();
        }

        protected bool ShouldSetStoreAsPickupAddressForShipment(IWarehouse warehouse, Shipment shipment)
        {
            if (warehouse.IsPickupLocation)
            {
                if (!warehouse.IsFulfillmentCenter)
                {
                    return true;
                }
                else
                {
                    return ShippingManager.IsHandoffShippingMethod(shipment.ShippingMethodName);
                }
            }
            return false;
        }
    }
}
