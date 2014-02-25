using EPiServer.Commerce.Sample.Helpers;
using Mediachase.Commerce;
using Mediachase.Commerce.Orders;
using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.AccountManagement.OrderDetail
{
    public partial class LineItemsSimpleInfo : UserControlBase
    {
        /// <summary>
        /// Gets or sets the order lineitems.
        /// </summary>
        /// <value>The order lineitems.</value>
        public List<LineItem> OrderLineItems { get; set; }

        public Currency BillingCurrency { get; set; }
        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            OrderShipment.ItemDataBound += (OrderShipment_ItemDataBound);
            OrderShipment.DataSource = OrderLineItems;
            DataBind();
        }

        /// <summary>
        /// Handles the OrderShipment_ItemDataBound event of the lvCartItems control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.WebControls.RepeaterItemEventArgs"/> instance containing the event data.</param>
        protected void OrderShipment_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.DataItem == null)
                return;

                var dataItem = ((LineItem)e.Item.DataItem);
                var lit = e.Item.FindControl("Discount") as Literal;

                if (lit != null)
                {
                    var discountAmount = (dataItem.LineItemDiscountAmount + dataItem.OrderLevelDiscountAmount) / dataItem.Quantity;
                    lit.Text = new Money(discountAmount, BillingCurrency).ToString();
                }

                lit = e.Item.FindControl("Quantity") as Literal;
                if (lit != null)
                {
                    lit.Text = string.Format("{0:0}", dataItem.Quantity);
                }
                lit = e.Item.FindControl("ListPrice") as Literal;
                if (lit != null)
                {
                    lit.Text = new Money(dataItem.ListPrice, BillingCurrency).ToString();
                }
                lit = e.Item.FindControl("YourPrice") as Literal;
                if (lit != null)
                {
                    var yourPrice = (dataItem.ExtendedPrice + dataItem.OrderLevelDiscountAmount) / dataItem.Quantity;
                    lit.Text = new Money(yourPrice, BillingCurrency).ToString();
                }
                lit = e.Item.FindControl("Total") as Literal;
                if (lit != null)
                {
                    lit.Text = new Money(dataItem.ExtendedPrice, BillingCurrency).ToString();
                }

                lit = e.Item.FindControl("WarehouseName") as Literal;
                var warehouse = WarehouseHelper.GetWarehouse(dataItem.WarehouseCode);
                if (lit != null && warehouse != null)
                    lit.Text = warehouse.Name;
            
        }
    }
}