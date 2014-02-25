using System;
using System.ComponentModel.DataAnnotations;
using EPiServer.Core;
using EPiServer.DataAnnotations;
using EPiServer.DataAbstraction; 

namespace EPiServer.Commerce.Sample.Templates.Sample.PageTypes
{
    [ContentType(GUID = "AC631D10-4F34-4786-BFED-D1F3A6CDB882",
                  DisplayName = "Warehouses Page",
                  GroupName = "CommerceSample",
                  Order = 100,
                  Description = "The warehouse page.")]  
    public class WarehousesPage : CommerceSamplePage
    {
        [Required]
        [Searchable(false)]
        [BackingType(typeof(PropertyString))]
        [Display(  Name = "PageTitle",
                   Description = "PageTitle",
                   GroupName = SystemTabNames.Content,
                   Order = 1)]
        public virtual string PageTitle { get; set; }

        [Searchable(false)]
        [Display(  Name = "PageSubHeader",
                   Description = "PageSubHeader",
                   GroupName = SystemTabNames.Content,
                   Order = 2)]
        public virtual XhtmlString PageSubHeader { get; set; } 
         
        [Searchable(false)]
        [Display(  Name = "BodyMarkup",
                   Description = "BodyMarkup",
                   GroupName = SystemTabNames.Content,
                   Order = 3)]
        public virtual XhtmlString BodyMarkup { get; set; } 
    }
}