using System.ComponentModel.DataAnnotations;
using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Catalog.DataAnnotations;

namespace EPiServer.Commerce.Sample.Models.MetaDataClasses
{
    [CatalogContentType(GUID = "8D2FAA84-28E5-41D4-9AF7-A867574B408F", MetaClassName = "Media_Product_Class")]
    public class MediaProductContent : ProductContent, IFacetBrand, IInfoModelNumber
    {
        [Display(Name = "Model Number")]
        public virtual string Info_ModelNumber { get; set; }

        [Display(Name = "Facet Brand")]
        public virtual string Facet_Brand { get; set; }
    }
}