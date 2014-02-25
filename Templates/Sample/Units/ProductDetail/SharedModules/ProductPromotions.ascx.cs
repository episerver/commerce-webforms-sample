using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Extensions;
using EPiServer.Commerce.Sample.BaseControls;
using Mediachase.Commerce;
using System;
using System.Linq;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.ProductDetail.SharedModules
{
    public partial class ProductPromotions : RendererControlBase<EntryContentBase>
    {
        /// <summary>
        /// Gets or sets the filter action.
        /// </summary>
        /// <value>The filter action.</value>
        public Func<VariationContent, bool> FilterAction { get; set; }

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            BindPromotions();
        }

        public override void DataBind()
        {
            base.DataBind();
            BindPromotions();
        }

        private void BindPromotions()
        {
            var variationContent = CurrentData as VariationContent;
            if (variationContent == null)
            {
                variationContent = GetVariants<VariationContent>().FirstOrDefault(FilterAction);
            }

            Visible = false;
            if (variationContent == null)
                return;

            // We have to load an entry to be able to get promotions.
            var entrySku = variationContent.LoadEntry();
            var currentMarketId = CurrentMarket.GetCurrentMarket().MarketId;

            if (!entrySku.IsAvailableInMarket(currentMarketId))
                return;

            Promotions.Text = String.Empty;

            var promotions = entrySku.GetPromotions();
            if (!promotions.PromotionRecords.Any())
                return;

            Visible = true;
            PromotionsHolder.Visible = true;

            var marketService = Locate.MarketService();
            foreach (var record in promotions.PromotionRecords)
            {
                var promotionName = record.PromotionItem.DataRow.GetPromotionLanguageRows().FirstOrDefault(x => x.LanguageCode == marketService.GetMarket(MarketId.Default).DefaultLanguage.ToString()) != null ?
                                                    record.PromotionItem.DataRow.GetPromotionLanguageRows().FirstOrDefault(x => x.LanguageCode == marketService.GetMarket(MarketId.Default).DefaultLanguage.ToString()).DisplayName :
                                                    record.PromotionItem.DataRow.Name;
                Promotions.Text += string.Format("<li class=\"truncate\">Name: {0} </li>", promotionName);
                Promotions.Text += string.Format("<li>Amount Off: {0}{1}</li>", record.PromotionReward.AmountOff.ToString(), record.PromotionReward.AmountType == "Percentage" ? "%" : "");
            }
        }
    }
}