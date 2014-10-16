using System;
using System.Linq;
using System.Collections.Generic;
using EPiServer.Commerce.Sample.Helpers;
using EPiServer.Core;
using EPiServer.Web;
using EPiServer.Web.Routing;
using Mediachase.Commerce.Catalog.Objects;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.ProductDetail.SharedModules.ProductImages
{
    public partial class CommonProductImages : System.Web.UI.UserControl
    {
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
                    return AssetHelper.GetAssetUrl(entrySKU);
                }
                return string.Empty;
            }
            return AssetHelper.GetAssetUrl(Entry);
        }

        #endregion

        #region "User Interaction Events"

        #endregion

        #region Helper Methods

        #endregion
    }
}