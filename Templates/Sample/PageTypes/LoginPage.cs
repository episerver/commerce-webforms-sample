using EPiServer.DataAbstraction;
using EPiServer.DataAnnotations;

namespace EPiServer.Commerce.Sample.Templates.Sample.PageTypes
{
    [ContentType(GUID = "ECC455C7-FD07-4480-970E-3FB8D0F85BDE",
     DisplayName = "Login Page",
     Description = "Login Page",
     GroupName = "CommerceSample",
     Order = 100)]
    public class LoginPage : CommerceSampleModulePage
    {
    }
}