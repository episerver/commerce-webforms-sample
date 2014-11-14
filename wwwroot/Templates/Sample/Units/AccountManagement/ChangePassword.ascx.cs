using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using EPiServer.Security;
using Mediachase.Commerce.Customers;
using Mediachase.BusinessFoundation.Data;
using Mediachase.Commerce.Security;
using EPiServer.Commerce.Sample.BaseControls;
using EPiServer.Commerce.Catalog.ContentTypes;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.AccountManagement
{
	public partial class ChangePassword : RendererControlBase<CatalogContentBase>
	{

	    protected void Page_Load(object sender, EventArgs e)
		{

		}

        protected void savePassword_Click(object sender, EventArgs e)
        {
            if (!Membership.ValidateUser(PrincipalInfo.CurrentPrincipal.Identity.Name, CurrentPassword.Text))
            {
                passwordError.Text = "Old Password is not valid, please fix and try again";
                return;
            }

            try
            {
                Membership.GetUser(PrincipalInfo.CurrentPrincipal.Identity.Name).ChangePassword(CurrentPassword.Text, NewPassword.Text);
                PasswordSuccessful.Text = "Password changed successfully!";
                return;
            }
            catch (Exception ex)
            {
                passwordError.Text = ex.Message;
            }
        }

        protected void cancel_Click(object sender, EventArgs e)
        {
            Context.RedirectFast(GetUrl(Settings.AccountPage));
        }
	}
}