using System;
using System.Collections.Generic;
using System.Globalization;
using System.Web;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.Navigation
{
    public partial class PagingMenu : System.Web.UI.UserControl
    {
        /// <summary>
        /// Default value for <see cref="PageKey"/>
        /// </summary>
        public const string DefaultPageKey = "p";

        /// <summary>
        /// Default value for <see cref="ShowAllKey"/>
        /// </summary>
        public const string DefaultShowAllKey = "all";

        /// <summary>
        /// Initializes a new instance of the <see cref="PagingMenu"/> class.
        /// </summary>
        public PagingMenu()
        {
            PageKey = DefaultPageKey;
            ShowAllKey = DefaultShowAllKey;
        }

        /// <summary>
        /// Gets or sets the query string key for the paging index.
        /// </summary>
        public string PageKey { get; set; }

        /// <summary>
        /// Gets or sets the query string key for showing all items.
        /// </summary>
        public string ShowAllKey { get; set; }

        /// <summary>
        /// Index (one-based) of the first visible item.
        /// </summary>
        public int FirstItemIndex { get; set; }

        /// <summary>
        /// The page size.
        /// </summary>
        public int PageSize { get; set; }

        /// <summary>
        /// The total number of items in the paging collection.
        /// </summary>
        public int TotalItems { get; set; }

        protected int PageIndex
        {
            get { return FirstItemIndex/PageSize + 1; }
        }

        protected int MaxPageIndex
        {
            get { return (TotalItems - 1)/PageSize + 1; }
        }

        private string UpdateQueryString(IDictionary<string, string> values)
        {
            var queryStringValues = HttpUtility.ParseQueryString(Request.QueryString.ToString());
            foreach (var item in values)
            {
                if (queryStringValues[item.Key] != null)
                {
                    queryStringValues.Set(item.Key, item.Value);
                }
                else
                {
                    queryStringValues.Add(item.Key, item.Value);
                }
            }
            string updatedQueryString = "?" + queryStringValues;
            return Request.Url.AbsolutePath + updatedQueryString;
        }

        /// <summary>
        /// Gets the view all URL.
        /// </summary>
        /// <param name="totalRecords">The total records.</param>
        /// <returns></returns>
        protected string GetViewAllUrl(int totalRecords)
        {
            var values = new Dictionary<string, string>();
            values.Add(ShowAllKey, "1");
            values.Add(PageKey, "1");
            return UpdateQueryString(values);
        }

        /// <summary>
        /// Gets the previous page's view
        /// </summary>
        /// <returns></returns>
        protected string GetPreviousPageUrl()
        {
            var values = new Dictionary<string, string>();
            values.Add(PageKey, Math.Max(PageIndex - 1, 1).ToString(CultureInfo.InvariantCulture));
            return UpdateQueryString(values);
        }

        /// <summary>
        /// Get the next page's view
        /// </summary>
        /// <returns></returns>
        protected string GetNextPageUrl()
        {
            var values = new Dictionary<string, string>();
            values.Add(PageKey, Math.Min(PageIndex + 1, MaxPageIndex).ToString(CultureInfo.InvariantCulture));
            return UpdateQueryString(values);
        }
    }
}