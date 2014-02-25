using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Sample.BaseControls;
using Mediachase.Commerce.Catalog.Managers;
using System;
using System.Linq;
using Mediachase.Commerce.Website.Helpers;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.ProductDetail.SharedModules.ProductInfoPricing
{
    public partial class ProductPriceDetails : RendererControlBase<EntryContentBase>
    {
        /// <summary>
        /// Gets or sets the filter action.
        /// </summary>
        /// <value>The filter action.</value>
        public Func<VariationContent, bool> FilterAction { get; set; }

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);

            CalculatePriceValues();
        }

        public override void DataBind()
        {
            base.DataBind();
            CalculatePriceValues();
        }

        private void CalculatePriceValues()
        {
            if (FilterAction != null && CurrentData != null)
            {
                var variationContent = CurrentData as VariationContent;
                if (variationContent == null)
                {
                    variationContent = GetVariants<VariationContent>().FirstOrDefault(FilterAction);
                }

                if (variationContent == null)
                {
                    DisplayPriceInfo();
                    return;
                }

                var currentMarket = CurrentMarket.GetCurrentMarket();

                var entry = variationContent.LoadEntry(CatalogEntryResponseGroup.ResponseGroup.Variations);
                var salePrice = StoreHelper.GetSalePrice(entry, 1);

                if (variationContent.IsAvailableInMarket(currentMarket.MarketId) && salePrice != null)
                {
                    var basePrice = salePrice.Money;
                    var discount = StoreHelper.GetDiscountPrice(entry);
                    var discountNum = basePrice;

                    if (discount != null && discount.Money.Amount != -1)
                    {
                        discountNum = discount.Money;
                    }

                    var saved = basePrice.Subtract(discountNum);

                    ListPrice.Text = basePrice.ToString();
                    DiscountPricing.Text = discountNum.ToString();
                    Savings.Text = saved.ToString();

                    return;
                }
            }

            DisplayPriceInfo();
        }

        /// <summary>
        /// Displays the price info.
        /// </summary>
        private void DisplayPriceInfo()
        {
            ListPrice.Text = "Not available";
            DiscountPricing.Text = "Not available";
            Savings.Text = "Not available";
        }
    }
}