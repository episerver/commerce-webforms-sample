using System.Linq;
using EPiServer.ServiceLocation;
using Mediachase.Commerce;
using Mediachase.Commerce.Catalog.Objects;
using Mediachase.Commerce.Orders;
using Mediachase.Commerce.Shared;
using Mediachase.Commerce.Website.Helpers;
using Mediachase.Commerce.Website;
using System;
using Mediachase.Commerce.Core;
using Mediachase.Commerce.Inventory;

namespace EPiServer.Commerce.Sample.Helpers
{
    public class SampleStoreHelper
    {
        /// <summary>
        /// Allow Add to Cart ( check quantity availble when add to cart)
        /// </summary>
        /// <param name="cart"></param>
        /// <param name="entry"></param>
        /// <param name="fixedQuantity"></param>
        /// <param name="quantity"></param>
        /// <param name="warehouseCode"></param>
        /// <param name="errorMessage"></param>        
        public static bool AllowAddToCart(Cart cart, Entry entry, bool fixedQuantity, decimal quantity, string warehouseCode, out string errorMessage)
        {
            if (!fixedQuantity)
            {
                if (cart.OrderForms.Count > 0)
                {
                    var lineItem = cart.OrderForms[0].LineItems.Cast<LineItem>().SingleOrDefault(l => l.CatalogEntryId == entry.ID);
                    if (lineItem != null)
                    {
                        quantity += lineItem.Quantity;
                    }
                }
            }

            if (StoreHelper.GetSalePrice(entry, quantity) == null)
            {
                errorMessage = "No Price.";
                return false;
            }

            if (entry.WarehouseInventories == null)
            {
                errorMessage = "No Warehouse.";
                return false;
            }

            var warehouseInventoryList = entry.WarehouseInventories.WarehouseInventory.Where(i => i.WarehouseCode == warehouseCode);
            var warehouseInventory = warehouseInventoryList.FirstOrDefault();

            if (warehouseInventory == null)
            {
                errorMessage = "No Warehouse.";
                return false;
            }

            // Check Warehouse Inventory status
            if (warehouseInventory.InventoryStatus == InventoryTrackingStatus.Disabled ||
                warehouseInventory.InventoryStatus == InventoryTrackingStatus.Ignored)
            {
                errorMessage = "NoError";
                return true;
            }
            
            //If entry is not available, check for pre-order
            if (entry.StartDate > FrameworkContext.Current.CurrentDateTime)
            {
                if (warehouseInventory.AllowPreorder)
                {
                    if (warehouseInventory.PreorderAvailabilityDate > FrameworkContext.Current.CurrentDateTime)
                    {
                        errorMessage = "Preorder is unavailable.";
                        return false;
                    }
                    if (quantity > warehouseInventory.PreorderQuantity)
                    {
                        errorMessage = "Not enough for Pre-order quantity.";
                        return false;
                    }
                }
                else
                {
                    errorMessage = "Product is not yet available. Pre-order is not allowed.";
                    return false;
                }
            }
            else
            {
                if (warehouseInventory.InStockQuantity > 0 &&
                    warehouseInventory.InStockQuantity >=
                        warehouseInventory.ReservedQuantity + quantity)
                {
                    errorMessage = "NoError";
                    return true;
                }

                //Not enough quantity in stock, check for backorder
                if (!warehouseInventory.AllowBackorder)
                {
                    if (warehouseInventory.InStockQuantity < quantity ||
                        (warehouseInventory.InStockQuantity -
                            warehouseInventory.ReservedQuantity) < quantity)
                    {
                        errorMessage = "Out of stock.";
                        return false;
                    }
                    errorMessage = "Not enough quantity.";
                    return false;
                }

                if (warehouseInventory.BackorderAvailabilityDate > FrameworkContext.Current.CurrentDateTime)
                {
                    errorMessage = "Not enough quantity. Backorder is unavailable.";
                    return false;
                }
                if (quantity > warehouseInventory.InStockQuantity -
                    warehouseInventory.ReservedQuantity + warehouseInventory.BackorderQuantity)
                {
                    errorMessage = "Not enough for Backorder quantity.";
                    return false;
                }
            }
            errorMessage = "NoError";
            return true;
        }

        public static Money ConvertCurrency(Money money, Currency currency)
        {
            var retVal = !CurrencyFormatter.CanBeConverted(money.Currency, currency)
                ? money
                : CurrencyFormatter.ConvertCurrency(money, currency);

            return retVal;
        }

        /// <summary>
        /// Get the shipping cost.
        /// </summary>
        /// <param name="shippingMethod">The shipping method.</param>
        /// <param name="shipment">The shipment.</param>
        /// <returns>The shipping cost.</returns>
        public static Money GetShippingCost(Mediachase.Commerce.Orders.Dto.ShippingMethodDto.ShippingMethodRow shippingMethod, 
            Shipment shipment)
        {
            return GetShippingCost(shippingMethod, shipment, SiteContext.Current.Currency);
        }

        /// <summary>
        /// Get the shipping cost.
        /// </summary>
        /// <param name="shippingMethod">The shipping method.</param>
        /// <param name="shipment">The shipment.</param>
        /// <param name="currency">The currency.</param>
        /// <returns>The shipping cost.</returns>
        public static Money GetShippingCost(Mediachase.Commerce.Orders.Dto.ShippingMethodDto.ShippingMethodRow shippingMethod,
            Shipment shipment, Currency currency)
        {
            Money result = new Money(0, currency);
            var type = Type.GetType(shippingMethod.ShippingOptionRow.ClassName);
            if (type == null)
            {
                throw new TypeInitializationException(shippingMethod.ShippingOptionRow.ClassName, null);
            }

            var message = string.Empty;
            var provider = (IShippingGateway)Activator.CreateInstance(type, new MarketStorage().GetCurrentMarket());
            var shipmentRate = provider.GetRate(shippingMethod.ShippingMethodId, shipment, ref message);
            if (shipmentRate != null)
            {
                var shipmentRateMoney = shipmentRate.Money;
                if (!shipmentRateMoney.Currency.Equals(currency))
                {
                    //The shipment and the shipping method base price are in different currency, need to convert first
                    result = CurrencyFormatter.ConvertCurrency(shipmentRateMoney, currency);
                }
                else
                {
                    result = shipmentRateMoney;
                }
            }
            return result;
        }
    }
}
