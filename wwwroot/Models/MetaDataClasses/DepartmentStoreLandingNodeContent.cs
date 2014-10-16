using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Catalog.DataAnnotations;
using EPiServer.DataAnnotations;

namespace EPiServer.Commerce.Sample.Models.MetaDataClasses
{
    [CatalogContentType(GUID = "9CD91295-6484-44E7-A9FC-D3AD6CE0184E", MetaClassName = "DepartmentStoreLandingNode", 
        DisplayName = "Department store", Description = "Displays a list of stores.")]
    [ImageUrl("~/Templates/UX/gfx/page-type-thumbnail-department-store.png")]
    public class DepartmentStoreLandingNodeContent : SiteCategoryContent
    {
    }
}