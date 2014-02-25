using System;
using EPiServer.Core;
using EPiServer.Web.Routing;
using EPiServer.Commerce.Sample.Templates.Sample.PageTypes; 

namespace EPiServer.Commerce.Sample
{
    public class AuthorizedPageBase<T> : TemplatePage<T> where T : PageData
    {
        private UrlResolver _urlResolver;

        protected UrlResolver UrlResolver
        {
            get { return _urlResolver ?? Locate.Advanced.GetInstance<UrlResolver>(); }
            set { _urlResolver = value; }
        }
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Request.IsAuthenticated)
                Response.Redirect(String.Concat("~", UrlResolver.GetUrl(Locate.ContentLoader().Get<HomePage>(ContentReference.StartPage).Settings.LoginPage)));
        }
    }
}