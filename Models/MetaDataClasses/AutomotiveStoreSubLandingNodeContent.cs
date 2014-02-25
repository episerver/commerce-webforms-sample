using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Catalog.DataAnnotations;
using EPiServer.DataAnnotations;
using System;

namespace EPiServer.Commerce.Sample.Models.MetaDataClasses
{
    [CatalogContentType(GUID = "F4898452-B95F-4ECE-8C2F-3AABFE26A4C5", MetaClassName = "AutomotiveStoreSubLandingNode")]
    [AvailableContentTypes(Include = new Type[] { typeof(AutomotiveItemContent), typeof(NodeContent), typeof(BundleContent), typeof(PackageContent) })]
    public class AutomotiveStoreSubLandingNodeContent : SiteSubCategoryContent
    {
    }
}