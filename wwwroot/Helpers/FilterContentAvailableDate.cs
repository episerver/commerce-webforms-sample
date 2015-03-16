using EPiServer.BaseLibrary;
using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Core;
using EPiServer.Filters;
using EPiServer.ServiceLocation;
using Mediachase.Commerce.Catalog;
using Mediachase.Commerce.Core;
using Mediachase.Commerce.Inventory;
using Mediachase.Commerce.InventoryService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EPiServer.Commerce.Sample.Helpers
{
    /// <summary>
    /// Filters the specified content items, removing those that should not be shown to the current user.
    /// </summary>
    public class FilterContentAvailableDate : PageFilterBase
    {
        private IInventoryService _inventoryService;

        private DateTime _safeBeginDateUtc = new DateTime(1900, 1, 1, 0, 0, 0, DateTimeKind.Utc);

        public FilterContentAvailableDate()
        {
            _inventoryService = ServiceLocator.Current.GetInstance<IInventoryService>();
        }

        public FilterContentAvailableDate(IInventoryService inventoryService)
        {
            _inventoryService = inventoryService;
        }

        public override DateTime? RequestTime
        {
            get
            {
                return base.RequestTime;
            }
            set
            {
                base.RequestTime = value;
            }
        }

        /// <summary>
        /// If the content should be filtered.
        /// </summary>
        /// <param name="content">The content</param>
        /// <returns>True if the content should be filtered.</returns>
        public override bool ShouldFilter(IContent content)
        {
            return !CheckPreorderAvailableDate(content, Context.Current.RequestTime);
        }

        /// <summary>
        /// The page should be filtered.
        /// </summary>
        /// <param name="page">The page data</param>
        public override bool ShouldFilter(PageData page)
        {
            return true;
        }

        /// <summary>
        /// Filtered the available of contents.
        /// </summary>
        /// <param name="content">The content</param>
        /// <param name="requestTime">The request date time</param>
        /// <returns>True if the content is not need filter, otherwise false</returns>
        private bool CheckPreorderAvailableDate(IContent content, DateTime requestTime)
        {
            var entry = content as VariationContent;

            // Not filter content that is not variation content
            if (entry == null)
            {
                return true;
            }

            var entryMinimumAvailableDate = entry.StartPublish;
            var records = _inventoryService.List().Where(r => r.CatalogEntryCode == entry.Code && r.PreorderAvailableUtc > _safeBeginDateUtc).ToList();

            // The available date is the minimum date of start date and preorder available date and it must be greater than safe begining date.
            if (records.Any())
            {
                var minPreorderDate = records.Select(i => i.PreorderAvailableUtc).Min();
                if (entryMinimumAvailableDate > minPreorderDate)
                {
                    entryMinimumAvailableDate = minPreorderDate;
                }
            }

            return entryMinimumAvailableDate <= requestTime && requestTime < entry.StopPublish;
        }
    }
}