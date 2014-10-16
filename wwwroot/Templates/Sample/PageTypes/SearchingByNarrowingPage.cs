using EPiServer.DataAnnotations;

namespace EPiServer.Commerce.Sample.Templates.Sample.PageTypes
{
    [ContentType(GUID = "78C1FE99-8E61-4F25-9EF1-62AFFEF4DEAE",
        DisplayName = "Searching By Narrowing Page",
        GroupName = "CommerceSample",
        Order = 100,
        Description = "The page which shows result by searching by narrowing.")]
    public class SearchingByNarrowingPage : CommerceSampleModulePage  
    {
        
    }
}