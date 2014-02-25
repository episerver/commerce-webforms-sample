using System;
using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Catalog.DataAnnotations;
using EPiServer.DataAnnotations;

namespace EPiServer.Commerce.Sample.Models.MetaDataClasses
{
    [CatalogContentType(GUID = "C8E2094B-E969-4ACA-8174-D95BC0C68F48", MetaClassName = "DepartmentNodeWithItems")]
    [AvailableContentTypes(Include = new[] { typeof(VariationContent), typeof(NodeContent), typeof(BundleContent), typeof(PackageContent) })]
    public class DepartmentNodeWithItemsContent : NodeContent
    {
    }
}