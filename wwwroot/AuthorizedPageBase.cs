using System;
using EPiServer.Core;
using EPiServer.Web.Routing;
using EPiServer.Commerce.Sample.Templates.Sample.PageTypes;
using EPiServer.Web;
using EPiServer.Web.PageExtensions; 

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

        /// <summary>
        /// Constructs AuthorizedPageBase with AntiForgeryValidation's option flag to prevent cross site request forgery exploit.
        /// </summary>
        public AuthorizedPageBase() : base(AntiForgeryValidation.OptionFlag, 0) { }
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Request.IsAuthenticated)
            {
                Response.Redirect(VirtualPathUtilityEx.ToAbsolute(UrlResolver.GetUrl(Locate.ContentLoader().Get<HomePage>(ContentReference.StartPage).Settings.LoginPage)));
            }
        }
    }
}