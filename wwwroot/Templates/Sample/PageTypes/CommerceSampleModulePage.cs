using System.ComponentModel.DataAnnotations;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.DataAnnotations;

namespace EPiServer.Commerce.Sample.Templates.Sample.PageTypes
{
    public class CommerceSampleModulePage : CommerceSamplePage
    {
        [Display(
           Name = "PageTitle",
           Description = "PageTitle",
           GroupName = SystemTabNames.Content,
           Order = 1)]
        [Searchable(false)]
        [BackingType(typeof(PropertyString))]
        public virtual string PageTitle { get; set; }

        [Display(
            Name = "PageSubHeader",
            Description = "PageSubHeader",
            GroupName = SystemTabNames.Content,
            Order = 2)]
        [Searchable(false)]
        public virtual XhtmlString PageSubHeader { get; set; }
    }
}