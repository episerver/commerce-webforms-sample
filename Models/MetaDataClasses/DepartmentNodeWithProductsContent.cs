using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Catalog.DataAnnotations;

namespace EPiServer.Commerce.Sample.Models.MetaDataClasses
{
    [CatalogContentType(GUID = "7AB5BB63-9B81-4D40-91FA-5551F985004D", MetaClassName = "DepartmentNodeWithProducts")]
    public class DepartmentNodeWithProductsContent : NodeContent
    {
    }
}