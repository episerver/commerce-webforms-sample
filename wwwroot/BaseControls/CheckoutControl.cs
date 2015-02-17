using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.UI.Controllers;
using EPiServer.Security;
using Mediachase.Commerce;
using Mediachase.Commerce.Customers;
using Mediachase.Commerce.Engine.Template;
using Mediachase.Commerce.Orders;
using Mediachase.Commerce.Orders.Managers;
using Mediachase.Commerce.Security;
using Mediachase.Commerce.Website.Helpers;
using System;
using System.Linq;
using System.Collections.Generic;
using System.Net.Mail;
using System.Threading;
using Mediachase.Commerce.Orders.Exceptions;
using Mediachase.Commerce.Inventory;
using log4net;
using Mediachase.Commerce.Core;
using Mediachase.Commerce.Orders.Dto;
using Mediachase.Commerce.Marketing;

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
            OrderNotesManager.AddNoteToPurchaseOrder(purchaseOrder, noteDetail, OrderNoteTypes.System, PrincipalInfo.CurrentPrincipal.GetContactId());
        }

        /// <summary>
        /// Places the order.
        /// </summary>
        protected void PlaceOrder()
        {
            // Make sure that items are still valid before ordering.
            var workflowResult = OrderGroupWorkflowManager.RunWorkflow(Cart, OrderGroupWorkflowManager.CartValidateWorkflowName);
            var workflowResultMessage = OrderGroupWorkflowManager.GetWarningsFromWorkflowResult(workflowResult);
            if (workflowResultMessage.Count() > 0)
            {
                Cart.AcceptChanges();
                // Throw exception in case there are any changed when valid cart.
                throw new OrderException(workflowResultMessage.Aggregate((current, next) => current + ", " + next));
            }

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

                Cart.CustomerId = PrincipalInfo.CurrentPrincipal.GetContactId();
                var po = Cart.SaveAsPurchaseOrder();

                if (_currentContact != null)
                {
                    _currentContact.LastOrder = po.Created;
                    _currentContact.SaveChanges();
                    Cart.CustomerName = _currentContact.FullName;
                }

                // Add note to purchaseOrder
                AddNoteToPurchaseOrder("New order placed by {0} in {1}", po, PrincipalInfo.CurrentPrincipal.Identity.Name, "Public site");
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
        /// Check shipment and warehouse used as Store pickup or not.
        /// </summary>
        /// <param name="warehouse">The warehouse.</param>
        /// <param name="shipment">The shipment.</param>
        protected bool ShouldSetStoreAsPickupAddressForShipment(IWarehouse warehouse, Shipment shipment)
        {
            if (warehouse != null && warehouse.IsPickupLocation)
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

        /// <summary>
        /// Set address when Use Store pickup
        /// </summary>
        /// <param name="warehouse">The warehouse.</param>
        /// <param name="shipment">The shipment.</param>
        protected void SetStoreAsPickupAddressForShipment(IWarehouse warehouse, Shipment shipment)
        {
            if (warehouse != null)
            {
                shipment.WarehouseCode = warehouse.Code;
                if (CartHelper.FindAddressByName(warehouse.Name) == null)
                {
                    var address = warehouse.ContactInformation.ToOrderAddress();
                    address.Name = warehouse.Name;
                    Cart.OrderAddresses.Add(address);
                }
                shipment.ShippingAddressId = warehouse.Name;
                shipment.ShippingMethodName = ShippingManager.PickupShippingMethodName;
                var instorepickupShippingMethod = ShippingManager.GetShippingMethods(SiteContext.Current.LanguageName).ShippingMethod.ToArray().Where(m => m.Name.Equals(ShippingManager.PickupShippingMethodName)).FirstOrDefault();
                if (instorepickupShippingMethod != null)
                {
                    shipment.ShippingMethodId = instorepickupShippingMethod.ShippingMethodId;
                }
                Cart.AcceptChanges();
            }
        }

        /// <summary>
        /// Change shipping method.
        /// </summary>
        /// <param name="shipment">The shipment.</param>
        /// <param name="shippingMethodId">The shipping method Id.</param>
        protected void ChangeShippingMethod(Shipment shipment, string shippingMethodId)
        {
            var oldShipmentMethod = shipment.ShippingMethodId;
            var oldShipmentMethodName = string.Empty;
            ShippingMethodDto oldDto = ShippingManager.GetShippingMethod(oldShipmentMethod);
            if (oldDto != null && oldDto.ShippingMethod != null && oldDto.ShippingMethod.Count > 0)
            {
                oldShipmentMethodName = oldDto.ShippingMethod[0].Name;
            }

            shipment.ShippingMethodId = new Guid(shippingMethodId);
            ShippingMethodDto dto = ShippingManager.GetShippingMethod(shipment.ShippingMethodId);
            if (dto != null && dto.ShippingMethod != null && dto.ShippingMethod.Count > 0)
            {
                shipment.ShippingMethodName = dto.ShippingMethod[0].Name;
            }

            if (ShippingManager.IsHandoffShippingMethod(oldShipmentMethodName) && !ShippingManager.IsHandoffShippingMethod(shipment.ShippingMethodName))
            {
                shipment.ShippingAddressId = String.Empty;
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

    }
}
