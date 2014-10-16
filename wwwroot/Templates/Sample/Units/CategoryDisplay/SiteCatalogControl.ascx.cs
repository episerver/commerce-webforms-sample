using System;
using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Sample.BaseControls;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.CategoryDisplay
{
    public partial class SiteCatalogControl : RendererControlBase<CatalogContent>
    {

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            rptDepartments.DataSource = ContentLoader.GetChildren<NodeContent>(CurrentData.ContentLink);
            rptDepartments.DataBind();
        }
    }
}