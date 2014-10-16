using EPiServer.DataAnnotations;

namespace EPiServer.Commerce.Sample.Templates.Sample.PageTypes
{
    [ContentType(GUID = "3FE3BD9F-7101-49ED-B99D-AACF40459374",
         DisplayName = "WishList Page",
         Description = "The page shows user's wish list.",
         GroupName = "CommerceSample",
         Order = 100)]
    public class WishListPage : CommerceSampleModulePage
    {
    }
}