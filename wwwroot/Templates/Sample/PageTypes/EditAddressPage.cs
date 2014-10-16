using EPiServer.DataAnnotations;

namespace EPiServer.Commerce.Sample.Templates.Sample.PageTypes
{
    [ContentType(GUID = "97BA17E3-91F6-4209-A220-63B0F8BD896B",
     DisplayName = "Edit Addresses Page",
     Description = "The page which allows to add or edit an address.",
     GroupName = "CommerceSample",
     Order = 100)]
    public class EditAddressPage : CommerceSampleModulePage
    {
    }
}