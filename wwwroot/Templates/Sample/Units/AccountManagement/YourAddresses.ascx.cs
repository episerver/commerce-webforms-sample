using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Sample.BaseControls;
using Mediachase.Commerce.Customers;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.AccountManagement
{
    public partial class YourAddresses : RendererControlBase<CatalogContentBase>
    {
        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            addresses.ItemCommand += (addresses_ItemCommand);
            if (!IsPostBack)
            {
                BindAddresses();
            }
        }

        void addresses_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (!e.CommandName.Equals("deleteAddress"))
                return;
            
            var customer = CustomerContext.Current.CurrentContact;
            var address = customer.ContactAddresses.FirstOrDefault(x => x.AddressId.ToString().ToLower().Equals(e.CommandArgument));
            if (address == null)
                return;

            if (address.AddressId == customer.PreferredBillingAddressId)
                customer.PreferredBillingAddressId = null;
            if (address.AddressId == customer.PreferredShippingAddressId)
                customer.PreferredShippingAddressId = null;

            customer.SaveChanges();
            address.Delete();

            Context.RedirectFast(Request.RawUrl);
        }

        /// <summary>
        /// Binds the addresses.
        /// </summary>
        private void BindAddresses()
        {
            if (CustomerContext.Current.CurrentContact != null)
            {
                addresses.DataSource = CustomerContext.Current.CurrentContact.ContactAddresses;
                addresses.DataBind();
            }
            else
            {
                addresses.DataSource = new List<CustomerAddress>();
                addresses.DataBind();
            }

        }

        /// <summary>
        /// Gets the defaults.
        /// </summary>
        /// <param name="address">The address.</param>
        /// <returns></returns>
        protected string GetDefaults(CustomerAddress address)
        {
            var ret = "";
            var contact = CustomerContext.Current.CurrentContact;

            if (contact.PreferredBillingAddressId.HasValue && contact.PreferredBillingAddressId == address.AddressId)
                ret += "<strong>Default Billing</strong><br/>";

            if (contact.PreferredShippingAddressId.HasValue && contact.PreferredShippingAddressId == address.AddressId)
                ret += "<strong>Default Shipping</strong>";
            return ret;
        }
    }
}