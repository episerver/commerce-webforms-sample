using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using Mediachase.Commerce.Customers;
using Mediachase.Commerce.Orders;
using Mediachase.Commerce.Security;
using Mediachase.Commerce.Website;
using Mediachase.Commerce.Website.BaseControls;
using Mediachase.Commerce.Website.Helpers;
using EPiServer.Commerce.Sample.BaseControls;
using EPiServer.Commerce.Catalog.ContentTypes;

namespace EPiServer.Commerce.Sample.Templates.Sample.MasterPages.Controls
{
    public partial class NavAccountBar : RendererControlBase<EntryContentBase>
	{
		#region Event Handlers
		/// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
			if (!IsPostBack)
			{
				DataBind();

			}
		}
		#endregion

		#region Helper Methods
        protected string GetAddressesUrl()
        {
            return GetUrl(Settings.AddressesPage);
        }
        protected string GetAccountInfoUrl()
        {
            return GetUrl(Settings.AccountPage);
        }
        protected string GetYourOrdersUrl()
        {
            return GetUrl(Settings.YourOrdersPage);
        }
        protected string GetWishListUrl()
        {
            return GetUrl(Settings.WishListPage);
        }
        protected string GetLoginUrl()
        {
            return GetUrl(Settings.LoginPage);
        }
		#endregion
	}
}