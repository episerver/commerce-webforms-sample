using System.ComponentModel.DataAnnotations;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.DataAnnotations;

namespace EPiServer.Commerce.Sample.Templates.Sample.PageTypes
{
    [ContentType(GUID = "7618B049-452B-4444-B98E-48146303C111",
        DisplayName = "Multi Shipment Checkout Page",
        GroupName = "CommerceSample",
        Order = 100,
        Description = "The page which shows multi shipment checkout.")]
    public class MultiShipmentCheckoutPage : CommerceSampleModulePage
    {
        [Searchable(false)]
        [Display(
            Name = "SingleShipmentPage",
            Description = "The page that displays button Single shipment checkout.",
            GroupName = SystemTabNames.Content,
            Order = 40)]
        public virtual PageReference SingleShipmentCheckout { get; set; }
    }
}