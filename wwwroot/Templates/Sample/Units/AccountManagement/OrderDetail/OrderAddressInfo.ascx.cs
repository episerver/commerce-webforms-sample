using Mediachase.Commerce.Orders;
using System;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.AccountManagement.OrderDetail
{
    public partial class OrderAddressInfo : UserControlBase
    {
        protected void Page_Load(object sender, EventArgs e)
        { }

        /// <summary>
        /// Gets or sets the order address.
        /// </summary>
        /// <value>The order address.</value>
        public OrderAddress OrderAddress
        {
            get; 
            set;
        }

        /// <summary>
        /// Gets the address name.
        /// </summary>
        /// <value>The name.</value>
        public string Name
        {
            get
            {
                return OrderAddress == null ? string.Empty : OrderAddress.FirstName + " " + OrderAddress.LastName;
            }
        }

        /// <summary>
        /// Gets the line1.
        /// </summary>
        /// <value>The line1.</value>
        public string Line
        {
            get { return OrderAddress == null ? string.Empty : OrderAddress.Line1; }
        }

        /// <summary>
        /// Gets the City.
        /// </summary>
        /// <value>The city.</value>
        public string City
        {
            get { return OrderAddress == null ? string.Empty : OrderAddress.City; }
        }

        /// <summary>
        /// Gets the PostalCode.
        /// </summary>
        /// <value>The postalcode.</value>
        public string PostalCode
        {
            get { return OrderAddress == null ? string.Empty : OrderAddress.PostalCode; }
        }

        /// <summary>
        /// Gets the country.
        /// </summary>
        /// <value>The country.</value>
        public string Country
        {
            get { return OrderAddress == null ? string.Empty : OrderAddress.CountryName; }
        }
    }
}