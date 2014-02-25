using EPiServer.DataAbstraction;
using EPiServer.DataAnnotations;

namespace EPiServer.Commerce.Sample.Templates.Sample.PageTypes
{
    [ContentType(GUID = "6B7DCD26-0F90-498D-98A3-3EDFDEBF7D87",
     DisplayName = "Change Password Page",
     Description = "The page which allows to change current password.",
     GroupName = "CommerceSample",
     Order = 100)]
    public class ChangePasswordPage : CommerceSampleModulePage
    {
    }
}