using System;
using EPiServer.Commerce.Sample.Helpers;
using Mediachase.Commerce;
using Mediachase.Commerce.Core;
using Mediachase.Commerce.Orders;
using Mediachase.Commerce.Orders.Managers;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.AccountManagement.OrderDetail
{
    public partial class ShippingMethodInfo : UserControlBase
    {
        public Currency BillingCurrency { get; set; }

        public Shipment Shipment { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Shipment != null)
            {
                ShippingMethod.Text = GetShippingMethodName();
            }
        }

        /// <summary>
        ///     Gets display name of shipping method
        /// </summary>
        /// <returns></returns>
        private string GetShippingMethodName()
        {
            var shippingMethodDto = ShippingManager.GetShippingMethod(Shipment.ShippingMethodId, true);
            if (shippingMethodDto != null && shippingMethodDto.ShippingMethod.Count > 0)
            {
                var shippingMethod = shippingMethodDto.ShippingMethod[0];

                Money currentPrice = new Money(Shipment.ShipmentTotal, BillingCurrency);

                return string.Format("{0} - {1}", shippingMethod.DisplayName, currentPrice.ToString());
            }
            return string.Empty;
        }
    }
}
