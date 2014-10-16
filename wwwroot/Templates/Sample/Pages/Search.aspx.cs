using System;
using System.Linq;
using EPiServer.Commerce.Sample.Templates.Sample.PageTypes;
using EPiServer.Commerce.Sample.Templates.Sample.Units.Navigation;
using EPiServer.ServiceLocation;
using Mediachase.Commerce;
using Mediachase.Commerce.Catalog.DataSources;
using Mediachase.Commerce.Catalog.Managers;
using Mediachase.Commerce.Catalog.Objects;
using Mediachase.Commerce.Core;
using Mediachase.Commerce.Website.Helpers;
using Mediachase.Commerce.Website.Search;
using Mediachase.Search.Extensions;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;
using EPiServer.Commerce.Sample.Templates.Sample.Units.CategoryDisplay.SharedModules;

namespace EPiServer.Commerce.Sample.Templates.Sample.Pages
{
    public partial class Search : TemplatePage<SearchPage>
    {
		private const string _allValue = "All";

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            searchResults.ItemDataBound += (searchResults_ItemDataBound);
        }

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);

            SearchFilterHelper helper = SearchFilterHelper.Current;
            var query = helper.QueryString["search"];

            if (!IsPostBack)
            {
                search.Text = query;

                ClassType.SelectedValue = helper.QueryString["type"];
            }

            var searchText = search.Text.Trim();
            if (!String.IsNullOrEmpty(searchText))
            {
                var classType = (ClassType.SelectedValue != _allValue) ? ClassType.SelectedValue : null;

                var currentMarketService = ServiceLocator.Current.GetInstance<ICurrentMarket>();
                var marketId = currentMarketService.GetCurrentMarket().MarketId;

                var language = SiteContext.Current.LanguageName;
            
                var qs = Request.QueryString;

                var pageSize = (qs[PagingMenu.DefaultShowAllKey] != null) ? 1000 : pagerTop.PageSize;

                var page = qs[PagingMenu.DefaultPageKey] != null
                                         ? Math.Max(Int32.Parse(qs[PagingMenu.DefaultPageKey]), 1)
                                         : 1;

                var startIndex = (page - 1) * pageSize;

                pagerTop.SetPageProperties(startIndex, pageSize, false);
                pagerBottom.SetPageProperties(startIndex, pageSize, false);

                int count = 0;
                var entries = GetEntries(searchText, classType, marketId, language, startIndex, pageSize, out count);

                SearchResultSummaryPlaceHolder.Visible = true;

                NumberOfHits.Text = count == 0
                            ? "no"
                            : count.ToString(CultureInfo.InvariantCulture);

                searchResults.DataSource = CreateDataSource(entries, count);
                searchResults.DataBind();
            }
        }

        protected void searchResults_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            using (var listViewDataItem = (ListViewDataItem)e.Item)
            {
                if (listViewDataItem == null)
                    return;

                var entry = (Entry)e.Item.DataItem;
                if (entry != null)
                {
                    var pricingInfo = listViewDataItem.FindControl("PricingInfo") as CommonPricingInfo;
                    if (pricingInfo != null)
                    {
                        var variation = entry.EntryType.Equals(EntryType.Variation) ? entry : entry.Entries.Entry.FirstOrDefault();
                        pricingInfo.SetEntry(variation);
                    }
                    
                    var commonButtons = listViewDataItem.FindControl("CommonButtons") as CommonButtons;
                    if (commonButtons != null)
                    {
                        commonButtons.SetEntry(entry);
                    }
                }
               
            }
        }

        /// <summary>
        /// Handles the Click event of the Search control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Search_Click(object sender, EventArgs e)
        {
            string searchText = Server.UrlEncode(search.Text.Trim());
            string classType = ClassType.SelectedValue.Trim();
            string query = UriSupport.AddQueryString(CurrentPage.LinkURL, "search", searchText);
            query = UriSupport.AddQueryString(query, "type", classType);
            Response.Redirect(query);
        }

        private static Entries GetEntries(string searchText, string classType, MarketId marketId, string languageName, int startIndex, int pageSize, out int count)
        {
            var helper = SearchFilterHelper.Current;
            var group = new CatalogEntryResponseGroup(CatalogEntryResponseGroup.ResponseGroup.CatalogEntryFull);
            CatalogEntrySearchCriteria criteria = helper.CreateSearchCriteria(searchText, CatalogEntrySearchCriteria.DefaultSortOrder);

            criteria.RecordsToRetrieve = pageSize;
            criteria.StartingRecord = startIndex;

            //class type
            if (classType != null)
            {
                criteria.ClassTypes.Add(classType);
            }

            criteria.Locale = languageName;
            criteria.MarketId = marketId;
            criteria.IncludeInactive = false;

            while (searchText.StartsWith("*") || searchText.StartsWith("?"))
                searchText = searchText.Substring(1);
            criteria.SearchPhrase = searchText;

            try
            {
                return helper.SearchEntries(criteria, out count, @group, true, new TimeSpan(0, 10, 0));
            }
            catch (Exception ex)
            {
                if (ex is StackOverflowException || ex is OutOfMemoryException)
                {
                    throw;
                }

                count = 0;
                return new Entries();
            }
        }
        
        /// <summary>
        /// Creates the data source.
        /// </summary>
        /// <param name="entries">The entries.</param>
        /// <param name="count">The count.</param>
        /// <returns></returns>
        private static CatalogIndexSearchDataSource CreateDataSource(Entries entries, int count)
        {
            var datasource = new CatalogIndexSearchDataSource();
            datasource.CatalogEntries = entries;
            datasource.TotalResults = count;
            return datasource;
        }

        private static void SetLiteralText(string controlName, string value, Control listViewDataItem)
        {
            var lit = listViewDataItem.FindControl(controlName) as Literal;
            if (lit != null)
            {
                lit.Text = value;
            }
        }
    }

}
