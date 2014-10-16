using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Catalog.DataAnnotations;
using EPiServer.DataAnnotations;
using System;

namespace EPiServer.Commerce.Sample.Models.MetaDataClasses
{
    [CatalogContentType(GUID = "4AAA80AB-393F-4A15-A787-03454EDE6E5E", MetaClassName = "FashionStoreSubLandingNode", GroupName = "Fashion",
        DisplayName = "Fashion category", Description = "Displays a fashion category which consists fashion categories and products.")]
    [AvailableContentTypes(Include = new Type[] { typeof(FashionProductContent), typeof(FashionItemContent), typeof(NodeContent), typeof(BundleContent), typeof(PackageContent)})]
    [ImageUrl("~/Templates/UX/gfx/page-type-thumbnail-fashion-sub-node.png")]
    public class FashionStoreSubLandingNodeContent : SiteSubCategoryContent
    {
    }
}