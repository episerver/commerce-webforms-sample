using System.ComponentModel.DataAnnotations;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.DataAnnotations;

namespace EPiServer.Commerce.Sample.Templates.Sample.PageTypes
{
    [ContentType(GUID = "3B579852-D4AD-41D5-B4BA-40FF4CC55A6B",
        DisplayName = "Not Supported Market Page",
        Description = "",
        GroupName = "CommerceSample",
        Order = 100)]
    public class MarketNotSupportedPage : CommerceSamplePage
    {
       
    }
}