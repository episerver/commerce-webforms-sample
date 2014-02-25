using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Sample.BaseControls;
using EPiServer.Commerce.Sample.Helpers;
using EPiServer.Commerce.SpecializedProperties;
using Mediachase.Commerce.Inventory;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.ProductDetail.SharedModules
{
    public partial class ProductWarehouseInfo : RendererControlBase<EntryContentBase>
    {
        #region Properties
        private int _idCounter = 0;

        private IEnumerable<Inventory> _inventories;

        protected IEnumerable<Inventory> Inventories
        {
            get
            {
                if (_inventories == null)
                {
                    //make sure we don't get any null reference exception when accessing Inventories.
                    _inventories = Enumerable.Empty<Inventory>();
                    var variationContent = CurrentData as VariationContent;
                    if (variationContent == null)
                    {
                        variationContent = GetVariants<VariationContent>().FirstOrDefault(FilterAction);
                    }

                    if (variationContent != null && variationContent.IsAvailableInCurrentMarket())
                    {
                        _inventories = variationContent.GetStockPlacement();
                    }
                }

                return _inventories;
            }
        }

        /// <summary>
        /// Gets or sets the filter action.
        /// </summary>
        /// <value>The filter action.</value>
        public Func<VariationContent, bool> FilterAction { get; set; }

        #endregion

        #region Page Lifecycle Event Handlers

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            if (!IsPostBack)
            {

            }

            BindStoreInformation();
        }

        #endregion

        #region Event Handlers

        protected void rptWarehouseList_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem)
            {
                return;
            }

            var warehouseInventory = e.Item.DataItem as Inventory;
            if (warehouseInventory == null)
            {
                return;
            }

            var warehouse = WarehouseHelper.GetWarehouse(warehouseInventory.WarehouseCode);
            if (warehouse == null)
            {
                return;
            }

            SetWarehouseName(e, warehouse);
            SetWarehouseAddress(e, warehouse, warehouseInventory);
            SetPickUpButton(e, warehouse, warehouseInventory);
        }

        private static void SetPickUpButton(RepeaterItemEventArgs e, IWarehouse warehouse, Inventory warehouseInventory)
        {
            var pickupButton = e.Item.FindControl("PickUpButton") as HyperLink;
            if (pickupButton == null)
                return;

            if (warehouse.IsFulfillmentCenter || warehouse.IsPickupLocation || warehouse.IsDeliveryLocation)
            {
                if (warehouse.IsFulfillmentCenter || warehouse.IsPickupLocation)
                {
                    pickupButton.Text = "Pick";
                }
                else if (warehouse.IsDeliveryLocation)
                {
                    pickupButton.Text = "Delivery-only";
                }

                pickupButton.Attributes.Add("onclick",
                                            String.Format("SelectWarehouse('{0}','{1}','{2}');",
                                                          warehouseInventory.InStockQuantity,
                                                          warehouseInventory.WarehouseCode, warehouse.Name));
            }
            else
            {
                pickupButton.Text = "Not set";
                pickupButton.CssClass += " disabled";
            }
        }

        private static void SetWarehouseAddress(RepeaterItemEventArgs e, IWarehouse warehouse, Inventory warehouseInventory)
        {
            Literal lit;
            var link = e.Item.FindControl("WarehouseAddress") as HyperLink;
            if (link != null)
            {
                link.Text = HttpUtility.HtmlEncode(string.Format("{0} {1}", warehouse.ContactInformation.City,
                                                                 warehouse.ContactInformation.CountryName));
                link.NavigateUrl = string.Format("http://maps.google.com/maps?q={0} {1}",
                                                 warehouse.ContactInformation.City, warehouse.ContactInformation.CountryName);
            }

            lit = e.Item.FindControl("WarehouseIsAvailable") as Literal;
            if (lit != null)
            {
                lit.Text = (warehouseInventory.InStockQuantity - warehouseInventory.ReservedQuantity > 0)
                               ? "Available"
                               : "Not available";
            }
        }

        private static void SetWarehouseName(RepeaterItemEventArgs e, IWarehouse warehouse)
        {
            var lit = e.Item.FindControl("WarehouseName") as Literal;
            if (lit != null)
                lit.Text = HttpUtility.HtmlEncode(warehouse.Name);

            lit = e.Item.FindControl("WarehouseNamePickup") as Literal;
            if (lit != null)
                lit.Text = HttpUtility.HtmlEncode(warehouse.Name);

            lit = e.Item.FindControl("WarehouseContactInfo") as Literal;
            if (lit != null)
                lit.Text = HttpUtility.HtmlEncode(string.Format("{0} - {1}", warehouse.ContactInformation.FullName,
                                                                warehouse.ContactInformation.Email));
        }

        #endregion

        #region Helper Methods

        public override void DataBind()
        {
            base.DataBind();
            BindStoreInformation();
        }

        public void BindStoreInformation()
        {
            var inventories = new List<Inventory>();
            foreach (var inventory in Inventories)
            {
                var warehouse = WarehouseHelper.GetWarehouse(inventory.WarehouseCode);
                if (warehouse != null && warehouse.IsActive)
                {
                    inventories.Add(inventory);
                }
            }

            if (inventories.Any())
            {
                rptWarehouseList.DataSource = inventories;
                rptWarehouseList.DataBind();
            }
            else
            {
                Notification.Text = "No Warehouse Information";
            }
        }

        protected Inventory GetDefaultWarehouseInventory()
        {
            var warehouseInventory = Inventories.FirstOrDefault(inventory => inventory.WarehouseCode == Constants.DefaultWarehouseCode);
            if (warehouseInventory != null)
            {
                return warehouseInventory;
            }

            return new Inventory() { WarehouseCode = "N/A", InStockQuantity = 0 };
        }

        protected int GetIdCounter(bool increment) { if (increment) { _idCounter++; } return _idCounter; }

        #endregion

    }
}