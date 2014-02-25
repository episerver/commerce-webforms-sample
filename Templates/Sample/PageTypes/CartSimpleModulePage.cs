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
    [ContentType(GUID = "BAE8C7EE-AA11-4884-8ECC-325AB02B9E8E",
        DisplayName = "Cart Simple Module Page",
        GroupName = "CommerceSample",
        Order = 100,
        Description = "")]
    public class CartSimpleModulePage : CommerceSampleModulePage
    {
        
    }
}