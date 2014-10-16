using System.ComponentModel.DataAnnotations;
using EPiServer.Core;
using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Catalog.DataAnnotations;
using EPiServer.DataAnnotations;

namespace EPiServer.Commerce.Sample.Models.MetaDataClasses
{
    [CatalogContentType(GUID = "BE40A3E0-49BC-48DD-9C1D-819C2661C9BC", MetaClassName = "Fashion_Item_Class", GroupName = "Fashion",
        DisplayName = "Fashion variant/SKU", Description = "Displays a variation or SKU corresponds to a fashion products, with Add to Cart button.")]
    [ImageUrl("~/Templates/UX/gfx/page-type-thumbnail-fashion.png")]
    public class FashionItemContent : VariationContent, IInfoDescription
    {
        [Display(Name = "Description", Order = -15)]
        public virtual XhtmlString Info_Description { get; set; }

        [Display(Name = "Size")]
        public virtual string Facet_Size { get; set; }

        [Display(Name = "Color")]
        public virtual string Facet_Color { get; set; }

        [UIHint(UIHint.AllContent)]
        [Display(Name = "Related Item", Order = 99)]
        public virtual ContentReference RelatedItem { get; set; }
    }
}