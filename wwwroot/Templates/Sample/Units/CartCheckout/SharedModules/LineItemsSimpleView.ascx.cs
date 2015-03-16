﻿using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Sample.BaseControls;
using EPiServer.Commerce.Sample.Helpers;
using EPiServer.ServiceLocation;
using Mediachase.Commerce;
using Mediachase.Commerce.Catalog;
using Mediachase.Commerce.Catalog.Managers;
using Mediachase.Commerce.Marketing;
using Mediachase.Commerce.Marketing.Dto;
using Mediachase.Commerce.Marketing.Managers;
using Mediachase.Commerce.Marketing.Objects;
using Mediachase.Commerce.Orders;
using Mediachase.Commerce.Website;
using Mediachase.Commerce.Website.Helpers;
using System;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;


namespace EPiServer.Commerce.Sample.Templates.Sample.Units.CartCheckout.SharedModules
{
    public partial class LineItemsSimpleView : RendererControlBase<CatalogContentBase>
    {
        private readonly CartHelper _cartHelper = new CartHelper(Cart.DefaultName);
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
                //Validate the cart before binding data
                if (!CartHelper.IsEmpty)
                {
                    CartHelper.Cart.ProviderId = "FrontEnd";
                    CartHelper.RunWorkflow(Constants.CartValidateWorkflowName);
                    CartHelper.Cart.AcceptChanges();
                }
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

                Session.Remove(Constants.LastCouponCode);

                // If cart is empty, remove it from the database
                if (CartHelper.IsEmpty)
                {
                    CartHelper.Delete();
                }
                
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
                var entry = CatalogContext.Current.GetCatalogEntry(item.Code, new CatalogEntryResponseGroup(CatalogEntryResponseGroup.ResponseGroup.CatalogEntryInfo));
                if (entry == null)
                    continue;

                helper.AddEntry(entry, qty, true);
                item.Delete();
            }

            // If cart is empty, remove it from the database
            if (CartHelper.IsEmpty)
                CartHelper.Delete();

            cart.RunWorkflow(Constants.CartValidateWorkflowName);
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
                    if (item.IsGiftItem())
                    {
                        ErrorManager.GenerateError(string.Format("[{0}]: {1}", item.DisplayName, "You can not change the quality of items of gift promotion"));
                        return;
                    }

                    if (item.LineItemId == lineItemId)
                    {
                        if (item.Quantity != newQuantity)
                        {
                            var errorMessage = "";
                            var entry = CatalogContext.Current.GetCatalogEntry(item.Code,
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
                    if (li.Discounts.Count > 0)
                    {
                        foreach (var record in li.Discounts.Cast<LineItemDiscount>())
                        {
                            var discountAmountLit =  new Money(record.DiscountValue, CartHelper.Cart.BillingCurrency).ToString()  + (record.DiscountName.Contains("ValueBased") ? "" : "%");
                            itemDiscounts += String.Format("<strong>{0}</strong><span> | Value: </span>{1}<br />", record.DisplayMessage.ToHtmlEncode(), discountAmountLit);
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
                    linkButton.Visible = !((LineItem)lvDataItem.DataItem).Code.StartsWith("@");
            }

            lit = e.Item.FindControl("WarehouseName") as Literal;
            var warehouse = WarehouseHelper.GetWarehouse(li.WarehouseCode);
            if (lit != null && warehouse != null)
                lit.Text = HttpUtility.HtmlEncode(warehouse.Name);
        }

        /// <summary>
        /// Default bind data method.
        /// </summary>
        public void BindData()
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

                // If cart is empty, remove it from the database
                isEmpty = CartHelper.IsEmpty;
                if (isEmpty)
                    CartHelper.Delete();
            }
            
            lvCartItems.DataSource = CartHelper.LineItems;
            lvCartItems.DataBind();
        }

        /// <summary>
        /// Gets the item image.
        /// </summary>
        /// <param name="item">The item.</param>
        /// <returns></returns>
        protected string GetItemImage(LineItem item)
        {
            return AssetUrlResolverInstance.GetAssetUrl(item.GetEntry()) ?? string.Empty;
        }
    }
}
