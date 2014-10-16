using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Sample.BaseControls;
using EPiServer.Commerce.Sample.Helpers;
using EPiServer.Commerce.Sample.Models.MetaDataClasses;
using EPiServer.Commerce.Sample.Templates.Sample.Units.CategoryDisplay.SharedModules;
using EPiServer.Commerce.Sample.Templates.Sample.Units.Navigation;
using EPiServer.Core;
using EPiServer.Framework.DataAnnotations;
using EPiServer.ServiceLocation;
using Mediachase.Commerce.Catalog.Managers;
using Mediachase.Commerce.Catalog.Objects;
using Mediachase.Commerce.Website.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.CategoryDisplay
{
    [TemplateDescriptor(Inherited = true)]
    public partial class DepartmentNodeWithEntries : RendererControlBase<NodeContent>
    {
        private readonly LanguageSelectorFactory _languageSelectorFactory = ServiceLocator.Current.GetInstance<LanguageSelectorFactory>();

        /// <summary>
        ///  Gets or sets show Variations.
        /// </summary>
        public bool ShowVariations { get; set; }

        /// <summary>
        ///  Gets or sets show Products.
        /// </summary>
        public bool ShowProducts { get; set; }

        /// <summary>
        /// Raises the <see cref="E:System.Web.UI.Control.Init" /> event.
        /// </summary>
        /// <param name="e">An <see cref="T:System.EventArgs" /> object that contains the event data.</param>
        protected override void OnInit(EventArgs e)
        {
            entriesList.ItemDataBound += (entriesList_ItemDataBound);
        }

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            Session[Constants.LastCatalogPageUrl] = Request.Url.ToString();

            var qs = Request.QueryString;
            var pageSize = qs[PagingMenu.DefaultShowAllKey] != null ? 1000 : pagerTop.PageSize;

            var page = qs[PagingMenu.DefaultPageKey] != null
                                     ? Math.Max(Int32.Parse(qs[PagingMenu.DefaultPageKey]), 1)
                                     : 1;

            var startIndex = (page - 1) * pageSize;

            pagerTop.SetPageProperties(startIndex, pageSize, false);
            pagerBottom.SetPageProperties(startIndex, pageSize, false);

            BindResults();
            DataBind();
        }

        protected void entriesList_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            var image1 = ((System.Web.UI.WebControls.Image)e.Item.FindControl("Image1"));

            using (var listViewDataItem = (ListViewDataItem)e.Item)
            {
                if (listViewDataItem == null)
                    return;

                var content = (EntryContentBase)listViewDataItem.DataItem;
                image1.ImageUrl = AssetHelper.GetAssetUrl(content.CommerceMediaCollection);

                if (content == null)
                {
                    return;
                }

                var variationContent = GetVariationContent(content);
                if (variationContent != null)
                {
                    // we need to use Variations responsegroup to get prices
                    var entry = variationContent.LoadEntry(CatalogEntryResponseGroup.ResponseGroup.Variations);

                    AssignEntryToCommonButtons(entry, listViewDataItem);
                    SetInStockLiteralText(variationContent, listViewDataItem);

                    AssignEntryToPriceInfo(entry, listViewDataItem);
                    GetPromotions(e, entry);
                }
            }
        }

        protected string GetFacetBrand(EntryContentBase content)
        {
            var fasetBrand = content as IFacetBrand;
            return fasetBrand != null ? fasetBrand.Facet_Brand : string.Empty;
        }

        protected string GetModelNumber(EntryContentBase content)
        {
            var infoModelNumber = content as IInfoModelNumber;
            return infoModelNumber != null ? infoModelNumber.Info_ModelNumber : string.Empty;
        }

        protected Price GetDiscountPrice(Entry entry)
        {
            return StoreHelper.GetDiscountPrice(entry);
        }

        private VariationContent GetVariationContent(EntryContentBase content)
        {
            var variationContent = content as VariationContent;
            if (variationContent != null)
            {
                return variationContent;
            }

            var variantContainer = content as IVariantContainer;
            if (variantContainer == null)
            {
                return null;
            }

            var relation = variantContainer.GetVariantRelations().FirstOrDefault();
            if (relation == null)
            {
                return null;
            }

            return ContentLoader.Get<IContent>(relation.Target, _languageSelectorFactory.Create(content.Language.Name)) as VariationContent;
        }

        private void GetPromotions(ListViewItemEventArgs e, Entry entry)
        {
            var promotions = entry.GetPromotions();
            if (promotions.PromotionRecords.Count == 0)
                return;

            var lit = e.Item.FindControl("Promotions") as Literal;
            if (lit == null)
                return;

            e.Item.FindControl("PromotionsHolder").Visible = true;

            foreach (var record in promotions.PromotionRecords)
            {
                var promotionLanguageRow = record.PromotionItem.DataRow.GetPromotionLanguageRows()
                                                 .FirstOrDefault(
                                                     x =>
                                                     x.LanguageCode ==
                                                     CurrentMarket.GetCurrentMarket().DefaultLanguage.ToString());

                var promotionName = promotionLanguageRow != null
                                        ? promotionLanguageRow.DisplayName
                                        : record.PromotionItem.DataRow.Name;

                lit.Text += string.Format("<li class=\"truncate\">Name: {0} </li>", promotionName.ToHtmlEncode());
                lit.Text += string.Format("<li>Amount Off: {0}{1}</li>", record.PromotionReward.AmountOff.ToString(), record.PromotionReward.AmountType == "Percentage" ? "%" : "");
            }
        }

        private void BindResults()
        {
            var children = new List<EntryContentBase>();
            if (ShowProducts)
            {
                children.AddRange(GetChildren<ProductContent>());
            }

            if (ShowVariations)
            {
                children.AddRange(GetChildren<VariationContent>());
            }

            entriesList.DataSource = children;
        }

        private List<T> GetChildren<T>() where T : EntryContentBase
        {
            return GetEntryChildren<T>(CurrentData.ContentLink).ToList();
        }

        private static void SetLiteralText(string controlName, string value, Control listViewDataItem)
        {
            var lit = listViewDataItem.FindControl(controlName) as Literal;
            if (lit != null)
            {
                lit.Text = value;
            }
        }

        private static void AssignEntryToCommonButtons(Entry entry, ListViewDataItem listViewDataItem)
        {
            var commonButtons = listViewDataItem.FindControl("CommonButtons") as CommonButtons;
            if (commonButtons != null)
            {
                commonButtons.SetEntry(entry);
            }
        }

        private static void AssignEntryToPriceInfo(Entry entry, ListViewDataItem listViewDataItem)
        {
            var pricingInfo = listViewDataItem.FindControl("PricingInfo") as CommonPricingInfo;
            if (pricingInfo != null)
            {
                pricingInfo.SetEntry(entry);
            }
        }

        private static void SetInStockLiteralText(IStockPlacement stockPlacement, ListViewDataItem listViewDataItem)
        {
            var firstInventory = stockPlacement.GetStockPlacement()
                .FirstOrDefault(i => i.WarehouseCode == Constants.DefaultWarehouseCode);

            var inStockQuantity = firstInventory != null ? firstInventory.InStockQuantity : 0;
            SetLiteralText("InStock", inStockQuantity.ToString(), listViewDataItem);
        }
    }
}