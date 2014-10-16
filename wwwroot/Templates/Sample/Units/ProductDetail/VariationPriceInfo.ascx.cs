using System;
using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Sample.BaseControls;
using EPiServer.ServiceLocation;
using Mediachase.Commerce;
using Mediachase.Commerce.Catalog;
using Mediachase.Commerce.Catalog.Managers;
using Mediachase.Commerce.Website.Helpers;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.ProductDetail
{
    public partial class VariationPriceInfo : RendererControlBase<VariationContent>
    {
        private readonly ICurrentMarket _currentMarketService = ServiceLocator.Current.GetInstance<ICurrentMarket>();

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            var catalogSystem = Locate.Advanced.GetInstance<ICatalogSystem>();

            var currentMarket = _currentMarketService.GetCurrentMarket();

            // we need to use Variations responsegroup to get prices
            var entry = CurrentData.LoadEntry(CatalogEntryResponseGroup.ResponseGroup.Variations);

            var salePrice = StoreHelper.GetSalePrice(entry, 1);
            if (entry.IsAvailableInMarket(currentMarket.MarketId) && (salePrice != null))
            {
                var basePrice = salePrice.Money;
                var discount = StoreHelper.GetDiscountPrice(entry).Money;
                if (discount.Amount == -1)
                {
                    discount = basePrice;
                }
                var saved = basePrice.Subtract(discount);

                ListPrice.Text = basePrice.ToString();
                DiscountPricing.Text = discount.ToString();
                Savings.Text = saved.ToString();

                return;
            }


            ListPrice.Text = "Not available";
            DiscountPricing.Text = "Not available";
            Savings.Text = "Not available";
        }
    }
}