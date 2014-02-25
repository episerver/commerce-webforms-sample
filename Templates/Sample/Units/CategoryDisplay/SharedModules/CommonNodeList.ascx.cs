using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Sample.BaseControls;
using EPiServer.Filters;
using System;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.CategoryDisplay.SharedModules
{
    public partial class CommonNodeList : RendererControlBase<CatalogContentBase>
    {
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            if (CurrentData == null)
            {
                return;
            }
            rptCategoryList.DataSource = GetNodeChildren<NodeContent>(CurrentData.ContentLink);
            DataBind();
        }
    }
}