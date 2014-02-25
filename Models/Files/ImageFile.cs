using System;
using EPiServer.Commerce.SpecializedProperties;
using EPiServer.DataAnnotations;
using EPiServer.Framework.DataAnnotations;

namespace EPiServer.Commerce.Sample.Models.Files
{
    [ContentType(GUID = "872AA39E-5B79-43BF-B7D5-F34D415553BD")]
    [MediaDescriptor(ExtensionString = "jpg,jpeg,jpe,ico,gif,bmp,png")]
    public class ImageFile : CommerceImage
    {
        /// <summary>
        /// Gets or sets the description.
        /// </summary>
        public virtual String Description { get; set; }
    }
}
