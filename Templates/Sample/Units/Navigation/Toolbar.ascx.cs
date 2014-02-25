using System;
using System.Web.UI;
using EPiServer.Core;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.Navigation
{
    public partial class Toolbar : EPiServer.UserControlBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SearchButton_Click(object sender, ImageClickEventArgs e)
        {
            var searchString = Server.UrlEncode(QuickSearchTextBox.Text.Trim());
            var searchPageRef = CurrentPage["SearchPage"] as PageReference;
            if (string.IsNullOrEmpty(searchString) || searchPageRef == null)
                return;

            var searchPage = GetPage(searchPageRef);
            Context.RedirectFast(String.Format("{0}&quicksearch={1}", searchPage.LinkURL, searchString));
        }
    }
}