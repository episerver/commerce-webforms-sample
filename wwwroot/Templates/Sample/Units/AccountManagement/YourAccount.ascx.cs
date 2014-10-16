using System;
using System.Collections.Generic;
using Mediachase.Commerce.Customers;
using Mediachase.Commerce.Orders;
using Mediachase.Commerce.Security;
using Mediachase.Commerce.Orders.Search;
using EPiServer.Commerce.Sample.BaseControls;
using EPiServer.Commerce.Catalog.ContentTypes;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.AccountManagement
{
    public partial class YourAccount : RendererControlBase<CatalogContentBase>
	{
	    protected void Page_Load(object sender, EventArgs e)
		{
            if (!IsPostBack)
            {
                GetOrderInformation();
				BindAddresses();
            }
		}

        /// <summary>
        /// Gets the order information
        /// </summary>
        protected void GetOrderInformation()
        {
            //Populate number of order            
            var purchaseOrders = PurchaseOrder.LoadByCustomer(SecurityContext.Current.CurrentUserId);          
            litNumberofOrders.Text = purchaseOrders.Count.ToString();

            //Populate most recent order
            var order = OrderContext.Current.GetMostRecentPurchaseOrder(SecurityContext.Current.CurrentUserId);
            litLastOrderDate.Text = order != null ? order.Created.ToString() : "";
        }

        private void BindAddresses()
        {
            var contact = CustomerContext.Current.CurrentContact;
            if (contact != null)
            {
                if (contact.PreferredShippingAddress != null && contact.PreferredShippingAddressId.HasValue)
                {
                    var shippingAddresses = new List<CustomerAddress>() { contact.PreferredShippingAddress };
                    shippingAddress.DataSource = shippingAddresses;
                    shippingAddress.DataBind();
                }
                else
                {
                    shippingAddress.DataSource = new List<CustomerAddress>();
                    shippingAddress.DataBind();
                }

                if (contact.PreferredBillingAddress != null && contact.PreferredBillingAddressId.HasValue)
                {
                    var billingAddresses = new List<CustomerAddress>() { contact.PreferredBillingAddress };
                    billingAddress.DataSource = billingAddresses;
                    billingAddress.DataBind();
                }
                else
                {
                    billingAddress.DataSource = new List<CustomerAddress>();
                    billingAddress.DataBind();
                }
            }
            else
            {
                billingAddress.DataSource = new List<CustomerAddress>();
                billingAddress.DataBind();
            }

        }
	}
}