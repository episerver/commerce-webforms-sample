using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using EPiServer.Commerce.Sample.BaseControls;
using EPiServer.Commerce.Catalog.ContentTypes;

namespace EPiServer.Commerce.Sample.Templates.Sample.MasterPages.Controls
{
    public partial class LoginSelector : RendererControlBase<EntryContentBase>
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void logout_ButtonClick(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Context.RedirectFast("/");
        }
        
        protected string GetLoginUrl()
        {
            return GetUrl(Settings.LoginPage);
        }
    }
}