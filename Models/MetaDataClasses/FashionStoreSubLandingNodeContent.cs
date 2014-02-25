using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Catalog.DataAnnotations;
using EPiServer.DataAnnotations;
using System;

namespace EPiServer.Commerce.Sample.Models.MetaDataClasses
{
    [CatalogContentType(GUID = "4AAA80AB-393F-4A15-A787-03454EDE6E5E", MetaClassName = "FashionStoreSubLandingNode")]
    [AvailableContentTypes(Include = new Type[] { typeof(FashionProductContent), typeof(FashionItemContent), typeof(NodeContent), typeof(BundleContent), typeof(PackageContent)})]
    public class FashionStoreSubLandingNodeContent : SiteSubCategoryContent
    {
    }
}