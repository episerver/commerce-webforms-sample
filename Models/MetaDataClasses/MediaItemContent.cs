using System.ComponentModel.DataAnnotations;
using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Catalog.DataAnnotations;

namespace EPiServer.Commerce.Sample.Models.MetaDataClasses
{
    [CatalogContentType(GUID = "A6C48945-8072-4A1A-83D5-685C682D41AF", MetaClassName = "Media_Item_Class")]
    public class MediaItemContent : VariationContent
    {
        [Display(Name = "Media Type")]
        public virtual string Facet_MediaType { get; set; }
    }
}