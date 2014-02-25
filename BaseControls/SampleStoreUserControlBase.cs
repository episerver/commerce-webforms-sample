using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using EPiServer.Commerce.Sample.Helpers;
using Mediachase.Commerce;
using Mediachase.Commerce.Core;
using Mediachase.Commerce.Orders;
using Mediachase.Commerce.Orders.Managers;
using Mediachase.Commerce.Website.Helpers;

namespace EPiServer.Commerce.Sample.BaseControls
{
    public class SampleStoreUserControlBase : UserControlBase
    {
        /// <summary>
        /// Calculates the shipping discounts and sets the discount message for the sample store user controls.
        /// </summary>
        /// <param name="shipmentCollection"></param>
        /// <param name="currency"></param>
        /// <param name="shippingDiscountMessage"></param>
        /// <returns></returns>
        internal Money CalculateShippingDiscounts(ShipmentCollection shipmentCollection, Currency currency, out string shippingDiscountMessage)
        {
            return CalculateShippingDiscounts(shipmentCollection.Cast<Shipment>(), currency, out shippingDiscountMessage);
        }

        internal Money CalculateShippingDiscounts(Shipment shipment, Currency currency, out string shippingDiscountMessage)
        {
            return CalculateShippingDiscounts(new List<Shipment>(1) { shipment }, currency, out shippingDiscountMessage);
        }

        private Money CalculateShippingDiscounts(IEnumerable<Shipment> shipments, Currency currency, out string shippingDiscountMessage)
        {
            var retVal = new Money(0, currency);
            System.Text.StringBuilder shippingDiscountsMessage = new System.Text.StringBuilder();
            foreach (Shipment shipment in shipments)
            {
                Money shipmentDiscount = new Money(0, currency);
                foreach (ShipmentDiscount discount in shipment.Discounts)
                {
                    shipmentDiscount += new Money(discount.DiscountValue, currency);
                    shippingDiscountsMessage.Append(String.Format("<strong>{0}</strong><br />", discount.DisplayMessage));
                }

                retVal += shipmentDiscount;
            }

            shippingDiscountMessage = shippingDiscountsMessage.ToString();
            return retVal;
        }

        /// <summary>
        /// Sums the shipping COSTS of a Cart without the discounts applied.
        /// </summary>
        /// <param name="shipments"></param>
        /// <returns></returns>
        internal Money CalculateShippingCostSubTotal(ShipmentCollection shipments, CartHelper cartHelper)
        {
            return CalculateShippingCostSubTotal(shipments.Cast<Shipment>(), cartHelper);
        }

        internal Money CalculateShippingCostSubTotal(Shipment shipment, CartHelper cartHelper)
        {
            return CalculateShippingCostSubTotal(new List<Shipment>(1) { shipment }, cartHelper);
        }

        private Money CalculateShippingCostSubTotal(IEnumerable<Shipment> shipments, CartHelper cartHelper)
        {
            var retVal = new Money(0, cartHelper.Cart.BillingCurrency);
            foreach (Shipment shipment in shipments)
            {
                if (cartHelper.FindAddressByName(shipment.ShippingAddressId) == null)
                    continue;

                var methods = ShippingManager.GetShippingMethods(CurrentPage.LanguageID);

                var shippingMethod = methods.ShippingMethod.FirstOrDefault(c => c.ShippingMethodId.Equals(shipment.ShippingMethodId));
                if (shippingMethod == null)
                    continue;

                var shipmentRateMoney = SampleStoreHelper.GetShippingCost(shippingMethod, shipment, cartHelper.Cart.BillingCurrency);
                retVal += shipmentRateMoney;
            }

            return retVal;
        }
    }
}