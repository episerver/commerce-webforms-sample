using System;
using System.Linq;
using EPiServer.Commerce.Catalog;
using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Core;
using EPiServer.ServiceLocation;
using Mediachase.Commerce.Catalog;
using Mediachase.Commerce.Catalog.Objects;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.ProductDetail.SharedModules.ProductImages
{
    public partial class CommonProductImages : System.Web.UI.UserControl
    {
        public Injected<AssetUrlResolver> AssetUrlResolver { get; set; }
        public Injected<ReferenceConverter> ReferenceConverter { get; set; }
        public Injected<IContentLoader> ContentLoader { get; set; }
        public Injected<AssetUrlConventions> AssetUrlConventions { get; set; }

        #region Private Variables
        #endregion      

        #region Properties

        public Entry Entry { get; set; }
        /// <summary>
        /// Gets or sets the filter action.
        /// </summary>
        /// <value>The filter action.</value>
        public Func<Entry, bool> FilterAction { get; set; }

        #endregion

        #region "Page Events"

        protected override void OnLoad(System.EventArgs e)
        {
            base.OnLoad(e);
            if (!IsPostBack)
            {
                DataBind();
            }
        }

        public override void DataBind()
        {
            base.DataBind();
            Image1.ImageUrl = GetImageUrl();           
        }

        private string GetImageUrl()
        {
            if (FilterAction != null)
            {
                Entry entrySKU = Entry.Entries.Entry.FirstOrDefault(FilterAction);
                if (entrySKU != null)
                {
                    return GetAssetUrl(entrySKU);
                }
                return string.Empty;
            }
            return GetAssetUrl(Entry);
        }

        private string GetAssetUrl(Entry entry)
        {
            var contentReference = ReferenceConverter.Service.GetContentLink(entry.CatalogEntryId, CatalogContentType.CatalogEntry, 0);
            return GetAssetUrl(contentReference);
        }

        private string GetAssetUrl(ContentReference contentLink)
        {
            var catalogContent = ContentLoader.Service.Get<CatalogContentBase>(contentLink);
            var assetContent = catalogContent as IAssetContainer;
            if (assetContent == null)
            {
                return AssetUrlConventions.Service.DefaultAssetUrl;
            }

            return AssetUrlResolver.Service.GetAssetUrl(assetContent);
        }

        #endregion

        #region "User Interaction Events"

        #endregion

        #region Helper Methods

        #endregion
    }
}