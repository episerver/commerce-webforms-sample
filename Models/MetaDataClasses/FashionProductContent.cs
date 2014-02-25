using System.ComponentModel.DataAnnotations;
using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Catalog.DataAnnotations;

namespace EPiServer.Commerce.Sample.Models.MetaDataClasses
{
    /// <summary>
    /// FashionProductContent class, map to Fashion_Product_Class metadata class
    /// </summary>
    [CatalogContentType(GUID = "18EA436F-3B3B-464E-A526-564E9AC454C7", MetaClassName = "Fashion_Product_Class")]
    public class FashionProductContent : ProductContent, IFacetBrand, IInfoModelNumber
    {
        [Display(Name = "Model Number")]
        public virtual string Info_ModelNumber { get; set; }

        [Display(Name = "Facet Brand")]
        public virtual string Facet_Brand { get; set; }
    }
}