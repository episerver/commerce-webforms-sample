using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Sample.BaseControls;
using EPiServer.Commerce.Sample.Helpers;
using Mediachase.Commerce;
using Mediachase.Commerce.Catalog;
using Mediachase.Commerce.Catalog.Managers;
using Mediachase.Commerce.Orders;
using Mediachase.Commerce.Website.Helpers;
using System;
using System.Linq;
using System.Web.UI.WebControls;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.AccountManagement
{
    public partial class YourWishList : RendererControlBase<CatalogContentBase>
    {
        #region Fields
        private readonly CartHelper _wishListHelper = new CartHelper(CartHelper.WishListName);
        #endregion

        #region Properties
        /// <summary>
        /// Gets the cart helper.
        /// </summary>
        /// <value>The cart helper.</value>
        public CartHelper WishListHelper
        {
            get { return _wishListHelper; }
        }
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            CartItemsList.ItemCreated += (CartItemsList_ItemCreated);
            CartItemsList.ItemCommand += (CartItemsList_ItemCommand);

            BindData();
        }

        #region Event Handlers
        /// <summary>
        /// Handles the ItemCreated event of the CartItemsList control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.RepeaterItemEventArgs"/> instance containing the event data.</param>
        protected void CartItemsList_ItemCreated(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem)
            {
                return;
            }

            var lvDataItem = e.Item;
            if (lvDataItem == null || lvDataItem.DataItem == null)
                return;

            var li = (LineItem)lvDataItem.DataItem;

            //set pricing fields
            var lit = e.Item.FindControl("DiscountAmount") as Literal;
            var discountAmount = (li.ExtendedPrice + li.OrderLevelDiscountAmount) / li.Quantity;
            if (lit != null)
                lit.Text = new Money(li.PlacedPrice - discountAmount, WishListHelper.Cart.BillingCurrency).ToString();

            if (discountAmount > 0)
            {
                lit = e.Item.FindControl("ListPrice") as Literal;
                if (lit != null)
                    lit.Text = new Money(li.PlacedPrice, WishListHelper.Cart.BillingCurrency).ToString();
            }

            lit = e.Item.FindControl("YourPrice") as Literal;
            if (lit != null)
                lit.Text = new Money(discountAmount, WishListHelper.Cart.BillingCurrency).ToString();
        }

        /// <summary>
        /// Handles the ItemCommand event of the CartItemsList control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.RepeaterCommandEventArgs"/> instance containing the event data.</param>               
        protected void CartItemsList_ItemCommand(object sender, RepeaterCommandEventArgs e)
        {
            var lineItemId = int.Parse(e.CommandArgument.ToString());
            var lineItem = WishListHelper.LineItems.FirstOrDefault(l => l.LineItemId == lineItemId);
          
            switch (e.CommandName)
            {
                case "AddToCart":
                    var cart = new CartHelper(Cart.DefaultName);
                    if (lineItem != null)
                    {
                        var entry = CatalogContext.Current.GetCatalogEntry(lineItem.CatalogEntryId, 
                            new CatalogEntryResponseGroup(CatalogEntryResponseGroup.ResponseGroup.CatalogEntryInfo | 
                                CatalogEntryResponseGroup.ResponseGroup.Inventory));

                        if (entry != null)
                        {
                            string errorMessage;
                            if (!SampleStoreHelper.AllowAddToCart(cart.Cart, entry, false, lineItem.Quantity,
                                    lineItem.WarehouseCode, out errorMessage))
                            {
                                return;
                            }

                            cart.AddEntry(entry, lineItem.Quantity, false, lineItem.WarehouseCode,
                                new CartHelper[] { });
                            lineItem.Delete();
                        }
                    }
                    // If cart is empty, remove it from the database
                    if (WishListHelper.IsEmpty)
                    {
                        WishListHelper.Delete();
                    }
                    // Save changes to a wish list
                    WishListHelper.Cart.AcceptChanges();
                    cart.Cart.AcceptChanges();

                    // Redirect to shopping cart
                    Context.RedirectFast(GetUrl(Settings.CartPage));
                    break;

                case "Remove":
                    if (lineItem != null)
                    {
                        // remove from wishlist
                        lineItem.Delete();
                    }

                    // If cart is empty, remove it from the database
                    if (WishListHelper.IsEmpty)
                    {
                        WishListHelper.Delete();
                    }

                    // Save changes to a wish list
                    WishListHelper.Cart.AcceptChanges();

                    BindData();
                    break;
            }

        }
        #endregion

        #region Helper Methods

        /// <summary>
        /// Binds the data.
        /// </summary>
        private void BindData()
        {
            var isEmpty = WishListHelper.IsEmpty;

            if (!WishListHelper.IsEmpty)
            {
                WishListHelper.RunWorkflow(Constants.CartValidateWorkflowName);

                // If cart is empty, remove it from the database
                isEmpty = WishListHelper.IsEmpty;
                if (isEmpty)
                    WishListHelper.Delete();

                WishListHelper.Cart.AcceptChanges();
            }

            if (!isEmpty)
            {
                CartItemsList.DataSource = WishListHelper.LineItems;
                CartItemsList.DataBind();
            }
            else
            {
                CartItemsList.Visible = false;
                lblEmptyData.Visible = true;
            }
        }

        /// <summary>
        /// Gets the item image.
        /// </summary>
        /// <param name="item">The item.</param>
        /// <returns></returns>
        protected string GetItemImage(LineItem item)
        {
            return AssetHelper.GetAssetUrl(item.GetCommerceMediaCollection()) ?? string.Empty;
        }
        #endregion


    }
}