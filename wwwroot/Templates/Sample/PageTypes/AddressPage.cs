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
    [ContentType(GUID = "B64C58FB-5057-4E31-9C09-2F023DF9F5A2",
     DisplayName = "Address Page",
     Description = "The page which shows current addresses.",
     GroupName = "CommerceSample",
     Order = 100)]
    public class AddressPage : CommerceSampleModulePage
    {
    }
}