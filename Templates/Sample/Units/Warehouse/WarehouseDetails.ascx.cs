using Mediachase.Commerce.Catalog;
using Mediachase.Commerce.Inventory;
using System;
using System.Collections.Generic;
using System.Linq;
using EPiServer.ServiceLocation;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.Warehouse
{
    public partial class WarehouseDetails : UserControlBase
    {
        #region private
        private readonly IWarehouseInventoryService _warehouseInventoryService = ServiceLocator.Current.GetInstance<IWarehouseInventoryService>();        
        #endregion

        public int PageSize = 15;
        public int PageIndex = 1;
        public Dictionary<int, int> SimplePagerSource;

        #region Properties
        public string WarehouseCode { get; set; }


        /// <summary>
        /// The warehouse inventories in warehouse
        /// </summary>
        public IEnumerable<IWarehouseInventory> WarehouseInventoryList
        {
            get
            {
                var warehouses = _warehouseInventoryService.List();
                return WarehouseCode == string.Empty
                    ? warehouses : warehouses.Where(w => w.WarehouseCode.Equals(WarehouseCode, StringComparison.OrdinalIgnoreCase));
            }
        }
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            var warehouseCodeQuery = Request.QueryString[Constants.WarehouseCodeQuery];
            WarehouseCode = string.IsNullOrEmpty(warehouseCodeQuery) ? string.Empty : warehouseCodeQuery.ToString();

            if (!IsPostBack)
            {
                DataBind();
            }
        }

        public override void DataBind()
        {
            base.DataBind();

            SimplePagerSource = new Dictionary<int, int>();
            var totalSize = WarehouseInventoryList.Count();
            if (totalSize > 0)
            {
                 var totalPage = (totalSize - 1) / PageSize + 1;

                for (var i = 1; i <= totalPage; i++)
                {
                    SimplePagerSource.Add(i, i);
                }
            }
            PagerID.DataSource = SimplePagerSource;
            PagerID.DataTextField = "Value";
            PagerID.DataValueField = "Key";
            PagerID.DataBind();

            BindWarehouseInventoryList();
        }


        /// <summary>
        /// Get number of warehouse inventory in current warehouseCode
        /// </summary>
        /// <returns></returns>
        public string GetInventoryList()
        {
            return String.Format("There are {0} warehouse inventories available in {1} warehouses", WarehouseInventoryList.Count().ToString(), WarehouseCode);
        }


        /// <summary>
        /// Handle event when pager dropdown list changes
        /// </summary>
        /// <param name="sender">The sender</param>
        /// <param name="e">The arguments</param>
        protected void Pager_OnSelectedIndexChanged(object sender, EventArgs e)
        {
            PageIndex = Convert.ToInt32(PagerID.SelectedValue);
            BindWarehouseInventoryList();
        }

        /// <summary>
        /// Bind warehouse inventory list following pageindex
        /// </summary>
        protected void BindWarehouseInventoryList()
        {
            rptWarehouseInventoryList.DataSource = WarehouseInventoryList.Skip((PageIndex - 1) * PageSize).Take(PageSize);
            rptWarehouseInventoryList.DataBind();
        }

        /// <summary>
        /// Get catalog entry name 
        /// </summary>
        /// <param name="catalogEntryCode">The catalog entry code</param>
        /// <returns></returns>
        protected string GetCatalogEntryName(string catalogEntryCode)
        {
            return CatalogContext.Current.GetCatalogEntryDto(catalogEntryCode).CatalogEntry[0].Name;
        }
    }
}