using System;
using System.Web.UI;
using Mediachase.Commerce.Website;
using System.Collections.Generic;
using EPiServer.Core.Html;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.CartCheckout.SharedModules
{
    public partial class ErrorModule : UserControl
    {
        readonly List<string> _messages = new List<string>();
        /// <summary>
        /// Initializes a new instance of the <see cref="ErrorModule"/> class.
        /// </summary>
        public ErrorModule()
        {
            ErrorManager.Instance.Error += (Instance_Error);
        }


        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);

            Visible = _messages != null && _messages.Count > 0;
        }

        /// <summary>
        /// Handles the Error event of the Instance control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.IO.ErrorEventArgs"/> instance containing the event data.</param>
        private void Instance_Error(object sender, ErrorEventArgs e)
        {
            _messages.Add(WebStringHelper.EncodeForWebString(e.Message));
            ErrorMessages.DataSource = _messages;
            ErrorMessages.DataBind();

            Visible = _messages != null && _messages.Count > 0;
        }
    }
}
