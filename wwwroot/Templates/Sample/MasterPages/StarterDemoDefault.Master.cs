using EPiServer.Commerce.Sample.Templates.Sample.PageTypes;
using EPiServer.Core;
using EPiServer.Globalization;
using EPiServer.Web.Routing;
using Mediachase.Commerce.Website.Helpers;
using System;
using System.Linq;
using System.Web.Routing;

namespace EPiServer.Commerce.Sample.Templates.Sample.MasterPages
{
    public partial class StarterDemoDefault : System.Web.UI.MasterPage
    {
        private readonly CartHelper _cartHelper = new CartHelper(Mediachase.Commerce.Orders.Cart.DefaultName);

        /// <summary>
        /// Handles the PreRender event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        /// <remarks>The logic needs to happen here since the cart can change significantly after the Load event of this page. 
        /// For example, you can add an entry that is (from a UI viewpoint) immediately removed by a workflow like CartValidateWorkflow, leaving you with an empty cart, 
        /// but this page would not know about that.</remarks>
        protected void Page_PreRender(object sender, EventArgs e)
        {
            cartLink.InnerHtml = String.Format("<span class='visible-xs'><i class=\"glyphicon glyphicon-shopping-cart\">({0})</span><span class='hidden-xs'><i class=\"glyphicon glyphicon-shopping-cart\"></i>Cart - {0} Items</span>", _cartHelper.LineItems.Count());
            cartLink.HRef = UrlToPage(Settings.CartPage);
            Page.Header.DataBind();
        }

        public SettingsBlock Settings
        {
            get
            {
                return ((HomePage)PageBase.GetPage(ContentReference.StartPage)).Settings;
            }
        }

        public string UrlToPage(PageReference pageLink)
        {
            return new UrlResolver().GetUrl(pageLink, ContentLanguage.PreferredCulture.Name);
        }

        public virtual PageBase PageBase
        {
            get
            {
                var page = Page as PageBase;
                if (page != null)
                {
                    return page;
                }
                page = Context.Handler as PageBase;

                return page;

            }
        }
    }
}
