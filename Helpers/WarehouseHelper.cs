using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Mediachase.Commerce.Inventory;
using Mediachase.Commerce.Orders;

namespace EPiServer.Commerce.Sample.Helpers
{
    public static class WarehouseHelper
    {
        /// <summary>
        /// Gets the warehouse by warehouse code.
        /// </summary>
        /// <param name="warehouseId">The warehouse id.</param>
        /// <returns></returns>
        public static IWarehouse GetWarehouse(int warehouseId)
        {
            return EPiServer.ServiceLocation.ServiceLocator.Current.GetInstance<IWarehouseRepository>().Get(warehouseId);
        }

        /// <summary>
        /// Gets the warehouse by warehouse code.
        /// </summary>
        /// <param name="warehouseCode">The warehouse code.</param>
        /// <returns></returns>
        public static IWarehouse GetWarehouse(string warehouseCode)
        {
            if (string.IsNullOrEmpty(warehouseCode))
            {
                return null;
            }

            return EPiServer.ServiceLocation.ServiceLocator.Current.GetInstance<IWarehouseRepository>().Get(warehouseCode);
        }
    }
}