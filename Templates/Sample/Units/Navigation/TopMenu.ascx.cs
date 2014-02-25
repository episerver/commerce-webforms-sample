using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Sample.BaseControls;
using EPiServer.Commerce.Sample.Templates.Sample.PageTypes;
using EPiServer.Core;
using System;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.Navigation
{
    public partial class TopMenu : RendererControlBase<CatalogContentBase>
    {

        protected void PerformSearch(object sender, EventArgs e)
        {
            var searchPageRedirectUrl = GetUrl(Settings.SearchPage);
            string searchText = Server.UrlEncode(SearchKeywords.Text.Trim());
            searchPageRedirectUrl = UriSupport.AddQueryString(searchPageRedirectUrl, "search", searchText);
            Response.Redirect(searchPageRedirectUrl);
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                MenuListCtrl.DataBind();
            }
        }
    }
}