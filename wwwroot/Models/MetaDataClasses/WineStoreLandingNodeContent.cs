using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Catalog.DataAnnotations;
using EPiServer.DataAnnotations;
using System;

namespace EPiServer.Commerce.Sample.Models.MetaDataClasses
{
    [CatalogContentType(GUID = "EB8059BC-AEFC-46A1-83FC-7C678D5E8258", MetaClassName = "WineStoreLandingNode", GroupName = "Wine",
        DisplayName = "Wine store", Description = "Display wine store.")]
    [AvailableContentTypes(Include = new Type[] { typeof(WineSKUContent), typeof(NodeContent), typeof(BundleContent), typeof(PackageContent) })]
    [ImageUrl("~/Templates/UX/gfx/page-type-thumbnail-wine-node.png")]
    public class WineStoreLandingNodeContent : SiteCategoryContent
    {
    }
}