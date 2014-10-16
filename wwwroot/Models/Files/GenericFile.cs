using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using EPiServer.Core;
using EPiServer.DataAnnotations;

namespace EPiServer.Commerce.Sample.Models.Files
{
    [ContentType(GUID = "427BB926-1038-4B42-A9F9-790D2D504D48")]
    public class GenericFile : MediaData
    {
        /// <summary>
        /// Gets or sets the description.
        /// </summary>
        public virtual String Description { get; set; }
    }
}