using System.ComponentModel.DataAnnotations;
using EPiServer.Core;
using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Catalog.DataAnnotations;
using EPiServer.DataAnnotations;

namespace EPiServer.Commerce.Sample.Models.MetaDataClasses
{
    [CatalogContentType(GUID = "B96A3924-D07D-4ECA-BFA3-C0C3138CD138", MetaClassName = "WineSKU", GroupName = "Wine",
        DisplayName = "Wine variant/SKU", Description = "Displays wine variation/SKU, with Add to Cart button.")]
    [ImageUrl("~/Templates/UX/gfx/page-type-thumbnail-wine.png")]
    public class WineSKUContent : VariationContent, IInfoDescription, IInfoFeatures, IFacetBrand, IInfoModelNumber
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