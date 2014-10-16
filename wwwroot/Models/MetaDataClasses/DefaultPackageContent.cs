using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Catalog.DataAnnotations;

namespace EPiServer.Commerce.Sample.Models.MetaDataClasses
{
    // <summary>
    // DefaultPackageContent content type, map to Default_Package_Class metadata class
    // </summary>
    [CatalogContentType(GUID = "D48EC0AF-CD66-4A60-B37C-68D3B41874EE", MetaClassName = "Default_Package_Class",
        DisplayName = "Package", Description = "Displays a package, which is comparable to an individual SKU because Package item must be purchased as a whole.")]
    public class DefaultPackageContent : PackageContent
    {
   }
}