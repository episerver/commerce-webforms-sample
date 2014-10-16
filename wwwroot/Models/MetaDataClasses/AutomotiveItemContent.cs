using System.ComponentModel.DataAnnotations;
using EPiServer.Core;
using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Catalog.DataAnnotations;
using EPiServer.DataAnnotations;

namespace EPiServer.Commerce.Sample.Models.MetaDataClasses
{
    [CatalogContentType(GUID = "CB06EC73-D19A-4BD5-BB87-844B2FB884C4", MetaClassName = "Automotive_Item_Class", GroupName = "Automotive",
        DisplayName = "Automotive variant/SKU", Description = "Displays automotive variation/SKU, with Add to Cart button.")]
    [ImageUrl("~/Templates/UX/gfx/page-type-thumbnail-automotive.png")]
    public class AutomotiveItemContent : VariationContent, IInfoDescription, IInfoFeatures, IFacetBrand, IInfoModelNumber
    {
        [Display(Name = "Description", Order = -15)]
        public virtual XhtmlString Info_Description { get; set; }

        [Display(Name = "Features", Order = -11)]
        public virtual XhtmlString Info_Features { get; set; }

        [Display(Name = "Model Number", Order = -3)]
        public virtual string Info_ModelNumber { get; set; }

        [Display(Name = "Facet Brand", Order = -1)]
        public virtual string Facet_Brand { get; set; }
    }
}
