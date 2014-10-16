using System.ComponentModel.DataAnnotations;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.DataAnnotations;

namespace EPiServer.Commerce.Sample.Templates.Sample.PageTypes
{
    [ContentType(GUID = "3DC355CD-DD03-49B0-9F4D-A0DFF04DCB3A",
        DisplayName = "Single Shipment Checkout Page",
        GroupName = "CommerceSample",
        Order = 100,
        Description = "The page which shows single shipment checkout.")]
    public class SingleShipmentCheckoutPage : CommerceSampleModulePage
    {
        [Searchable(false)]
        [Display(
            Name = "MultiShipmentPage",
            Description = "The page that displays button Multi shipment checkout.",
            GroupName = SystemTabNames.Content,
            Order = 40)]
        public virtual PageReference MultiShipmentCheckout { get; set; }
    }
}