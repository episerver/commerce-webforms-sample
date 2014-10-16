using Mediachase.Commerce.Orders;
using System;
using System.Collections.Generic;
using System.Linq;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.AccountManagement.OrderDetail
{
    public partial class CouponsInfo : UserControlBase
    {
        /// <summary>
        /// The PurchaseOrder
        /// </summary>
        public PurchaseOrder OrderDetail; 

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs" /> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            BindDiscountListView();
        }
       
        /// <summary>
        /// Binds the discount list view.
        /// </summary>
        private void BindDiscountListView()
        {
            var discounts = new List<Discount>();
            if (OrderDetail != null)
            {
                foreach (OrderForm form in OrderDetail.OrderForms)
                {
                    discounts.AddRange(form.Discounts.Cast<Discount>().ToArray().Where(x => !String.IsNullOrEmpty(x.DiscountCode)));

                    foreach (LineItem item in form.LineItems)
                    {
                        discounts.AddRange(item.Discounts.Cast<Discount>().ToArray().Where(x => !String.IsNullOrEmpty(x.DiscountCode)));
                    }

                    foreach (Shipment shipment in form.Shipments)
                    {
                        discounts.AddRange(shipment.Discounts.Cast<Discount>().ToArray().Where(x => !String.IsNullOrEmpty(x.DiscountCode)));
                    }
                }
            }

            lvDiscount.DataSource = discounts;
            lvDiscount.DataBind();
        }
    }
}