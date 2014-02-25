using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.DataAnnotations;

namespace EPiServer.Commerce.Sample.Templates.Sample.PageTypes
{
    [ContentType(GUID = "B4A6B3AE-15BE-4644-B211-DE48F6BAED78",
     DisplayName = "Account Page",
     Description = "The page which displays the current account information.",
     GroupName = "CommerceSample",
     Order = 100)]
    public class AccountPage : CommerceSampleModulePage
    {
    }
}