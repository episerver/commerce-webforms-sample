using System;
using System.Linq;
using EPiServer.Commerce.Sample.BaseControls;
using EPiServer.Commerce.Sample.Helpers;
using Mediachase.Commerce;
using Mediachase.Commerce.Core;
using Mediachase.Commerce.Orders;
using Mediachase.Commerce.Orders.Managers;
using Mediachase.Commerce.Website.Helpers;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.CartCheckout.SharedModules
{
    public partial class OrderSubtotalMultiView : SampleStoreUserControlBase
    {
        #region Fields

        private readonly CartHelper _cartHelper = new CartHelper(Cart.DefaultName);
        private bool _isCheckout;

        #endregion

        #region Properties

        /// <summary>
        /// Gets the cart helper.
        /// </summary>
        /// <value>The cart helper.</value>
        public CartHelper CartHelper
        {
            get { return _cartHelper; }
        }

        /// <summary>
        /// Sets a value indicating whether this instance is checkout.
        /// </summary>
        /// <value>
        /// 	<c>true</c> if this instance is checkput; otherwise, <c>false</c>.
        /// </value>
        public bool IsCheckout
        {
            set { _isCheckout = value; }
        }

        public Shipment SplitShipment { get; set; }
        #endregion

        #region Page Lifecycle Event Handlers

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!_isCheckout)
                taxAndShipping.Visible = taxSeperator.Visible = false;

            DataBind();
        }
        #endregion

        #region Event Handlers

        public override void DataBind()
        {
            var splitLineItems = Shipment.GetShipmentLineItems(SplitShipment);
            var billingCurrency = CartHelper.Cart.BillingCurrency;
            if (splitLineItems != null)
            {
                OrderSubTotalLineItems.Text = new Money(splitLineItems.ToArray().Sum(x => x.ExtendedPrice) +
                    splitLineItems.ToArray().Sum(x => x.OrderLevelDiscountAmount), billingCurrency).ToString();
            }
            if (SplitShipment != null)
            {
                string discountMessage = String.Empty;
                var shippingDiscountsTotal = CalculateShippingDiscounts(SplitShipment, billingCurrency, out discountMessage);
                var shippingCostSubTotal = CalculateShippingCostSubTotal(SplitShipment, CartHelper);
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

        #endregion
    }
}