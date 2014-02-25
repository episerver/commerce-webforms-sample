using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Catalog.DataAnnotations;
using EPiServer.DataAnnotations;
using System;

namespace EPiServer.Commerce.Sample.Models.MetaDataClasses
{
    [CatalogContentType(GUID = "35A29D99-3531-4E4B-A40E-EF262E9DB8B5", MetaClassName = "FashionStoreLandingNode")]
    [AvailableContentTypes(Include = new Type[] { typeof(FashionProductContent), typeof(FashionItemContent), typeof(NodeContent), typeof(BundleContent), typeof(PackageContent) })]
    public class FashionStoreLandingNodeContent : SiteCategoryContent
    {
    }
}