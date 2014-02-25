using EPiServer.DataAnnotations;

namespace EPiServer.Commerce.Sample.Templates.Sample.PageTypes
{
    [ContentType(GUID = "3FE3BD9F-7101-49ED-B99D-AACF40459D56",
     DisplayName = "Orders Page",
     Description = "The page shows orders.",
     GroupName = "CommerceSample",
     Order = 100)]
    public class OrdersPage : CommerceSampleModulePage
    {
    }
}