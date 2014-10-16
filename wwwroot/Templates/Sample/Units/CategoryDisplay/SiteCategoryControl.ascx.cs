using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using EPiServer.Commerce.Sample.BaseControls;
using EPiServer.Commerce.Sample.Models.MetaDataClasses;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.CategoryDisplay
{
    public partial class SiteCategoryControl : RendererControlBase<SiteCategoryContent>
    {
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);

            NodeListID.DataBind();
        }
    }
}