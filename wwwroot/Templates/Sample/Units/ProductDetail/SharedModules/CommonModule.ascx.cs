using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Mediachase.Commerce.Catalog.Objects;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.ProductDetail.SharedModules
{
    public partial class CommonModule : UserControlBase
    {
        public Entry Entry { get; set; }

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            DataBind();
        }
    }
}