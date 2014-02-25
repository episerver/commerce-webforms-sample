using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.SpecializedProperties;
using EPiServer.Core;
using EPiServer.ServiceLocation;
using EPiServer.Web;
using EPiServer.Web.Routing;
using Mediachase.Commerce.Catalog.Objects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EPiServer.Commerce.Sample.Helpers
{
    public static class AssetHelper
    {
        public const string DefaultUrl = "";
        private static Injected<IPermanentLinkMapper> _linkMapper;

        private static string GetVirtualPath(string assetKey)
        {
            var contentLinkMap = _linkMapper.Service.Find(new Guid(assetKey));
            if (contentLinkMap == null)
            {
                return DefaultUrl;
            }
            return contentLinkMap.MappedUrl.ToString();
        }
        
        public static string GetAssetUrl(Entry entry)
        {
            if (entry.Assets != null)
            {
                var assetKey = entry.Assets.OrderBy(a => a.SortOrder).FirstOrDefault().AssetKey;
                return GetVirtualPath(assetKey);
            }         
            return DefaultUrl;            
        }

        public static string GetAssetUrl(CatalogNode node)
        {
            if (node.Assets != null)
            {
                var assetKey = node.Assets.OrderBy(a => a.SortOrder).FirstOrDefault().AssetKey;
                return GetVirtualPath(assetKey); 
            }
            return DefaultUrl;
        }

        public static string GetAssetUrl(IList<CommerceMedia> content)
        {
            if (content != null)
            {
                var commerceMedia = content.FirstOrDefault();
                if (commerceMedia != null)
                {
                    return GetVirtualPath(commerceMedia.AssetKey);
                }
            }
            return DefaultUrl;
        }
    }
}