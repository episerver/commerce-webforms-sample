using EPiServer.Commerce.Catalog;
using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Sample.Helpers;
using EPiServer.Commerce.Sample.Templates.Sample.PageTypes;
using EPiServer.Commerce.SpecializedProperties;
using EPiServer.Core;
using EPiServer.Web;
using EPiServer.Web.Routing;
using Mediachase.Commerce.Catalog.Managers;
using Mediachase.Commerce.Catalog.Objects;
using System;
using System.Collections.Generic;
using System.Linq;
using EPiServer.Commerce.Extensions;
using EPiServer.Filters;
using Mediachase.Commerce.Catalog;
using Mediachase.Commerce;

namespace EPiServer.Commerce.Sample.BaseControls
{
    /// <summary>
    /// A base class for user controls handling commerce content
    /// </summary>
    /// <typeparam name="TContent"></typeparam>
    public class RendererControlBase<TContent> : ContentControlBase<TContent> where TContent : CatalogContentBase
    {
        private Entry _currentEntry;
        private UrlResolver _urlResolver;
        private IPermanentLinkMapper _permanentLinkMapper;
        private ICatalogSystem _catalogSystem;
        private IContentLoader _contentLoader;
        private ICurrentMarket _currentMarket;
        private AssetUrlResolver _assetUrlResolver;

        protected AssetUrlResolver AssetUrlResolverInstance
        {
            get { return _assetUrlResolver ?? Locate.Advanced.GetInstance<AssetUrlResolver>(); }
            set { _assetUrlResolver = value; }
        }

        protected UrlResolver UrlResolver
        {
            get { return _urlResolver ?? Locate.Advanced.GetInstance<UrlResolver>(); }
            set { _urlResolver = value; }
        }

        protected IPermanentLinkMapper LinkMapper
        {
            get { return _permanentLinkMapper ?? Locate.Advanced.GetInstance<IPermanentLinkMapper>(); }
            set { _permanentLinkMapper = value; }
        }

        protected ICatalogSystem CatalogSystem
        {
            get { return _catalogSystem ?? Locate.CatalogSystem(); }
            set { _catalogSystem = value; }
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

        protected Entry Entry
        {
            get
            {
                if (_currentEntry == null)
                {
                    var entry = CurrentData as EntryContentBase;
                    if (entry != null)
                    {
                        _currentEntry = CatalogSystem.GetCatalogEntry(entry.Code, new CatalogEntryResponseGroup(CatalogEntryResponseGroup.ResponseGroup.CatalogEntryInfo));
                    }
                }
                return _currentEntry;
            }
            set { _currentEntry = value; }
        }

        protected string GetUrl(CatalogContentBase content)
        {
            return content != null ? 
                VirtualPathUtilityEx.ToAbsolute(UrlResolver.GetUrl(content.ContentLink, content.Language.Name)) : 
                string.Empty;
        }

        protected string GetUrl(ContentReference contentLink)
        {
            return VirtualPathUtilityEx.ToAbsolute(UrlResolver.GetUrl(contentLink));
        }

        protected string GetUrl(ContentReference contentLink, string language)
        {
            return VirtualPathUtilityEx.ToAbsolute(UrlResolver.GetUrl(contentLink, language));
        }

        protected IEnumerable<TEntryContentBase> GetEntryChildren<TEntryContentBase>(ContentReference contentLink)
            where TEntryContentBase : EntryContentBase
        {
            return ForVisitor(() => ContentLoader.GetChildren<TEntryContentBase>(contentLink).Where(x => x.IsAvailableInCurrentMarket()));
        }

        protected IEnumerable<TNodeContentBase> GetNodeChildren<TNodeContentBase>(ContentReference contentLink)
            where TNodeContentBase : NodeContentBase
        {
            return ForVisitor(() => ContentLoader.GetChildren<TNodeContentBase>(contentLink));
        }

        protected IEnumerable<TVariationContent> GetVariants<TVariationContent>()
            where TVariationContent : VariationContent
        {
            var variantContainer = CurrentData as IVariantContainer;
            if (variantContainer == null)
            {
                return Enumerable.Empty<TVariationContent>();
            }

            return ForVisitor(() => variantContainer.GetVariantRelations()
                .Select(x => ContentLoader.Get<IContent>(x.Target) as TVariationContent)
                .Where(x => x != null));
        }

        protected IEnumerable<TCatalogContentBase> ForVisitor<TCatalogContentBase>(Func<IEnumerable<TCatalogContentBase>> action)
            where TCatalogContentBase : CatalogContentBase
        {
            return FilterCatalogContent.Filter(action()).Cast<TCatalogContentBase>();
        }

        protected SettingsBlock Settings
        {
            get
            {
                return ContentLoader.Get<HomePage>(ContentReference.StartPage).Settings;
            }
        }

        protected string GetMediaUrl(CommerceMedia media)
        {
            if (media == null)
            {
                return String.Empty;
            }

            return UrlResolver.GetUrl(media.AssetLink);
        }

        protected string GetMediaUrl(CatalogContentBase content)
        {
            return AssetUrlResolverInstance.GetAssetUrl(content as IAssetContainer);
        }

    }
}