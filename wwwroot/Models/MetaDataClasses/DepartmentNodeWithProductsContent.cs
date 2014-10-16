using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Catalog.DataAnnotations;
using EPiServer.Core;
using EPiServer.DataAnnotations;
using System.ComponentModel.DataAnnotations;

namespace EPiServer.Commerce.Sample.Models.MetaDataClasses
{
    [CatalogContentType(GUID = "7AB5BB63-9B81-4D40-91FA-5551F985004D", MetaClassName = "DepartmentNodeWithProducts", 
        DisplayName = "Product list", Description = "Displays a list of products.")]
    [ImageUrl("~/Templates/UX/gfx/page-type-thumbnail-product-list.png")]
    public class DepartmentNodeWithProductsContent : NodeContent
    {
        [Display(Name = "Link Reference", Order = 99)]
        [UIHint(UIHint.AllContent)]
        public virtual ContentReference LinkReference { get; set; }
    }
}