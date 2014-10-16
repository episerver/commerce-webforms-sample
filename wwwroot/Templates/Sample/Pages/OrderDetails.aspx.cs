using System.Globalization;
using EPiServer.Commerce.Sample.Templates.Sample.PageTypes;
using EPiServer.Commerce.Sample.Templates.Sample.Units.AccountManagement;
using Mediachase.Commerce.Orders;
using Mediachase.Commerce.Security;
using System;

namespace EPiServer.Commerce.Sample.Templates.Sample.Pages
{
    public partial class OrderDetails : AuthorizedPageBase<OrderDetailsPage>
    {
        private PurchaseOrder _orderDetail;

        private int _orderGroupId;

        protected new void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);

            _orderGroupId = string.IsNullOrEmpty(Request.QueryString["po"])
                ? _orderGroupId = 0
                : _orderGroupId = Int32.Parse(Request.QueryString["po"].ToString(CultureInfo.InvariantCulture));

            _orderDetail = OrderContext.Current.GetPurchaseOrder(SecurityContext.Current.CurrentContactId, _orderGroupId);

            if (_orderDetail == null)
                return;

            if (_orderDetail.OrderForms[0].Shipments.Count > 1)
            {
                var control = (OrderDetailsMultiShipment)LoadControl("~/Templates/Sample/Units/AccountManagement/OrderDetailsMultiShipment.ascx");
                control.OrderDetail = _orderDetail;
                modulePlaceHolder.Controls.Add(control);
            }
            else
            {
                var control = (OrderDetailsSingleShipment)LoadControl("~/Templates/Sample/Units/AccountManagement/OrderDetailsSingleShipment.ascx");
                control.OrderDetail = _orderDetail;
                modulePlaceHolder.Controls.Add(control);
            }

        }
    }
}