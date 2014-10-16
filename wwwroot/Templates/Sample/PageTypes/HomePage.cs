using System.ComponentModel.DataAnnotations;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.DataAnnotations;

namespace EPiServer.Commerce.Sample.Templates.Sample.PageTypes
{
    [ContentType(GUID = "3B579852-D4AD-41D5-B4BA-50FF4CC55A6A",
        DisplayName = "Home Page",
        Description = "",
        GroupName = "CommerceSample",
        Order = 100)]
    public class HomePage : CommerceSamplePage
    {
        [Searchable(false)]
        [Display(
            Name = "HomeHero",
            Description = "HomeHero",
            GroupName = SystemTabNames.Content,
            Order = 1)]
        public virtual XhtmlString HomeHero { get; set; }

        [Searchable(false)]
        [Display(
            Name = "BodyMarkup",
            Description = "BodyMarkup",
            GroupName = SystemTabNames.Content,
            Order = 2)]
        public virtual XhtmlString BodyMarkup { get; set; }

        [Display(
            Name = "SiteSettings",
            Description = "Global settings for this site.",
            GroupName = SystemTabNames.Settings,
            Order = 0)]
        public virtual SettingsBlock Settings { get; set; }
    }
}