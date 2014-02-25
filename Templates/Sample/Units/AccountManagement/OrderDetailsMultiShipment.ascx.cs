using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Sample.BaseControls;
using Mediachase.Commerce.Orders;
using System;
using System.Linq;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.AccountManagement
{
    public partial class OrderDetailsMultiShipment : RendererControlBase<CatalogContentBase>
    {
        public PurchaseOrder OrderDetail {get; set;}

        protected void Page_Load(object sender, EventArgs e)
        {
            if (OrderDetail == null)
            {
                Context.RedirectFast(GetUrl(Settings.YourOrdersPage));
                return;
            }

            if (!IsPostBack)
            {
                //Set Billing and Shipping Address
                if (OrderDetail.OrderAddresses.Count > 1)
                {
                    BillAddressInfo.OrderAddress = OrderDetail.OrderAddresses.ToArray().FirstOrDefault(x => x.Name == FirstOrderForm.BillingAddressId);
                }
                else
                {
                    BillAddressInfo.OrderAddress = OrderDetail.OrderAddresses.ToArray().FirstOrDefault();
                }

                //Set Coupons
                CouponsInfoID.OrderDetail = OrderDetail;

                //Set Payment information
                PaymentInfoID.PaymentInfos = FirstOrderForm.Payments;

                //Set SubLine data
                OrderSubtotalSimpleInfoID.OrderDetail = OrderDetail;

                BindDataSplitShipment();
            }
        }

        /// <summary>
        /// Gets the order form collection
        /// </summary>
        protected OrderFormCollection OrderForms
        {
            get
            {
                if (OrderDetail != null)
                {
                    return OrderDetail.OrderForms;
                }
                return null;
            }
        }

        /// <summary>
        /// Gets the first order form
        /// </summary>
        protected OrderForm FirstOrderForm
        {
            get
            {
                if (OrderForms == null || OrderForms.Count == 0)
                {
                    return null;
                }
                return OrderForms[0];
            }
        }

        /// <summary>
        /// Default bind data method.
        /// </summary>
        private void BindDataSplitShipment()
        {
            lvSplitShipment.DataSource = OrderDetail.OrderForms[0].Shipments;
            lvSplitShipment.DataBind();
        }
    }
}