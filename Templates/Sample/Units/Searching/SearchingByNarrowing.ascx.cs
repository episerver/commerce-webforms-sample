using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using Mediachase.Commerce.Catalog;
using Mediachase.Commerce.Catalog.DataSources;
using Mediachase.Commerce.Catalog.Managers;
using Mediachase.Commerce.Catalog.Objects;
using Mediachase.Commerce.Core;
using Mediachase.Commerce.Pricing;
using Mediachase.Commerce.Website.Search;
using Mediachase.Search;
using Mediachase.Search.Extensions;
using log4net;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.Searching
{
    public partial class SearchingByNarrowing : UserControl
    {
        #region Fields

        private ISearchFacetGroup[] _facets;
        private SelectedFilter[] _filters;
        private int _startRowIndex;

        #endregion

        #region Event Handlers

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindResults(false);
            }
        }

        /// <summary>
        /// Handles the Click event of the lnkList control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void lnkList_Click(object sender, EventArgs e)
        {
            BindResults(true);
        }

        /// <summary>
        /// Handles the Click event of the lnkGrid control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void lnkGrid_Click(object sender, EventArgs e)
        {
            BindResults(false);
        }

        /// <summary>
        /// Gets the facet URL.
        /// </summary>
        /// <param name="facet">The facet.</param>
        /// <returns></returns>
        protected string GetFacetUrl(ISearchFacet facet)
        {
            return SearchFilterHelper.GetQueryStringNavigateUrl(facet.Group.FieldName, facet.Key);
        }

        #endregion

        #region Display Methods

        /// <summary>
        /// Gets the price.
        /// </summary>
        /// <param name="entry">The entry.</param>
        /// <returns></returns>
        protected string GetPrice(Entry entry)
        {
            if (entry.Entries.Entry == null)
                return string.Empty;

            var firstSku = entry.Entries[0];
            if (firstSku == null)
                return string.Empty;

            IEnumerable<IPriceValue> prices = firstSku.PriceValues.PriceValue.OrderBy(p => p.UnitPrice);
            return prices.First().UnitPrice.ToString();
        }

        /// <summary>
        /// Gets the inventory.
        /// </summary>
        /// <param name="entry">The entry.</param>
        /// <returns></returns>
        protected string GetInventory(Entry entry)
        {
            var ret = "0";
            if (entry.Entries.Entry.FirstOrDefault(w => !string.IsNullOrWhiteSpace(GetPrice(w))) != null)
            {
                var inventory = entry.Entries.Entry.FirstOrDefault(w => w.WarehouseInventories != null).WarehouseInventories.WarehouseInventory;
                if (inventory != null)
                    ret = inventory.Sum(i => i.InStockQuantity).ToString("f0");
            }
            return ret;
        }

        /// <summary>
        /// Handles the PagePropertiesChanging event of the EntriesList2 control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.PagePropertiesChangingEventArgs"/> instance containing the event data.</param>
        protected void EntriesList_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            _startRowIndex = e.StartRowIndex;
            BindResults(false);
        }

        /// <summary>
        /// Handles the PagePropertiesChanging event of the listView control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.PagePropertiesChangingEventArgs"/> instance containing the event data.</param>
        protected void listView_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            _startRowIndex = e.StartRowIndex;
            BindResults(true);
        }

        #endregion

        #region Helper Methods

        /// <summary>
        /// Binds the results.
        /// </summary>
        private void BindResults(bool list)
        {
            SearchSort sortObject = CatalogEntrySearchCriteria.DefaultSortOrder;
            //string sort = SortBy.SelectedValue;
            //if (!String.IsNullOrEmpty(sort))
            //{
            //    if (sort.Equals("name", StringComparison.OrdinalIgnoreCase))
            //        sortObject = new SearchSort("displayname");
            //    else if (sort.Equals("plh", StringComparison.OrdinalIgnoreCase))
            //        sortObject =
            //            new SearchSort(String.Format("saleprice{0}", SiteContext.Current.CurrencyCode).ToLower());
            //    else if (sort.Equals("phl", StringComparison.OrdinalIgnoreCase))
            //        sortObject =
            //            new SearchSort(String.Format("saleprice{0}", SiteContext.Current.CurrencyCode).ToLower(), true);
            //}

            var group = new CatalogEntryResponseGroup(CatalogEntryResponseGroup.ResponseGroup.CatalogEntryFull);
            SearchFilterHelper helper = SearchFilterHelper.Current;
            CatalogEntrySearchCriteria criteria = helper.CreateSearchCriteria("", sortObject);
            //AddNodesToCriteria(criteria);
            criteria.RecordsToRetrieve = 25;
            criteria.StartingRecord = _startRowIndex;
            criteria.ClassTypes.Add("Product");

            var searchManager = new SearchManager(AppContext.Current.ApplicationName);
            try
            {
                var results = searchManager.Search(criteria);
                if (results == null)
                    return;

                var resultIndexes = results.GetKeyFieldValues<int>();
                var entries = CatalogContext.Current.GetCatalogEntries(resultIndexes, group);
                if (entries.Entry != null)
                {
                    var ds = CreateDataSource(entries, results.TotalCount);
                    if (!list)
                    {
                        EntriesList.DataSource = ds;
                        EntriesList.DataBind();
                        EntriesList.Visible = true;
                        listView.Visible = false;
                    }
                    else
                    {
                        listView.DataSource = ds;
                        listView.DataBind();
                        EntriesList.Visible = false;
                        listView.Visible = true;
                    }

                    if (results.TotalCount < 25)
                    {
                        DataPager3.Visible = false;
                    }
                }

                _filters = helper.SelectedFilters;
                _facets = results.FacetGroups;

                if (_filters != null && _filters.Length > 0)
                {
                    ActiveFilterList.DataSource = _filters;
                    ActiveFilterList.DataBind();
                    ActiveFilterList.Visible = true;
                }
                else
                {
                    ActiveFilterList.Visible = false;
                }

                if (_facets != null && _facets.Length > 0)
                {
                    FilterList.Visible = true;
                    FilterList.DataSource = _facets;
                    FilterList.DataBind();
                }
                else
                {
                    FilterList.Visible = false;
                }

            }
            catch (Exception ex)
            {
                LogManager.GetLogger(GetType()).Error(ex.Message, ex);
            }
        }

        /// <summary>
        /// Creates the data source.
        /// </summary>
        /// <param name="entries">The entries.</param>
        /// <param name="count">The count.</param>
        /// <returns></returns>
        private CatalogIndexSearchDataSource CreateDataSource(Entries entries, int count)
        {
            var datasource = new CatalogIndexSearchDataSource();
            datasource.CatalogEntries = entries;
            datasource.TotalResults = count;
            return datasource;
        }

        #endregion
    }
}