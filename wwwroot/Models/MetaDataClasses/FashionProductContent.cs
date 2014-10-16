using System.ComponentModel.DataAnnotations;
using EPiServer.Core;
using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Catalog.DataAnnotations;
using EPiServer.DataAnnotations;

namespace EPiServer.Commerce.Sample.Models.MetaDataClasses
{
    /// <summary>
    /// FashionProductContent class, map to Fashion_Product_Class metadata class
    /// </summary>
    [CatalogContentType(GUID = "18EA436F-3B3B-464E-A526-564E9AC454C7", MetaClassName = "Fashion_Product_Class", GroupName = "Fashion",
        DisplayName = "Fashion product", Description = "Display fashion product with Add to Cart button.")]
    [ImageUrl("~/Templates/UX/gfx/page-type-thumbnail-fashion.png")]
    public class FashionProductContent : ProductContent, IInfoDescription, IInfoFeatures, IFacetBrand, IInfoModelNumber
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