using System;
using System.Linq;
using EPiServer.ServiceLocation;
using Mediachase.Commerce;
using Mediachase.Commerce.Catalog;
using Mediachase.Commerce.Catalog.Objects;
using Mediachase.Commerce.Marketing;
using Mediachase.Commerce.Marketing.Objects;
using Mediachase.Commerce.Orders;
using Mediachase.Commerce.Website.Helpers;
using EPiServer.Core.Html;
using System.Web;
using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.SpecializedProperties;
using EPiServer.Shell;
using EPiServer.Web.Routing;

namespace EPiServer.Commerce.Sample
{
    /// <summary>
    /// Class that implements a number of extension methods for various object types
    /// </summary>
    public static class ExtensionMethods
    {
        public static Injected<UrlResolver> UrlResolver { get; set; }
        public static Injected<ReferenceConverter> ReferenceConverter { get; set; }
        public static Injected<ICurrentMarket> CurrentMarket { get; set; }
        public static Injected<IContentLoader> ContentLoader { get; set; } 

        /// <summary>
        /// Gets the entry link.
        /// </summary>
        /// <param name="lineItem">The line item.</param>
        /// <returns>The url link to the entry related to the line item.</returns>
        public static string GetEntryLink(this LineItem lineItem)
        {
            if (lineItem == null)
            {
                return string.Empty;
            }

            var contentLink = ReferenceConverter.Service.GetContentLink(lineItem.CatalogEntryId, CatalogContentType.CatalogEntry);
            var language = CurrentMarket.Service.GetCurrentMarket().DefaultLanguage.Name;

            return UrlResolver.Service.GetUrl(contentLink, language);
        }

        public static ItemCollection<CommerceMedia> GetCommerceMediaCollection(this LineItem lineItem)
        {
            return GetEntryContent<EntryContentBase>(lineItem).CommerceMediaCollection;
        }

        /// <summary>
        /// Gets the content of the entry by code.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="code">The code.</param>
        /// <returns></returns>
        private static T GetEntryContent<T>(string code) where T : EntryContentBase
        {
            return ContentLoader.Service.Get<T>(ReferenceConverter.Service.GetContentLink(code, CatalogContentType.CatalogEntry));
        }


        /// <summary>
        /// Gets the content of the entry.
        /// </summary>
        /// <param name="lineItem">The line item.</param>
        /// <returns></returns>
        public static T GetEntryContent<T>(this LineItem lineItem) where T: EntryContentBase
        {
            return GetEntryContent<T>(lineItem.CatalogEntryId);
        }


        /// <summary>
        /// Gets the entry meta field value.
        /// </summary>
        /// <param name="item">The lineitem.</param>
        /// <param name="fieldName">Name of the field.</param>
        /// <returns></returns>
        public static string GetSkuMetaFieldValueFromLineItem(this LineItem item, string fieldName)
        {
            var property = GetEntryContent<EntryContentBase>(item.CatalogEntryId).Property[fieldName];
            return (property == null || property.Value == null) ? string.Empty : property.Value.ToString();
        }

        /// <summary>
        /// Gets the entry meta field value.
        /// </summary>
        /// <param name="item">The lineitem.</param>
        /// <param name="fieldName">Name of the field.</param>
        /// <returns></returns>
        public static string GetProductMetaFieldValueFromLineItem(this LineItem item, string fieldName)
        {
            if (!string.IsNullOrWhiteSpace(item.ParentCatalogEntryId))
            {
                var property = GetEntryContent<EntryContentBase>(item.ParentCatalogEntryId).Property[fieldName];
                return (property == null || property.Value == null) ? string.Empty : property.Value.ToString();
            }
            return string.Empty;
        }

        /// <summary>
        /// Gets the display name.
        /// </summary>
        /// <param name="node">The node.</param>
        /// <returns>The display name of the node</returns>
        public static string GetDisplayName(this CatalogNode node)
        {
            if (node == null || node.ItemAttributes == null)
            {
                return string.Empty;
            }
            return WebStringHelper.EncodeForWebString((node.ItemAttributes["DisplayName"] != null && !string.IsNullOrEmpty(node.ItemAttributes["DisplayName"].ToString())) ?
                                                node.ItemAttributes["DisplayName"].ToString() :
                                                node.Name);
        }

        private static void PreparePromotion(PromotionHelper helper, Entry entry, bool checkEntryLevelDiscountLimit)
        {
            var currentMarket = CurrentMarket.Service.GetCurrentMarket();
            decimal minQuantity = 1;

            // get min quantity attribute
            if (entry.ItemAttributes != null)
                minQuantity = entry.ItemAttributes.MinQuantity;

            // we can't pass qauntity of 0, so make it default to 1
            if (minQuantity <= 0)
                minQuantity = 1;

            var price = StoreHelper.GetSalePrice(entry, minQuantity, currentMarket) ?? new Mediachase.Commerce.Catalog.Objects.Price(new Money(0, currentMarket.DefaultCurrency));

            // Create filter
            var filter = new PromotionFilter()
            {
                IgnoreConditions = false,
                IgnorePolicy = false,
                IgnoreSegments = false,
                IncludeCoupons = false
            };

            // Create new entry
            // TPB: catalogNodes is determined by the front end. GetParentNodes(entry)
            var result = new PromotionEntry(String.Empty, String.Empty, entry.ID, price.Money.Amount);
            var promotionEntryPopulateService = (IPromotionEntryPopulate)MarketingContext.Current.PromotionEntryPopulateFunctionClassInfo.CreateInstance();
            promotionEntryPopulateService.Populate(result, entry, currentMarket.MarketId, currentMarket.DefaultCurrency);

            var sourceSet = new PromotionEntriesSet();
            sourceSet.Entries.Add(result);

            // Only target entries
            helper.PromotionContext.TargetGroup = PromotionGroup.GetPromotionGroup(PromotionGroup.PromotionGroupKey.Entry).Key;

            // Configure promotion context
            helper.PromotionContext.SourceEntriesSet = sourceSet;
            helper.PromotionContext.TargetEntriesSet = sourceSet;

            // Execute the promotions and filter out basic collection of promotions, we need to execute with cache disabled, so we get latest info from the database
            helper.Eval(filter, checkEntryLevelDiscountLimit);
        }

        /// <summary>
        /// Gets Promotions.
        /// </summary>
        /// <param name="entry">The entry.</param>
        /// <returns>The promotions related to entry.</returns>
        public static PromotionResult GetPromotions(this Entry entry)        
        {
            PromotionHelper helper = new PromotionHelper();
            PreparePromotion(helper, entry, false);
            return helper.PromotionContext.PromotionResult;
        }

        /// <summary>
        /// Get promotion with check entry limit for cart
        /// </summary>
        /// <param name="cartHelper"> The carthelper</param>
        /// <returns> The promotions related to entries in cart</returns>
        public static PromotionResult GetPromotions(this CartHelper cartHelper)
        {
            // Create new promotion helper, which will initialize PromotionContext object for us and setup context dictionary
            var helper = new PromotionHelper();
            var highPlacedPriceFirst = cartHelper.LineItems.ToArray().OrderByDescending(x => x.PlacedPrice);
            var lineItemCount = highPlacedPriceFirst.Count();
            var i = 0;
            foreach (var li in highPlacedPriceFirst)
            {
                i++;
                var entry = CatalogContext.Current.GetCatalogEntry(li.CatalogEntryId);
                // Evaluate conditions
                var checkEntryLevelDiscountLimit = i == lineItemCount;
                PreparePromotion(helper, entry, checkEntryLevelDiscountLimit);
            }
            return helper.PromotionContext.PromotionResult;
        }


        /// <summary>
        /// Determines whether the specific catalog entry is available in market
        /// </summary>
        /// <param name="entry">The entry.</param>
        /// <param name="currentMarketId">The current market id.</param>
        /// <returns>
        ///   <c>true</c> if [is available in market] [the specified entry]; otherwise, <c>false</c>.
        /// </returns>
        public static bool IsAvailableInMarket(this Entry entry, MarketId currentMarketId)
        {
            var excludedCatalogEntryMarkets = entry.ItemAttributes["_ExcludedCatalogEntryMarkets"].Value;
            if (excludedCatalogEntryMarkets == null)
            {
                return true;
            }
            return !excludedCatalogEntryMarkets.Contains(currentMarketId.ToString());
        }


        public static string ToPriceString(this Mediachase.Commerce.Catalog.Objects.Price price)
        {
            return price != null
                ? price.Money.ToString()
                : "Not Available";
        }

        public static string ToHtmlEncode(this string value)
        {
            return HttpUtility.HtmlEncode(value);
        }

        /// <summary>
        /// Creates the address literal.
        /// </summary>
        /// <param name="address">The address.</param>
        /// <returns></returns>
        public static string ToAddressLiteral(this OrderAddress address)
        {
            var street = string.IsNullOrEmpty(address.Line2) ? address.Line1.ToHtmlEncode() : address.Line1.ToHtmlEncode() + "<br/>" + address.Line2.ToHtmlEncode();
            return String.Format("{0} {1} <br/> {2}<br/> {3}, {4}, {5}<br/> {6}", address.FirstName.ToHtmlEncode(), address.LastName.ToHtmlEncode(), street,
                address.City.ToHtmlEncode(), address.State.ToHtmlEncode(), address.PostalCode.ToHtmlEncode(), address.CountryCode.ToHtmlEncode());
        }

        public static void RedirectFast(this System.Web.HttpContext context, string redirectUrl)
        {
            context.Response.Redirect(redirectUrl, false);
            context.ApplicationInstance.CompleteRequest();
        }
    }
}