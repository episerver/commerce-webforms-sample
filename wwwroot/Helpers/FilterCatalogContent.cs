using EPiServer.Core;
using EPiServer.Filters;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EPiServer.Commerce.Sample.Helpers
{
    /// <summary>
    /// A filter that removes any content that the current user does not have access to or that
    /// is not currently published
    public class FilterCatalogContent
    {
        /// <summary>
        /// Filters the specified content items, removing those that should not be shown to the current user.
        /// </summary>
        /// <param name="contentItems">The content items that should be filtered.</param>
        /// <returns>Content available for the current user.</returns>
        public static IEnumerable<IContent> Filter(IEnumerable<IContent> contentItems)
        {
            EPiServer.Framework.Validator.ThrowIfNull("contentItems", contentItems);
            IList<IContent> contentList = contentItems.ToList();
            new FilterAccess().Filter(contentList);
            new FilterTemplate().Filter(contentList);
            new FilterContentAvailableDate().Filter(contentList);
            return contentList;
        }
    }
}