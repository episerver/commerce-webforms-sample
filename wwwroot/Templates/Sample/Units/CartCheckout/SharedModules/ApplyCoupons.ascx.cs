using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using Mediachase.Commerce.Marketing;
using Mediachase.Commerce.Orders;
using Mediachase.Commerce.Website;
using Mediachase.Commerce.Website.Helpers;


namespace EPiServer.Commerce.Sample.Templates.Sample.Units.CartCheckout.SharedModules
{
    public partial class ApplyCoupons : UserControlBase
    {
        /// <summary>
        /// Allow apply/remove coupon or not.
        /// </summary>
        /// <value>AllowEditCoupons.</value>
        private bool _allowEditCoupons = true;
        public bool AllowEditCoupons 
        {
            get { return _allowEditCoupons; }
            set { _allowEditCoupons = value; }
        }

        /// <summary>
        /// The _cart helper
        /// </summary>
        private readonly CartHelper _cartHelper = new CartHelper(Cart.DefaultName);

        private readonly List<Discount> _discounts = new List<Discount>();

        /// <summary>
        /// Gets the cart helper.
        /// </summary>
        /// <value>The cart helper.</value>
        public CartHelper CartHelper
        {
            get { return _cartHelper; }
        }

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs" /> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            ApplyCouponForm.Visible = AllowEditCoupons;

            //lvDiscount.ItemCommand += new EventHandler<ListViewCommandEventArgs>(lvDiscount_ItemCommand);
            BindDiscountListView();

            ValidateCouponCode();
        }

        /// <summary>
        /// Validates the coupon code.
        /// </summary>
        private void ValidateCouponCode()
        {
            var couponCode = Session[Constants.LastCouponCode] as string;

            if (couponCode == null)
            {
                return;
            }

            if (IsPostBack || string.IsNullOrEmpty(couponCode))
                return;

            // Return an error message dialog when Coupon code is invalid
            if (_discounts.Count == 0 || !_discounts.Exists(d => d.DiscountCode.Equals(couponCode, StringComparison.OrdinalIgnoreCase)))
            {
                ErrorManager.GenerateError(string.Format("{0} is an invalid Coupon code.", couponCode));
                Session.Remove(Constants.LastCouponCode);
            }
        }

        /// <summary>
        /// Handles the ItemCommand event of the lvDiscount control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.ListViewCommandEventArgs"/> instance containing the event data.</param>
        protected void lvDiscount_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (!e.CommandName.Equals("DeleteCoupon"))
                return;

            var couponCode = e.CommandArgument.ToString();

            foreach (OrderForm form in CartHelper.Cart.OrderForms)
            {
                var formDiscount = form.Discounts.Cast<Discount>().Where(x => couponCode.Equals(x.DiscountCode));
                foreach (var discount in formDiscount)
                {
                    discount.Delete();
                }

                foreach (LineItem lineItem in form.LineItems)
                {
                    var lineItemDiscount = lineItem.Discounts.Cast<Discount>().Where(x => couponCode.Equals(x.DiscountCode));
                    foreach (var discount in lineItemDiscount)
                    {
                        discount.Delete();
                    }
                }

                foreach (Shipment shipment in form.Shipments)
                {
                    var shipmentDiscount = shipment.Discounts.Cast<Discount>().Where(x => couponCode.Equals(x.DiscountCode));
                    foreach (var discount in shipmentDiscount)
                    {
                        shipment.ShippingDiscountAmount -= discount.DiscountValue;
                        // Pending testing, this might need to be changed to summing ShippingDiscountAmount before removing them,
                        //  and then adding that sum back to form.ShippingTotal (since CalculateTotalsActivity simply does
                        //  shipment.ShipmentTotal - shipment.ShippingDiscountAmount without checking for custom discounts)
                        form.ShippingTotal += discount.DiscountValue;

                        discount.Delete();
                    }
                }
            }
            CartHelper.Cart.ProviderId = "FrontEnd";
            CartHelper.RunWorkflow(Constants.CartValidateWorkflowName);
            CartHelper.Cart.AcceptChanges();

            Session.Remove(Constants.LastCouponCode);

            Context.RedirectFast(Request.RawUrl);

        }

        /// <summary>
        /// Handles the Click event of the ApplyCouponButton control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void ApplyCouponButton_Click(object sender, EventArgs e)
        {
            MarketingContext.Current.AddCouponToMarketingContext(DiscountCouponCode.Text);

            var isEmpty = CartHelper.IsEmpty;

            // Make sure to check that prices has not changed
            if (!isEmpty)
            {
                CartHelper.Cart.ProviderId = "FrontEnd";
                CartHelper.RunWorkflow(Constants.CartValidateWorkflowName);

                CartHelper.Cart.AcceptChanges();
            }


            Session[Constants.LastCouponCode] = DiscountCouponCode.Text;
            Context.RedirectFast(Request.RawUrl);
        }


        /// <summary>
        /// Add discount item to lvDiscount.
        /// </summary>
        /// <param name="discount"> The discount.</param>
        private void AddToDiscountList(Discount discount)
        {
            if (!_discounts.Exists(x => x.DiscountCode.Equals(discount.DiscountCode)))
            {
                _discounts.Add(discount);
            }
        }

        /// <summary>
        /// Binds the discount list view.
        /// </summary>
        private void BindDiscountListView()
        {
            foreach (OrderForm form in CartHelper.Cart.OrderForms)
            {
                foreach (var discount in form.Discounts.Cast<Discount>().Where(x => !String.IsNullOrEmpty(x.DiscountCode)))
                {
                    AddToDiscountList(discount);
                }

                foreach (LineItem item in form.LineItems)
                {
                    foreach (var discount in item.Discounts.Cast<Discount>().Where(x => !String.IsNullOrEmpty(x.DiscountCode)))
                    {
                        AddToDiscountList(discount);
                    }
                }

                foreach (Shipment shipment in form.Shipments)
                {
                    foreach (var discount in shipment.Discounts.Cast<Discount>().Where(x => !String.IsNullOrEmpty(x.DiscountCode)))
                    {
                        AddToDiscountList(discount);
                    }
                }
            }

            lvDiscount.DataSource = _discounts;
            lvDiscount.DataBind();
        }
    }
}