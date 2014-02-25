using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Sample.BaseControls;
using EPiServer.Core;

namespace EPiServer.Commerce.Sample.Templates.Sample.Pages.ProductListing
{
    public partial class CatalogDetail : RendererBase<CatalogContent>
    {
        protected override void OnLoad(System.EventArgs e)
        {
            Context.RedirectFast(GetUrl(ContentReference.StartPage));
        }
    }
}