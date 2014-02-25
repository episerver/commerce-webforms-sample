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
    public partial class OrderSubtotalSimpleView : SampleStoreUserControlBase
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
            if (CartHelper.IsEmpty)
                return;
            var billingCurrency = CartHelper.Cart.BillingCurrency;
            OrderSubTotalLineItems.Text = new Money(CartHelper.LineItems.ToArray().Sum(x => x.ExtendedPrice) +
                CartHelper.LineItems.ToArray().Sum(x => x.OrderLevelDiscountAmount), billingCurrency).ToString();

            OrderDiscount.Text = new Money(CartHelper.Cart.OrderForms[0].Discounts.Cast<Discount>().ToArray().Sum(x => x.DiscountValue), billingCurrency).ToString();
            OrderSubTotal.Text = new Money(CartHelper.LineItems.ToArray().Sum(x => x.ExtendedPrice), billingCurrency).ToString();
            TaxTotal.Text = new Money(CartHelper.Cart.TaxTotal, billingCurrency).ToString();

            var shipments = CartHelper.OrderForm.Shipments;
            
            // Check shipping information is full or not.
            bool canShip = shipments.Count > 0;
            if (shipments.ToArray().Any(s => CartHelper.FindAddressByName(s.ShippingAddressId) == null ||
                                             s.ShippingMethodId.Equals(Guid.Empty)))
            {
                canShip = false;
            }

            // Showing the Total and calculate shipping cost/discount only when shipping information is full. Otherwise, only showing SubTotal.
            if (canShip)
            {
                string discountMessage = String.Empty;
                var shippingDiscountsTotal = CalculateShippingDiscounts(shipments, billingCurrency, out discountMessage);
                var shippingCostSubTotal = CalculateShippingCostSubTotal(shipments, CartHelper);
                shippingDiscount.Text = shippingDiscountsTotal.ToString();
                ShippingDiscountsMessage.Text = discountMessage;
                shippingTotal.Text = (shippingCostSubTotal).ToString();
                OrderTotal.Text = new Money(CartHelper.OrderForm.Total, billingCurrency).ToString();
            }
            else
            {
                string zeroMoney = new Money(0, billingCurrency).ToString();
                shippingDiscount.Text = zeroMoney;
                shippingTotal.Text = zeroMoney;
                OrderTotal.Text = new Money(CartHelper.OrderForm.SubTotal, billingCurrency).ToString();
            }

            var orderDiscounts = "";
            foreach (OrderFormDiscount dis in CartHelper.Cart.OrderForms[0].Discounts)
                orderDiscounts += String.Format("<strong>{0}</strong><br />", dis.DisplayMessage);
            OrderDiscountsMessage.Text = orderDiscounts;

        }

        #endregion
    }
}