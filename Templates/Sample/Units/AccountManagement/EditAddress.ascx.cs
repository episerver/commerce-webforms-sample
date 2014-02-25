using System;
using System.Linq;
using Mediachase.Commerce.Orders.Dto;
using Mediachase.Commerce.Orders.Managers;
using Mediachase.Commerce.Customers;
using System.Data;
using Mediachase.BusinessFoundation.Data.Business;
using Mediachase.Commerce.Core;
using EPiServer.Commerce.Sample.BaseControls;
using EPiServer.Commerce.Catalog.ContentTypes;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.AccountManagement
{
    public partial class EditAddress : RendererControlBase<CatalogContentBase>
    {
        #region Fields
        private readonly CountryDto _countries = CountryManager.GetCountries();

        private string _addressId;
        #endregion

        #region Properties
        /// <summary>
        /// Gets the countries.
        /// </summary>
        /// <value>The countries.</value>
        public CountryDto Countries
        {
            get
            {
                return _countries;
            }
        }
        #endregion

        #region Event Handlers
        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            _addressId = !string.IsNullOrEmpty(Request.QueryString["AddressId"])
                ? _addressId = Request.QueryString["AddressId"]
                : _addressId = "0";

            if (!IsPostBack)
            {
                BindCountries();
                BindRegions();
                if (!String.IsNullOrEmpty(Request.QueryString["AddressId"]))
                    BindForm();
            }
        }

        /// <summary>
        /// Handles the Click event of the save control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void save_Click(object sender, EventArgs e)
        {
            var contact = CustomerContext.Current.CurrentContact;
            if (contact == null)
                return;

            var address = contact.ContactAddresses.FirstOrDefault(x => x.AddressId.ToString().ToLower().Equals(_addressId.ToLower()));

            var isNew = false;
            if (address == null)
            {
                address = CustomerAddress.CreateForApplication(AppContext.Current.ApplicationId);
                address.ContactId = contact.PrimaryKeyId;
                isNew = true;
            }

            address.Name = addressName.Text;
            address.Line1 = address1.Text;
            address.Line2 = address2.Text;
            address.City = city.Text;
            address.CountryCode = country.SelectedValue;
            address.CountryName = country.SelectedItem.ToString();

            if (state.Visible)
            {
                address.State = state.SelectedValue;
                address.RegionName = state.SelectedValue;
            }
            else
            {
                address.RegionName = region.Text;
            }

            address.PostalCode = zipcode.Text;
            address.OrganizationName = companyName.Text;
            address.DaytimePhoneNumber = phoneNumber.Text;
            address.Email = emailAddress.Text;
            address.FirstName = firstName.Text;
            address.LastName = lastName.Text;

            if (isNew)
                address.PrimaryKeyId = BusinessManager.Create(address);
            else
                BusinessManager.Update(address);

            if (defaultBilling.Checked)
                contact.PreferredBillingAddressId = address.PrimaryKeyId;
            else if (!defaultBilling.Checked && contact.PreferredBillingAddressId == address.PrimaryKeyId)
                contact.PreferredBillingAddressId = null;

            if (defaultShipping.Checked)
                contact.PreferredShippingAddressId = address.PrimaryKeyId;
            else if (!defaultShipping.Checked && contact.PreferredShippingAddressId == address.PrimaryKeyId)
                contact.PreferredShippingAddressId = null;

            contact.SaveChanges();
            Context.RedirectFast(GetUrl(Settings.AddressesPage));
        }

        /// <summary>
        /// Handles the Click event of the cancel control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void cancel_Click(object sender, EventArgs e)
        {
            Context.RedirectFast(GetUrl(Settings.AddressesPage));
        }

        /// <summary>
        /// Handles the SelectedIndexChanged event of the country control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void country_SelectedIndexChanged(object sender, System.EventArgs e)
        {
            BindRegions();
        }
        #endregion

        #region Helper Methods
        /// <summary>
        /// Binds the countries.
        /// </summary>
        public void BindCountries()
        {
            if (Countries == null)
                return;

            country.DataSource = Countries.Country;
            country.DataBind();
            country.SelectedValue = "USA";
        }

        /// <summary>
        /// Binds the regions.
        /// </summary>
        private void BindRegions()
        {
            state.Items.Clear();
            if (Countries == null)
                return;

            var countryRow = Countries.Country.AsEnumerable().FirstOrDefault(x => x.Code == country.SelectedValue);
            if (countryRow == null)
                return;

            DataRow[] regionRows = countryRow.GetStateProvinceRows();

            if (regionRows.Length > 0)
            {
                state.DataSource = regionRows;
                state.DataBind();

                state.Visible = true;
                region.Visible = false;
            }
            else
            {
                state.Visible = false;
                region.Visible = true;
            }

        }

        /// <summary>
        /// Binds the form.
        /// </summary>
        private void BindForm()
        {
            var address = CustomerContext.Current.CurrentContact.ContactAddresses.FirstOrDefault(x => x.AddressId.ToString().ToLower().Equals(_addressId.ToLower()));
            if (address == null)
                return;

            country.SelectedValue = address.CountryCode;
            BindRegions();

            addressName.Text = address.Name;
            address1.Text = address.Line1;
            address2.Text = address.Line2;
            city.Text = address.City;
            state.SelectedValue = address.State;
            region.Text = address.RegionName;
            zipcode.Text = address.PostalCode;
            companyName.Text = address.OrganizationName;
            phoneNumber.Text = address.DaytimePhoneNumber;
            emailAddress.Text = address.Email;
            firstName.Text = address.FirstName;
            lastName.Text = address.LastName;

            defaultBilling.Checked = CustomerContext.Current.CurrentContact.PreferredBillingAddressId.HasValue &&
                CustomerContext.Current.CurrentContact.PreferredBillingAddressId.Value == address.PrimaryKeyId.Value;

            defaultShipping.Checked = CustomerContext.Current.CurrentContact.PreferredShippingAddressId.HasValue &&
                CustomerContext.Current.CurrentContact.PreferredShippingAddressId.Value == address.PrimaryKeyId.Value;

        }
        #endregion
    }
}