using System.ComponentModel.DataAnnotations;
using EPiServer.Core;
using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Catalog.DataAnnotations;
using EPiServer.DataAnnotations;

namespace EPiServer.Commerce.Sample.Models.MetaDataClasses
{
    [CatalogContentType(GUID = "8D2FAA84-28E5-41D4-9AF7-A867574B408F", MetaClassName = "Media_Product_Class", GroupName = "Media",
        DisplayName = "Media product", Description = "Display media product with Add to Cart button.")]
    [ImageUrl("~/Templates/UX/gfx/page-type-thumbnail-media.png")]
    public class MediaProductContent : ProductContent, IInfoDescription, IInfoFeatures, IFacetBrand, IInfoModelNumber
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