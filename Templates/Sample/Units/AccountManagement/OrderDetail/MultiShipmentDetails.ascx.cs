using Mediachase.Commerce.Customers;
using Mediachase.Commerce.Orders;
using System;
using System.Linq;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.AccountManagement.OrderDetail
{
    public partial class MultiShipmentDetails : UserControlBase
    {
        public const string OrderAddressValuePrefix = "OA";
        public const string CustomerAddressValuePrefix = "CA";

        public Shipment SplitShipment { get; set; }

        private int _orderGroupId;

        private PurchaseOrder _orderDetail;

        protected void Page_Load(object sender, EventArgs e)
        {
            _orderGroupId = !string.IsNullOrEmpty(Request.QueryString["po"])
                ? Int32.Parse(Request.QueryString["po"])
                : 0;

            _orderDetail = OrderContext.Current.GetPurchaseOrderById(_orderGroupId);

            if (!IsPostBack)
            {
                // Get and set Line Items
                LineItemsSimpleInfoID.OrderLineItems = Shipment.GetShipmentLineItems(SplitShipment);
                LineItemsSimpleInfoID.BillingCurrency = _orderDetail.BillingCurrency;

                // Get the Shipping method and Shipping Cost
                ShippingMethodInfoID.Shipment = SplitShipment;
                ShippingMethodInfoID.BillingCurrency = _orderDetail.BillingCurrency;

                // Get and set Shipping Address
                var address = _orderDetail.OrderAddresses.ToArray().FirstOrDefault(a => a.Name.Equals(SplitShipment.ShippingAddressId));

                address = address ?? _orderDetail.OrderAddresses.ToArray().FirstOrDefault(a => (OrderAddressValuePrefix + a.OrderGroupAddressId.ToString()).Equals(SplitShipment.ShippingAddressId));

                if (address == null)
                {
                    var contact = CustomerContext.Current.GetContactById(Mediachase.Commerce.Security.SecurityContext.Current.CurrentUserId);
                    var customerAddresses = CustomerContext.Current.GetAllContactAddresses(contact).ToList();
                    foreach (var customerAddress in customerAddresses)
                        {
                            // check ID
                        if (SplitShipment.ShippingAddressId.Equals(CustomerAddressValuePrefix + customerAddress.AddressId))
                            {
                                address = ConvertToOrderAddress(customerAddress);
                                break;
                            }
                            // check Name
                            if (SplitShipment.ShippingAddressId.Equals(customerAddress.Name))
                            {
                                address = ConvertToOrderAddress(customerAddress);
                                break;
                            }
                        }

                }

                if (address != null)
                {
                    ShipAddressInfo.OrderAddress = address;
                }

                // Get and set Sub Total, Shipping & Tax Estimated Shipping Costs
                OrderSubtotalID.SplitShipment = this.SplitShipment;
                OrderSubtotalID.BillingCurrency = _orderDetail.BillingCurrency;
            }
        }

        /// <summary>
        /// Converts to order address.
        /// </summary>
        /// <param name="address">The address.</param>
        /// <returns></returns>
        private static OrderAddress ConvertToOrderAddress(AddressEntity address)
        {
            return new OrderAddress(address);
        }
    }
}
