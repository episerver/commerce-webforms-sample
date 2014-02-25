using Mediachase.Commerce.Customers;
using Mediachase.Commerce.Orders;
using System;
using System.Web.Security;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.CartCheckout.SharedModules
{
    public partial class CartAddressView : UserControlBase
    {
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
        /// Gets or sets ShipmentId.
        /// </summary>
        /// <value>IsBillingAddress.</value>
        public string ShipmentId { get; set; }

        /// <summary>
        /// Gets or sets Billing Address or Shipping Address.
        /// </summary>
        /// <value>IsBillingAddress.</value>
        private bool _isBillingAddress = true;
        public bool IsBillingAddress
        {
            get { return _isBillingAddress; }
            set { _isBillingAddress = value; }
        }

        /// <summary>
        /// Allow add new address or not.
        /// </summary>
        /// <value>AllowAddNewAddress.</value>
        private bool _allowAddNewAddress = true;
        public bool AllowAddNewAddress
        {
            get { return _allowAddNewAddress; }
            set { _allowAddNewAddress = value; }
        }

        /// <summary>
        /// Allow use store address or not.
        /// </summary>
        /// <value>UseWarehouseAddress.</value>
        private bool _useWarehouseAddress;
        public bool UseWarehouseAddress
        {
            get { return _useWarehouseAddress; }
            set { _useWarehouseAddress = value; }
        }

        /// <summary>
        /// Allow use address book or not.
        /// </summary>
        /// <value>AllowSaveAddressBook.</value>
        public bool AllowSaveAddressBook
        {
            get { return CustomerContext.Current.CurrentContact != null; }
        }

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            DataBind();
        }

        public override void DataBind()
        {
            if (OrderAddress != null)
            {
                litAddress.Text = OrderAddress.ToAddressLiteral();
            }
        }
    }
}