using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Sample.BaseControls;
using Mediachase.Commerce.Orders;
using System;
using System.Collections.Generic;
using System.Linq;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.AccountManagement
{

    public partial class OrderDetailsSingleShipment : RendererControlBase<CatalogContentBase>
    {       
        public PurchaseOrder OrderDetail { get; set; }

        private readonly List<LineItem> LineItems = new List<LineItem>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (OrderDetail == null)
            {
                Context.RedirectFast(GetUrl(Settings.YourOrdersPage));
                return;
            }

            //Set Billing and Shipping Address
            BillAddressInfo.OrderAddress = OrderDetail.OrderAddresses.ToArray().FirstOrDefault(x => x.Name == FirstOrderForm.BillingAddressId);
            ShipAddressInfo.OrderAddress = OrderDetail.OrderAddresses.ToArray().FirstOrDefault(x => x.Name == FirstOrderForm.Shipments[0].ShippingAddressId 
                                                                                            || x.OrderGroupAddressId.ToString() == FirstOrderForm.Shipments[0].ShippingAddressId);

            //Set Coupons
            CouponsInfoID.OrderDetail = OrderDetail;

            //Set LineItems 
            foreach (var item in FirstOrderForm.LineItems.ToArray())
            {
                LineItems.Add(item);
            }

            LineItemsSimpleInfoID.OrderLineItems = LineItems;
            LineItemsSimpleInfoID.BillingCurrency = OrderDetail.BillingCurrency;

            //Set Shipping Method
            ShippingMethodInfoID.Shipment = FirstOrderForm.Shipments[0];
            ShippingMethodInfoID.BillingCurrency = OrderDetail.BillingCurrency;
            //Set Payment information
            PaymentInfoID.PaymentInfos = FirstOrderForm.Payments;

            //Set SubLine data
            OrderSubtotalSimpleInfoID.OrderDetail = OrderDetail;

        }

        /// <summary>
        /// Gets the order form collection
        /// </summary>
        protected OrderFormCollection OrderForms
        {
            get
            {
                    return OrderDetail.OrderForms;

            }
        }

        /// <summary>
        /// Gets the first order form
        /// </summary>
        protected OrderForm FirstOrderForm
        {
            get
            {
                if (OrderForms == null || OrderForms.Count == 0)
                {
                    return null;
                }
                return OrderForms[0];
            }
        }

    }
}