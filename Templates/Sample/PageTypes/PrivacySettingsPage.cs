using EPiServer.DataAnnotations;

namespace EPiServer.Commerce.Sample.Templates.Sample.PageTypes
{
    [ContentType(GUID = "47D051B2-DF62-44F1-AA76-611466AC5C83",
     DisplayName = "Privacy Settings Page",
     Description = "The page shows privacy settings.",
     GroupName = "CommerceSample",
     Order = 100)]
    public class PrivacySettingsPage : CommerceSampleModulePage
    {
    }
}