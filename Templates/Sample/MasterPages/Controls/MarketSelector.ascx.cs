using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using EPiServer.ServiceLocation;
using Mediachase.Commerce;
using Mediachase.Commerce.Markets;
using EPiServer.Core;
using EPiServer.Web.Routing;
using EPiServer.Globalization;

namespace EPiServer.Commerce.Sample.Templates.Sample.MasterPages.Controls
{
    public partial class MarketSelector : System.Web.UI.UserControl
    {
        private readonly ICurrentMarket _currentMarket = ServiceLocator.Current.GetInstance<ICurrentMarket>();
        private readonly IMarketService _marketService = ServiceLocator.Current.GetInstance<IMarketService>();
        private readonly ContentRouteHelper _contentRouteHelper = ServiceLocator.Current.GetInstance<ContentRouteHelper>();

        public readonly string SetMarket = "SetMarket";    

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Get all markets and bind to repeater.
                var listMarket = _marketService.GetAllMarkets().Where(m => m.IsEnabled);
                MarketList.DataSource = listMarket;
                MarketList.DataBind();
            }
        }

        protected void MarketList_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            var currentMarket = _currentMarket.GetCurrentMarket();
            var item = e.Item;
            if (item.ItemType == ListItemType.Header)
            {
                // Set header to the current market
                ActOnControl<Literal>(item, "litCurrentMarket", c => c.Text = currentMarket.MarketName);
                return;
            }

            // If this line is not for current market, return
            var marketDataItem = item.DataItem as IMarket;
            if (marketDataItem == null || (marketDataItem.MarketId.Value != currentMarket.MarketId.Value))
            {
                return;
            }

            // Visually indicate that current market is active
            ActOnControl<HtmlGenericControl>(item, "liMarketItem", c => c.Attributes.Add("class", "active"));

            // Disable link to set this market as current (is already current...)
            ActOnControl<LinkButton>(item, "linkSetMarket", c => c.Enabled = false);
        }

        private static void ActOnControl<T>(Control item, string controlName, Action<T> act) where T : System.Web.UI.Control
        {
            var control = item.FindControl(controlName) as T;
            if (control != null)
            {
                act(control);
            }
        }

        protected void MarketList_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName != SetMarket)
                return;

            _currentMarket.SetCurrentMarket(new MarketId(e.CommandArgument.ToString()));
            
            // Redirect to the page url in ContentLanguage.PreferredCulture.Name language
            var contentLink = _contentRouteHelper.ContentLink;
            if (contentLink != null)
            {
                string queryString = Request.Url.Query;
                Context.RedirectFast(new UrlResolver().GetUrl(contentLink, ContentLanguage.PreferredCulture.Name) + queryString);
            }
            else
            {
                Context.RedirectFast(Request.RawUrl);
            }
        }
    }
}
