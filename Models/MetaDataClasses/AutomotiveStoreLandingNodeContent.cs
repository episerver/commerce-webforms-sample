using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Catalog.DataAnnotations;
using EPiServer.DataAnnotations;
using System;

namespace EPiServer.Commerce.Sample.Models.MetaDataClasses
{
    [CatalogContentType(GUID = "F9DA8FA7-65B3-4424-BC2C-7758D49AA850", MetaClassName = "AutomotiveStoreLandingNode")]
    [AvailableContentTypes(Include = new Type[] { typeof(AutomotiveItemContent), typeof(NodeContent), typeof(BundleContent), typeof(PackageContent) })]
    public class AutomotiveStoreLandingNodeContent : SiteCategoryContent
    {
    }
}