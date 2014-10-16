using System.Linq;
using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Sample.BaseControls;
using Mediachase.Commerce.Orders;
using Mediachase.Commerce.Website.Helpers;
using System;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.CartCheckout
{
    public partial class CartSimpleModule : RendererControlBase<CatalogContentBase>
    {
        #region Fields
        private readonly CartHelper _cartHelper = new CartHelper(Mediachase.Commerce.Orders.Cart.DefaultName);
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

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!CartHelper.IsEmpty)
                {
                    BindData();
                }
            }
        }

        /// <summary>
        /// Handles the PreRender event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        /// <remarks>The logic needs to happen here since the cart can change significantly after the Load event of this page. 
        /// For example, you can add an entry that is (from a UI viewpoint) immediately removed by a workflow like CartValidateWorkflow, leaving you with an empty cart, 
        /// but this page would not know about that.</remarks>
        protected void Page_PreRender(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!CartHelper.IsEmpty)
                {
                    cartDetails.Visible = true;
                }
                else
                {
                    cartDetails.Visible = false;
                }
            }
        }

        /// <summary>
        /// Handles the Click event of the ContinueButton control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void ContinueButton_Click(object sender, EventArgs e)
        {
            var lastCatalogPageUrl = Session[Constants.LastCatalogPageUrl] as string;

            Context.RedirectFast(String.IsNullOrEmpty(lastCatalogPageUrl) ? "~/" : lastCatalogPageUrl);

        }

        /// <summary>
        /// Handles the Click event of the CheckoutButton control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void CheckoutButton_Click(object sender, EventArgs e)
        {
            Context.RedirectFast(GetUrl(Settings.CheckoutPage));
        }

        /// <summary>
        /// Default bind data method.
        /// </summary>
        private void BindData()
        {
            // If Shipment have been created, clear Shipment to continue shopping.
            if (CartHelper.Cart.OrderForms.Count > 0 && CartHelper.Cart.OrderForms[0].Shipments.Count >= 1)
            {
                foreach (Shipment shipment in CartHelper.Cart.OrderForms[0].Shipments)
                {
                    string couponCode = Session[Constants.LastCouponCode] as string;

                    if (!String.IsNullOrEmpty(couponCode))
                    {
                        ShipmentDiscount shipmentDiscountWithCouponCode = shipment.Discounts.Cast<ShipmentDiscount>().FirstOrDefault(x => x.DiscountCode.Equals(couponCode));
                        if (shipmentDiscountWithCouponCode != null)
                        {
                            Session.Remove(Constants.LastCouponCode);
                        }
                    }

                    shipment.Delete();
                }
                foreach (OrderAddress address in CartHelper.Cart.OrderAddresses)
                {
                    address.Delete();
                }
            }

            var isEmpty = CartHelper.IsEmpty;
            if (isEmpty)
                CartHelper.Delete();

            CartHelper.Cart.AcceptChanges();
        }
        #endregion
    }
}