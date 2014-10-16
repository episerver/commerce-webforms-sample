using System.ComponentModel.DataAnnotations;
using EPiServer.Core;
using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Catalog.DataAnnotations;
using EPiServer.DataAnnotations;

namespace EPiServer.Commerce.Sample.Models.MetaDataClasses
{
    [CatalogContentType(GUID = "A6C48945-8072-4A1A-83D5-685C682D41AF", MetaClassName = "Media_Item_Class", GroupName = "Media",
        DisplayName = "Media variant/SKU", Description = "Displays a variation or SKU corresponds to a media product, with Add to Cart button.")]
    [ImageUrl("~/Templates/UX/gfx/page-type-thumbnail-media.png")]
    public class MediaItemContent : VariationContent, IInfoDescription, IInfoModelNumber
    {
        [Display(Name = "Description", Order = -15)]
        public virtual XhtmlString Info_Description { get; set; }

        [Display(Name = "Model Number", Order = -3)]
        public virtual string Info_ModelNumber { get; set; }

        [Display(Name = "Media Type")]
        public virtual string Facet_MediaType { get; set; }
    }
}