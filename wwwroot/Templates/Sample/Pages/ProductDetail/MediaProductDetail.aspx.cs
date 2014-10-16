using System.Web.UI;
using EPiServer.Commerce.Sample.BaseControls;
using EPiServer.Core;
using EPiServer.ServiceLocation;
using EPiServer.Web;
using EPiServer.Web.Routing;
using Mediachase.Commerce.Catalog;
using Mediachase.Commerce.Catalog.Managers;

using EPiServer.DataAnnotations;
using EPiServer.Commerce.Sample.Templates.Sample.PageTypes;
using System.Collections.Generic;
using EPiServer.Commerce.Sample.Models.MetaDataClasses;
using System.Collections;
using System.Collections.Specialized;

namespace EPiServer.Commerce.Sample.Templates.Sample.Pages.ProductDetail
{
    public partial class MediaProductDetail : RendererBase<MediaProductContent>
    {
    }
}