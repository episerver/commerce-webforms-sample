using EPiServer.DataAnnotations;

namespace EPiServer.Commerce.Sample.Templates.Sample.PageTypes
{
    [ContentType(GUID = "E3060CBE-8857-49FB-B7FE-1A4E0540B935",
     DisplayName = "Order Details Page",
     Description = "The page which shows order details.",
     GroupName = "CommerceSample",
     Order = 100)]
    public class OrderDetailsPage : CommerceSampleModulePage
    {
    }
}