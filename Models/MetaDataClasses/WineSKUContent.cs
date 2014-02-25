using System.ComponentModel.DataAnnotations;
using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Catalog.DataAnnotations;

namespace EPiServer.Commerce.Sample.Models.MetaDataClasses
{
    [CatalogContentType(GUID = "B96A3924-D07D-4ECA-BFA3-C0C3138CD138", MetaClassName = "WineSKU")]
    public class WineSKUContent : VariationContent, IFacetBrand, IInfoModelNumber
    {
        [Display(Name = "Model Number")]
        public virtual string Info_ModelNumber { get; set; }

        [Display(Name = "Facet Brand")]
        public virtual string Facet_Brand { get; set; }
    }
}