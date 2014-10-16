using System;
using EPiServer.Commerce.Sample.BaseControls;
using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Core.Html;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.Shopping
{
    public partial class CatalogNodeList : BaseCatalogListControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            CatalogNodes.DataSource = GetCatalogNodeList();
            CatalogNodes.DataBind();
        }

        protected string GetDisplayName(NodeContent content, bool toUpper)
        {
            if (content == null)
            {
                return string.Empty;
            }

            var displayName = content.DisplayName ?? content.Name;
            if (!toUpper)
            {
                return WebStringHelper.EncodeForWebString(displayName);
            }

            return WebStringHelper.EncodeForWebString(displayName.ToUpper());
        }
    }
}
