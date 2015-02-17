using EPiServer.Commerce.Catalog;
using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Extensions;
using EPiServer.Commerce.Sample.Templates.Sample.PageTypes;
using EPiServer.Commerce.UI.Controllers;
using EPiServer.Core;
using EPiServer.Editor;
using EPiServer.Filters;
using EPiServer.Globalization;
using EPiServer.Security;
using EPiServer.Web;
using EPiServer.Web.Routing;
using Mediachase.Commerce;
using System.Linq;
using System.Web;

namespace EPiServer.Commerce.Sample.BaseControls
{
    /// <summary>
    /// A base class for Commerce Templates
    /// </summary>
    /// <typeparam name="TContent"></typeparam>
    public class RendererBase<TContent> : ContentPageBase<TContent> where TContent : CatalogContentBase
    {
        private UrlResolver _urlResolver;
        private ICurrentMarket _currentMarket;
        private IContentLoader _contentLoader;

        protected UrlResolver UrlResolver
        {
            get { return _urlResolver ?? Locate.Advanced.GetInstance<UrlResolver>(); }
            set { _urlResolver = value; }
        }

        protected IContentLoader ContentLoader
        {
            get { return _contentLoader ?? Locate.ContentLoader(); }
            set { _contentLoader = value; }
        }

        protected ICurrentMarket CurrentMarket
        {
            get { return _currentMarket ?? Locate.CurrentMarket(); }
            set { _currentMarket = value; }
        }

        protected override void OnInit(System.EventArgs e)
        {
            bool hasCatalogEditingAccess = false;

            if (PrincipalInfo.Current.Principal.IsInRole(Security.RoleNames.CommerceAdmins) ||
                PrincipalInfo.Current.Principal.IsInRole(Security.RoleNames.CatalogManagers))
            {
                hasCatalogEditingAccess = true;
            }
            if (!hasCatalogEditingAccess && new FilterContentForVisitor().ShouldFilter(CurrentContent))
            {
                RenderNotFound();
            }

            base.OnInit(e);
        }

        private void RenderNotFound()
        {
            Page.Response.Clear();
            ExceptionManager.RenderHttpRuntimeError(new HttpException(404, "Not Found"));
            Page.Response.End();
        }

        protected override void OnLoad(System.EventArgs e)
        {
            var entry = CurrentContent as EntryContentBase;
            var currentMarket = CurrentMarket.GetCurrentMarket();
            
            //Only redirected if not in edit view
            if (entry != null && !PageEditing.PageIsInEditMode)
            {
                if (entry.MarketFilter.Any(market => new MarketId(market) == currentMarket.MarketId))
                {
                    Context.RedirectFast(GetUrl(Settings.MarketNotSupportedPage));
                    return;
                }
                if (currentMarket.Languages.All(l => l.Name != ContentLanguage.PreferredCulture.Name))
                {
                    Context.RedirectFast(GetUrl(entry.ContentLink, currentMarket.DefaultLanguage.Name));
                    return;
                }

            }

            if (CurrentContent != null && CurrentContent.Property != null && CurrentContent.Property["SeoInformation"] != null)
            {
                var seoInformation = (SeoInformation)CurrentContent.Property["SeoInformation"].Value;
                if (!string.IsNullOrEmpty(seoInformation.Title))
                {
                    Page.Title = seoInformation.Title;
                }
                if (!string.IsNullOrEmpty(seoInformation.Description))
                {
                    Page.MetaDescription = seoInformation.Description;
                }
                if (!string.IsNullOrEmpty(seoInformation.Keywords))
                {
                    Page.MetaKeywords = seoInformation.Keywords;
                }
            }

            base.OnLoad(e);

            // Increase viewed count by calling the IncreaseView method in CmoGadgetController.
            if (!IsPostBack && entry != null)
            {
                CmoGadgetController.IncreaseView(entry.Code);
            }
        }

        public SettingsBlock Settings
        {
            get
            {
                return ContentLoader.Get<HomePage>(ContentReference.StartPage).Settings;
            }
        }

        protected string GetUrl(ContentReference contentLink)
        {
            return UrlResolver.GetUrl(contentLink);
        }

        protected string GetUrl(ContentReference contentLink, string language)
        {
            return UrlResolver.GetUrl(contentLink, language);
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