using System;
using System.Linq;
using EPiServer.Security;
using Mediachase.Commerce.Orders;
using Mediachase.Commerce.Security;
using Mediachase.Commerce.Website;
using EPiServer.Business.Commerce;
using Extensions = EPiServer.Commerce.Extensions;
using EPiServer.Commerce.Sample.BaseControls;
using EPiServer.Commerce.Catalog.ContentTypes;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.AccountManagement
{
    public partial class YourOrders : RendererControlBase<CatalogContentBase>
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData();
            }
        }

        /// <summary>
        /// Binds the Data Order.
        /// </summary>
        private void BindData()
        {
            if (PrincipalInfo.CurrentPrincipal.Identity.IsAuthenticated)
            {
                var orders = OrderContext.Current.GetPurchaseOrders(PrincipalInfo.CurrentPrincipal.GetContactId())
                           .Where(p => p.Created > DateTime.UtcNow.AddDays(-1 * int.Parse(ddlAvailableOrders.SelectedValue))).ToArray();

                foreach (var order in orders)
                {
                    order.Created = CommonHelper.GetUserDateTime(order.Created);
                }
                Array.Reverse(orders);

                if (orders.Any())
                {
                    noOrderMsg.Visible = false;
                    rptOrderList.Visible = true;
                    rptOrderList.DataSource = orders;
                    rptOrderList.DataBind();
                }
                else
                {
                    noOrderMsg.Visible = true;
                    rptOrderList.Visible = false;
                }
            }
        }

        /// <summary>
        /// Gets the full name of the billing address.
        /// </summary>
        /// <param name="po">The purchase order.</param>
        /// <returns></returns>
        protected string GetBillingAddressFullNameHtmlEncoded(PurchaseOrder po)
        {
            if (po == null || po.OrderForms.Count == 0)
            {
                return "- not set -";
            }
            var billingAddress = po.OrderAddresses.ToArray().FirstOrDefault(a => a.Name.Equals(po.OrderForms[0].BillingAddressId));
            if (billingAddress == null || string.IsNullOrWhiteSpace(billingAddress.FirstName))
            {
                return "- not set -";
            }

            return string.Format("{0} {1}", 
                Extensions.StringExtensions.ToHtmlEncoded(billingAddress.FirstName), 
                Extensions.StringExtensions.ToHtmlEncoded(billingAddress.LastName));
        }

        /// <summary>
        /// Handles the event of drop down list order change.
        /// </summary>
        protected void ddlAvailableOrders_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindData();
        }
    }

}