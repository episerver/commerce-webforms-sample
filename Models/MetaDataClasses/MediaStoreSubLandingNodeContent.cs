using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Catalog.DataAnnotations;
using EPiServer.DataAnnotations;
using System;

namespace EPiServer.Commerce.Sample.Models.MetaDataClasses
{
    [CatalogContentType(GUID = "C4B4BBCF-F983-4480-A071-0F530F9F65E1", MetaClassName = "MediaStoreSubLandingNode")]
    [AvailableContentTypes(Include = new Type[] { typeof(MediaProductContent), typeof(MediaItemContent), typeof(NodeContent), typeof(BundleContent), typeof(PackageContent) })]
    public class MediaStoreSubLandingNodeContent : SiteSubCategoryContent
    {
    }
}