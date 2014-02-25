using System.ComponentModel.DataAnnotations;
using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Catalog.DataAnnotations;

namespace EPiServer.Commerce.Sample.Models.MetaDataClasses
{
    [CatalogContentType(GUID = "CB06EC73-D19A-4BD5-BB87-844B2FB884C4", MetaClassName = "Automotive_Item_Class")]
    public class AutomotiveItemContent : VariationContent, IFacetBrand, IInfoModelNumber
    {
        [Display(Name= "Model Number")]
        public virtual string Info_ModelNumber { get; set; }

        [Display(Name= "Facet Brand")]
        public virtual string Facet_Brand { get; set; }
    }
}
