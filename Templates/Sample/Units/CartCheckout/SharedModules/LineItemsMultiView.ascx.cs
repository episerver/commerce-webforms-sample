using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Sample.Helpers;
using EPiServer.ServiceLocation;
using EPiServer.Web;
using Mediachase.Commerce;
using Mediachase.Commerce.Marketing.Objects;
using Mediachase.Commerce.Orders;
using Mediachase.Commerce.Website.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.CartCheckout.SharedModules
{
    public partial class LineItemsMultiView : UserControlBase
    {
        #region Fields
        private readonly CartHelper _cartHelper = new CartHelper(Cart.DefaultName);
        private PromotionResult _promotionResult;
        private readonly IMarket _currentMarket = ServiceLocator.Current.GetInstance<ICurrentMarket>().GetCurrentMarket();
        #endregion

        #region Properties

        public List<LineItem> ShipmentLineItems { get; set; }
        #endregion

        #region Page Lifecycle Event Handlers
        /// <summary>
        /// Handles the Init event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Init(object sender, EventArgs e)
        {
            lvCartItems.ItemDataBound += (lvCartItems_ItemDataBound);
        }

        #endregion

        #region Event Handlers
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
                lit.Text = new Money(li.PlacedPrice, _cartHelper.Cart.BillingCurrency).ToString();

            var discountAmount = (li.ExtendedPrice + li.OrderLevelDiscountAmount) / li.Quantity;

            lit = e.Item.FindControl("YourPrice") as Literal;
            if (lit != null)
                lit.Text = new Money(discountAmount, _cartHelper.Cart.BillingCurrency).ToString();

            lit = e.Item.FindControl("ExtendedPrice") as Literal;
            var extendedPrice = li.PlacedPrice * li.Quantity - li.LineItemDiscountAmount;
            if (lit != null)
                lit.Text = new Money(extendedPrice, _cartHelper.Cart.BillingCurrency).ToString();

            if (discountAmount < li.PlacedPrice)
            {
                lit = e.Item.FindControl("DiscountAmount") as Literal;
                if (lit != null)
                    lit.Text = new Money(li.LineItemDiscountAmount, _cartHelper.Cart.BillingCurrency).ToString();

                lit = e.Item.FindControl("itemDiscounts") as Literal;
                if (lit != null)
                {
                    var itemDiscounts = string.Empty;

                    if (_promotionResult != null && _promotionResult.PromotionRecords.Count > 0)
                        foreach (var record in _promotionResult.PromotionRecords)
                        {
                            var recordItem = record.AffectedEntriesSet.Entries.FirstOrDefault(item => item.CatalogEntryCode == li.CatalogEntryId);
                            if ((recordItem != null) && (recordItem.Quantity > 0))
                            {
                                var promotionLanguage = record.PromotionItem.DataRow.GetPromotionLanguageRows().FirstOrDefault().LanguageCode;
                                var defaultMarketLanguage = _currentMarket.DefaultLanguage.ToString();
                                var discountAmountLit = record.PromotionReward.AmountType.Equals(Constants.AmountTypeValueBased) ? new Money(record.PromotionReward.AmountOff, _cartHelper.Cart.BillingCurrency).ToString() :
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
        #endregion

        #region Helper Methods

        /// <summary>
        /// Default bind data method.
        /// </summary>
        public void BindData()
        {
            if (!_cartHelper.IsEmpty)
            {
                _promotionResult = _cartHelper.GetPromotions();
            }

            lvCartItems.DataSource = ShipmentLineItems;
            lvCartItems.DataBind();
        }

        #endregion
    }
}