using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Catalog.DataAnnotations;
using EPiServer.DataAnnotations;
using System;

namespace EPiServer.Commerce.Sample.Models.MetaDataClasses
{
    [CatalogContentType(GUID = "F9DA8FA7-65B3-4424-BC2C-7758D49AA850", MetaClassName = "AutomotiveStoreLandingNode", GroupName = "Automotive",
        DisplayName = "Automotive store", Description = "Displays automotive store.")]
    [AvailableContentTypes(Include = new Type[] { typeof(AutomotiveItemContent), typeof(NodeContent), typeof(BundleContent), typeof(PackageContent) })]
    [ImageUrl("~/Templates/UX/gfx/page-type-thumbnail-automotive-node.png")]
    public class AutomotiveStoreLandingNodeContent : SiteCategoryContent
    {
    }
}