using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Catalog.DataAnnotations;
using EPiServer.DataAnnotations;
using System;

namespace EPiServer.Commerce.Sample.Models.MetaDataClasses
{
    [CatalogContentType(GUID = "F4898452-B95F-4ECE-8C2F-3AABFE26A4C5", MetaClassName = "AutomotiveStoreSubLandingNode", GroupName = "Automotive",
        DisplayName = "Automotive category", Description = "An automotive category which consists automotive categories and products.")]
    [AvailableContentTypes(Include = new Type[] { typeof(AutomotiveItemContent), typeof(NodeContent), typeof(BundleContent), typeof(PackageContent) })]
    [ImageUrl("~/Templates/UX/gfx/page-type-thumbnail-automotive-sub-node.png")]
    public class AutomotiveStoreSubLandingNodeContent : SiteSubCategoryContent
    {
    }
}