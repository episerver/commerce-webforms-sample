using System;
using System.ComponentModel.DataAnnotations;
using EPiServer.Core;
using EPiServer.DataAnnotations;
using EPiServer.DataAbstraction; 

namespace EPiServer.Commerce.Sample.Templates.Sample.PageTypes
{
    [ContentType( GUID = "760AEE27-E362-49EE-BFAC-4FE32F2C4EFB",
                  DisplayName = "Default Page",
                  GroupName = "CommerceSample",
                  Order = 100,
                  Description = "The default page.")]
    public class DefaultPage : CommerceSamplePage
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