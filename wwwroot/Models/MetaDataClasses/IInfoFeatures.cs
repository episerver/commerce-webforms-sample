using EPiServer.Core;

namespace EPiServer.Commerce.Sample.Models.MetaDataClasses
{
    /// <summary>
    /// Implements Info_Features on a content type
    /// </summary>
    public interface IInfoFeatures
    {
        /// <summary>
        /// The info model numer.
        /// </summary>
        XhtmlString Info_Features { get; set; }
    }
}
