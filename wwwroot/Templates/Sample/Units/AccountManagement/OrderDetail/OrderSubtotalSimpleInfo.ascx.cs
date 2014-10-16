using Mediachase.Commerce;
using Mediachase.Commerce.Orders;
using System;
using System.Linq;
using EPiServer.Commerce.Sample.BaseControls;
using Mediachase.Commerce.Core;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.AccountManagement.OrderDetail
{
    public partial class OrderSubtotalSimpleInfo : SampleStoreUserControlBase
    {
        public PurchaseOrder OrderDetail { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (OrderDetail != null)
            {
                BindSubTotal();
            }
        }

        private void BindSubTotal()
        {
            string discountMessage = String.Empty;
            Money shippingDiscountsTotal = CalculateShippingDiscounts(OrderDetail.OrderForms[0].Shipments, OrderDetail.BillingCurrency, out discountMessage);
            ShippingDiscount.Text = shippingDiscountsTotal.ToString();
            ShippingDiscountsMessage.Text = discountMessage;

            Money shippingCostSubTotal = new Money(OrderDetail.OrderForms[0].Shipments.Cast<Shipment>().Sum(x => x.ShipmentTotal), OrderDetail.BillingCurrency);
            ShippingTotal.Text = (shippingCostSubTotal).ToString();

            SubTotal.Text = new Money(OrderDetail.OrderForms[0].LineItems.ToArray().Sum(x => x.ExtendedPrice), OrderDetail.BillingCurrency).ToString();
            Taxes.Text = new Money(OrderDetail.TaxTotal, OrderDetail.BillingCurrency).ToString();
            Total.Text = new Money(OrderDetail.Total, OrderDetail.BillingCurrency).ToString();
        }
    }
}
