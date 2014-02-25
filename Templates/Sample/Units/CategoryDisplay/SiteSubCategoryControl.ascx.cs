using System;
using System.Collections;
using System.Collections.Specialized;
using EPiServer.Commerce.Sample.BaseControls;
using EPiServer.Commerce.Sample.Models.MetaDataClasses;
using EPiServer.Core;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.CategoryDisplay
{
    public partial class SiteSubCategoryControl : RendererControlBase<SiteSubCategoryContent>
    {
        protected virtual string ParentNodeName
        {
            get { return Locate.ContentLoader().Get<IContent>(CurrentData.ParentLink).Name; }
        }
    }
}