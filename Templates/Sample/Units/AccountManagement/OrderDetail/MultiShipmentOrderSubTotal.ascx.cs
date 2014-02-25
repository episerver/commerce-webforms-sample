using System;
using EPiServer.Commerce.Sample.BaseControls;
using Mediachase.Commerce;
using Mediachase.Commerce.Core;
using Mediachase.Commerce.Orders;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.AccountManagement.OrderDetail
{
    public partial class MultiShipmentOrderSubTotal : SampleStoreUserControlBase
    {
        public Currency BillingCurrency { get; set; }

        public Shipment SplitShipment { get; set; }

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            SubTotalDataBind();
        }

        /// <summary>
        /// Data bind.
        /// </summary>
        private void SubTotalDataBind()
        {
            if (SplitShipment != null)
            {
                OrderSubTotalLineItems.Text = new Money(SplitShipment.SubTotal, BillingCurrency).ToString();
                string discountMessage = String.Empty;
                Money shippingDiscountsTotal = CalculateShippingDiscounts(SplitShipment, BillingCurrency, out discountMessage);
                Money shippingCostSubTotal = new Money(SplitShipment.ShipmentTotal, BillingCurrency);
                shippingDiscount.Text = shippingDiscountsTotal.ToString();
                ShippingDiscountsMessage.Text = discountMessage;
                shippingTotal.Text = (shippingCostSubTotal).ToString();
            }
            else
            {
                string zeroMoney = new Money(0, SiteContext.Current.Currency).ToString();
                shippingDiscount.Text = zeroMoney;
                shippingTotal.Text = zeroMoney;
            }
        }
    }
}