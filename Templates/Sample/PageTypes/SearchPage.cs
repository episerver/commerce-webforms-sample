using EPiServer.DataAnnotations;

namespace EPiServer.Commerce.Sample.Templates.Sample.PageTypes
{
    [ContentType(GUID = "7b6d05bd-d941-4c12-aad1-e5d30b6e12eb",
        DisplayName = "Search Page",
        GroupName = "CommerceSample",
        Order = 100,
        Description = "A page which is used to show search result.")]
    public class SearchPage : CommerceSamplePage
    {
        
    }
}