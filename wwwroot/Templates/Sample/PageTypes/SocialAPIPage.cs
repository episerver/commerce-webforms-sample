using EPiServer.DataAnnotations;

namespace EPiServer.Commerce.Sample.Templates.Sample.PageTypes
{
    /// <summary>
    /// This is typed page data for the Social API
    /// </summary>
    [ContentType(GUID = "930D2150-4DA3-4B79-AF33-0C2D07855F0C",
        DisplayName = "SocialAPI Page",
        GroupName = "CommerceSample",
        Order = 100,
        Description = "")]
    public class SocialAPIPage : CommerceSamplePage
    {

    }
}