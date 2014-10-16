﻿using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Catalog.DataAnnotations;
using EPiServer.DataAnnotations;
using System;

namespace EPiServer.Commerce.Sample.Models.MetaDataClasses
{
    [CatalogContentType(GUID = "30C0884E-55BD-429B-A763-760385832113", MetaClassName = "MediaStoreLandingNode", GroupName = "Media",
        DisplayName = "Media store", Description = "Display media store.")]
    [AvailableContentTypes(Include = new Type[] { typeof(MediaProductContent), typeof(MediaItemContent), typeof(NodeContent), typeof(BundleContent), typeof(PackageContent) })]
    [ImageUrl("~/Templates/UX/gfx/page-type-thumbnail-media-node.png")]
    public class MediaStoreLandingNodeContent : SiteCategoryContent
    {
    }
}