using EPiServer.Core;

namespace EPiServer.Commerce.Sample.Models.MetaDataClasses
{
    /// <summary>
    /// Implements Info_Description on a content type
    /// </summary>
    public interface IInfoDescription
    {
        /// <summary>
        /// The info model numer.
        /// </summary>
        XhtmlString Info_Description { get; set; }
    }
}
