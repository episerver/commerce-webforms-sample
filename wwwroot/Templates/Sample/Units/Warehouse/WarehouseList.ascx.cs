using System;
using System.Linq;
using Mediachase.Commerce.Catalog.Objects;
using EPiServer.Commerce.Sample.BaseControls;
using Mediachase.Commerce.Inventory;
using System.Web.UI.WebControls;
using EPiServer.ServiceLocation;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.Warehouse
{
    public partial class WarehouseList : UserControlBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var warehouseRepository = ServiceLocator.Current.GetInstance<IWarehouseRepository>();
            rptWarehouses.DataSource = warehouseRepository.List().Where(warehouse => warehouse.IsActive);
            rptWarehouses.DataBind();
        }
    }
}