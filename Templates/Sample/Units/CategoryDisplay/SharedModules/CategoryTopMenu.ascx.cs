using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Sample.BaseControls;
using System;
using EPiServer.Core.Html;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.CategoryDisplay.SharedModules
{
    public partial class CategoryTopMenu: BaseCatalogListControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            CatalogNodes.DataSource = GetCatalogNodeList();
            CatalogNodes.DataBind();
            DataBind();
        }

        protected string GetDisplayName(NodeContent content)
        {
            if (content == null)
            {
                return string.Empty;
            }
                        
            return WebStringHelper.EncodeForWebString(content.DisplayName ?? content.Name);
        }
    }
}