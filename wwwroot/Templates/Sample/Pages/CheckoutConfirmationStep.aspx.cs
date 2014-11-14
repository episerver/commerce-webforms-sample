using System;
using System.Globalization;
using System.Linq;
using System.Web.UI;
using EPiServer.Security;
using Mediachase.Commerce;
using Mediachase.Commerce.Orders;
using Mediachase.Commerce.Security;

namespace EPiServer.Commerce.Sample.Templates.Sample.Pages
{
    public partial class CheckoutConfirmationStep : TemplatePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var order = OrderContext.Current.GetPurchaseOrders(PrincipalInfo.CurrentPrincipal.GetContactId()).OrderBy(o => o.OrderGroupId).LastOrDefault();
            if (order == null)
                return;

            liPONumber.Text = order.TrackingNumber.ToString(CultureInfo.InvariantCulture);
            liTotal.Text = new Money(order.Total, order.BillingCurrency).ToString();
        }
    }
}