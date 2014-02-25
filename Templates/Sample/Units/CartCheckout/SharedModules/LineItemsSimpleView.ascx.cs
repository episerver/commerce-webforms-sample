using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Sample.BaseControls;
using EPiServer.Commerce.Sample.Helpers;
using EPiServer.ServiceLocation;
using Mediachase.Commerce;
using Mediachase.Commerce.Catalog;
using Mediachase.Commerce.Catalog.Managers;
using Mediachase.Commerce.Marketing.Objects;
using Mediachase.Commerce.Orders;
using Mediachase.Commerce.Website;
using Mediachase.Commerce.Website.Helpers;
using System;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using Mediachase.Commerce.Marketing;
using EPiServer.Commerce.Catalog.Provider;
using EPiServer.Core;


namespace EPiServer.Commerce.Sample.Templates.Sample.Units.CartCheckout.SharedModules
{
    public partial class LineItemsSimpleView : RendererControlBase<CatalogContentBase>
    {
        private readonly CartHelper _cartHelper = new CartHelper(Cart.DefaultName);
        private PromotionResult _promotionResult;
        private readonly IMarket _currentMarket = ServiceLocator.Current.GetInstance<ICurrentMarket>().GetCurrentMarket();

        /// <summary>
        /// Gets the cart helper.
        /// </summary>
        /// <value>The cart helper.</value>
        public CartHelper CartHelper
        {
            get { return _cartHelper; }
        }

        /// <summary>
        /// Could update or remove line items
        /// </summary>
        public bool Editable
        {
            get;
            set;
        }

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            lvCartItems.ItemDataBound += (lvCartItems_ItemDataBound);
            lvCartItems.ItemEditing += (lvCartItems_ItemEditing);
            lvCartItems.ItemDeleting += (lvCartItems_ItemDeleting);
            lvCartItems.ItemCommand += (lvCartItems_ItemCommand);
            lvCartItems.ItemUpdating += (lvCartItem_ItemUpdating);
            lvCartItems.ItemCanceling += (lvCartItem_ItemCanceling);
            lvCartItems.LayoutCreated += (lvCartItem_LayoutCreated);

            if (!IsPostBack)
            {
                BindData();
            }
        }

        /// <summary>
        /// Handle the LayoutCreated event of the lvCartItems control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The event arguments.</param>
        protected void lvCartItem_LayoutCreated(object sender, EventArgs e)
        {
            var panel = lvCartItems.FindControl("InfoHeading") as Panel;
            if (panel != null)
            {
                panel.Visible = Editable;
            }

            panel = lvCartItems.FindControl("NameHeading") as Panel;
            if (panel != null)
            {
                panel.Visible = !Editable;
            }
        }

        /// <summary>
        /// Handles the ItemDeleting event of the lvCartItems control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.ListViewDeleteEventArgs"/> instance containing the event data.</param>
        protected void lvCartItems_ItemDeleting(object sender, ListViewDeleteEventArgs e)
        {
            int lineItemId;

            if (Int32.TryParse(lvCartItems.DataKeys[e.ItemIndex].Value.ToString(), out lineItemId))
            {
                if (!CartHelper.IsEmpty)
                {
                    foreach (LineItem item in CartHelper.LineItems)
                    {
                        if (item.LineItemId == lineItemId)
                        {
                            item.Delete();
                        }
                    }
                }

                // If cart is empty, remove it from the database
                if (CartHelper.IsEmpty)
                    CartHelper.Delete();

                Session.Remove(Constants.LastCouponCode);

                CartHelper.Cart.AcceptChanges();
                Context.RedirectFast(Request.RawUrl);
            }
            else
                e.Cancel = true;
        }

        /// <summary>
        /// Handles the ItemCommand event of the lvCartItems control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="ListViewCommandEventArgs"/> instance containing the event data.</param>
        protected void lvCartItems_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName != "Wishlist")
                return;

            int lineItemId;
            if (!Int32.TryParse(lvCartItems.DataKeys[e.Item.DataItemIndex].Value.ToString(), out lineItemId))
                return;

            var cart = new CartHelper(Cart.DefaultName);
            foreach (var item in cart.LineItems)
            {
                if (item.LineItemId != lineItemId)
                    continue;

                var qty = item.Quantity;
                var helper = new CartHelper(CartHelper.WishListName);
                var entry = CatalogContext.Current.GetCatalogEntry(item.CatalogEntryId, new CatalogEntryResponseGroup(CatalogEntryResponseGroup.ResponseGroup.CatalogEntryInfo));
                if (entry == null)
                    continue;

                helper.AddEntry(entry, qty, true);
                item.Delete();
            }

            // If cart is empty, remove it from the database
            if (CartHelper.IsEmpty)
                CartHelper.Delete();

            // Save changes
            cart.Cart.AcceptChanges();

            BindData();

            //Move to Wish-List
            Context.RedirectFast(GetUrl(Settings.WishListPage));
        }

        /// <summary>
        /// Handles the ItemUpdating event of the lvCartItem control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="ListViewUpdateEventArgs"/> instance containing the event data.</param>
        protected void lvCartItem_ItemUpdating(object sender, ListViewUpdateEventArgs e)
        {
            ListViewItem row = lvCartItems.Items[e.ItemIndex];
            var quantityTextBox = row.FindControl("Quantity") as TextBox;
            decimal newQuantity;
            if (!decimal.TryParse(quantityTextBox.Text, out newQuantity))
            {
                BindData();
                return;
            }

            int lineItemId;
            if (!Int32.TryParse(lvCartItems.DataKeys[e.ItemIndex].Value.ToString(), out lineItemId))
                return;

            if (!CartHelper.IsEmpty)
            {
                foreach (var item in CartHelper.LineItems)
                {
                    var discounts = from Discount discount in item.Discounts
                                    where discount.DiscountName.EndsWith(":Gift")
                                    select discount;

                    if (discounts.Any())
                    {
                        ErrorManager.GenerateError(string.Format("[{0}]: {1}", item.DisplayName, "You can not change the quality of items of gift promotion"));
                        return;
                    }

                    if (item.LineItemId == lineItemId)
                    {
                        if (item.Quantity != newQuantity)
                        {
                            var errorMessage = "";
                            var entry = CatalogContext.Current.GetCatalogEntry(item.CatalogEntryId,
                                new CatalogEntryResponseGroup(CatalogEntryResponseGroup.ResponseGroup.CatalogEntryInfo |
                                    CatalogEntryResponseGroup.ResponseGroup.Inventory));

                            if (SampleStoreHelper.AllowAddToCart(CartHelper.Cart, entry, true, newQuantity, item.WarehouseCode, out errorMessage))
                            {
                                item.Quantity = newQuantity;
                                CartHelper.Cart.AcceptChanges();
                            }
                            else
                            {
                                ErrorManager.GenerateError(string.Format("[{0}]: {1}", item.DisplayName, errorMessage));
                                return;
                            }
                        }
                        break;
                    }
                }
            }
            Context.RedirectFast(Request.RawUrl);

        }

        /// <summary>
        /// Handles the ItemCanceling event of the lvCartItem control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="ListViewCancelEventArgs"/> instance containing the event data.</param>
        private void lvCartItem_ItemCanceling(object sender, ListViewCancelEventArgs e)
        {
            lvCartItems.EditIndex = -1;
            BindData();
        }

        /// <summary>
        /// Handles the ItemEditing event of the lvCartItems control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.ListViewEditEventArgs"/> instance containing the event data.</param>
        protected void lvCartItems_ItemEditing(object sender, ListViewEditEventArgs e)
        {
            lvCartItems.EditIndex = e.NewEditIndex;
            BindData();
        }

        /// <summary>
        /// Handles the lvCartItems_ItemDataBound event of the lvCartItems control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.ListViewItemEventArgs"/> instance containing the event data.</param>
        protected void lvCartItems_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType != ListViewItemType.DataItem)
                return;

            var lvDataItem = (ListViewDataItem)e.Item;
            if (lvDataItem == null || lvDataItem.DataItem == null)
                return;

            var li = (LineItem)lvDataItem.DataItem;

            //set pricing fields
            var lit = e.Item.FindControl("ListPrice") as Literal;
            if (lit != null)
                lit.Text = new Money(li.PlacedPrice, CartHelper.Cart.BillingCurrency).ToString();

            var discountAmount = (li.ExtendedPrice + li.OrderLevelDiscountAmount) / li.Quantity;

            lit = e.Item.FindControl("YourPrice") as Literal;
            if (lit != null)
                lit.Text = new Money(discountAmount, CartHelper.Cart.BillingCurrency).ToString();

            lit = e.Item.FindControl("ExtendedPrice") as Literal;
            var extendedPrice = li.PlacedPrice * li.Quantity - li.LineItemDiscountAmount;
            if (lit != null)
                lit.Text = new Money(extendedPrice, CartHelper.Cart.BillingCurrency).ToString();

            // show info button if Editable is true
            var panel = e.Item.FindControl("InfoPanel") as Panel;
            if (panel != null)
            {
                panel.Visible = Editable;
            }

            panel = e.Item.FindControl("NamePanel") as Panel;
            if (panel != null)
            {
                panel.Visible = !Editable;
            }

            if (discountAmount < li.PlacedPrice)
            {
                lit = e.Item.FindControl("DiscountAmount") as Literal;
                if (lit != null)
                    lit.Text = new Money(li.LineItemDiscountAmount, CartHelper.Cart.BillingCurrency).ToString();

                lit = e.Item.FindControl("itemDiscounts") as Literal;
                if (lit != null)
                {
                    var itemDiscounts = "";

                    if (_promotionResult.PromotionRecords.Count > 0)
                        foreach (var record in _promotionResult.PromotionRecords)
                        {
                            var recordItem = record.AffectedEntriesSet.Entries.FirstOrDefault(item => item.CatalogEntryCode == li.CatalogEntryId);
                            if ((recordItem != null) && (recordItem.Quantity > 0))
                            {
                                var promotionLanguage = record.PromotionItem.DataRow.GetPromotionLanguageRows().FirstOrDefault().LanguageCode;
                                var defaultMarketLanguage = _currentMarket.DefaultLanguage.ToString();
                                var discountAmountLit = record.PromotionReward.AmountType.Equals(Constants.AmountTypeValueBased) ? new Money(record.PromotionReward.AmountOff, CartHelper.Cart.BillingCurrency).ToString() :
                                    record.PromotionReward.AmountOff.ToString() + "%";

                                itemDiscounts += (promotionLanguage == defaultMarketLanguage) ?
                                    (String.Format("<strong>{0}</strong><span> | Value: </span>{1}<br />", record.PromotionItem.DataRow.GetPromotionLanguageRows().FirstOrDefault().DisplayName, discountAmountLit)) :
                                                                                                (String.Format("<strong>{0}</strong><span> | Value: </span>{1}<br />", record.PromotionItem.DataRow.Name, discountAmountLit));
                            }
                        }

                    lit.Text = itemDiscounts;
                }
            }
            else
            {
                var div = e.Item.FindControl("divItemLevelDiscount");
                if (div != null)
                    div.Visible = false;

            }

            var linkButton = e.Item.FindControl("MoveWishList") as LinkButton;
            if (linkButton != null)
            {
                if (lvDataItem.DataItem != null)
                    linkButton.Visible = !((LineItem)lvDataItem.DataItem).CatalogEntryId.StartsWith("@");
            }

            lit = e.Item.FindControl("WarehouseName") as Literal;
            var warehouse = WarehouseHelper.GetWarehouse(li.WarehouseCode);
            if (lit != null && warehouse != null)
                lit.Text = HttpUtility.HtmlEncode(warehouse.Name);
        }

        /// <summary>
        /// Default bind data method.
        /// </summary>
        private void BindData()
        {
            var isEmpty = CartHelper.IsEmpty;

            // Make sure to check that prices has not changed
            if (!isEmpty)
            {
                // restore coupon code to context
                string couponCode = Session[Constants.LastCouponCode] as string;
                if (!String.IsNullOrEmpty(couponCode))
                {
                    MarketingContext.Current.AddCouponToMarketingContext(couponCode);
                }

                CartHelper.Cart.ProviderId = "FrontEnd";
                CartHelper.RunWorkflow(Constants.CartValidateWorkflowName);

                // If cart is empty, remove it from the database
                isEmpty = CartHelper.IsEmpty;
                if (isEmpty)
                    CartHelper.Delete();

                CartHelper.Cart.AcceptChanges();
            }

            if (!isEmpty)
            {
                lvCartItems.DataSource = CartHelper.LineItems;
                _promotionResult = CartHelper.GetPromotions();
            }
            lvCartItems.DataBind();
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
    }
}