﻿using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Catalog.DataAnnotations;

namespace EPiServer.Commerce.Sample.Models.MetaDataClasses
{
    // <summary>
    // DefaultBundleContent content type, map to Default_Bundle_Class metadata class
    // </summary>
   [CatalogContentType(GUID = "9728966C-B48A-4DE8-90A8-97A8EE66EC98", MetaClassName = "Default_Bundle_Class",
        DisplayName = "Bundle", Description = "Displays a bundle, collection of variations and SKUs allowing customers to purchase two or more items at once.")]
   public class DefaultBundleContent : BundleContent
   { 

   }
}