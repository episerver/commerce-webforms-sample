using EPiServer.DataAbstraction;
using EPiServer.DataAnnotations;

namespace EPiServer.Commerce.Sample.Templates.Sample.PageTypes
{
    [ContentType(GUID = "4E1AF541-C958-4AF1-8D5E-A0B1254F1A3D",
     DisplayName = "Change Your Account Info Page",
     Description = "The page which allows to edit account information.",
     GroupName = "CommerceSample",
     Order = 100)]
    public class ChangeAccountInfoPage : CommerceSampleModulePage
    {
    }
}