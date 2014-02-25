using System.ComponentModel.DataAnnotations;
using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Catalog.DataAnnotations;

namespace EPiServer.Commerce.Sample.Models.MetaDataClasses
{
    [CatalogContentType(GUID = "BE40A3E0-49BC-48DD-9C1D-819C2661C9BC", MetaClassName = "Fashion_Item_Class")]
    public class FashionItemContent : VariationContent
    {
        [Display(Name = "Size")]
        public virtual string Facet_Size { get; set; }

        [Display(Name = "Color")]
        public virtual string Facet_Color { get; set; }
    }
}