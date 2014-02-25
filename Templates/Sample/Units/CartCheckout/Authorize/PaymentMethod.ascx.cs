using System;
using System.Globalization;
using System.Web.UI;
using System.Web.UI.WebControls;
using EPiServer.Framework.Localization;
using Mediachase.Commerce.Orders;
using Mediachase.Commerce.Website;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.CartCheckout.SharedModules
{
    public partial class PayByCreditCard : UserControl, IPaymentOption
	{
		#region Properties
		/// <summary>
		/// Gets a value indicating whether this instance is valid.
		/// </summary>
		/// <value><c>true</c> if this instance is valid; otherwise, <c>false</c>.</value>
		public bool IsValid
		{
			get { return !String.IsNullOrEmpty(CreditCardNumber.Text) && !String.IsNullOrEmpty(SecurityCode.Text) && !creditCardMonth.SelectedValue.Equals("0"); }
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
			if (!IsPostBack)
			{
				for (var i = 0; i < 8; i++)
					creditCardYear.Items.Add(new ListItem((DateTime.Now.Year + i).ToString(), (DateTime.Now.Year + i).ToString()));
			}
        }
		#endregion

		/// <summary>
		/// Gets the credit card payment.
		/// </summary>
		/// <returns></returns>
		public Payment GetCreditCardPayment()
        {
            if (string.IsNullOrEmpty(CreditCardNumber.Text))
                return null;

		    var payment = new CreditCardPayment()
		    {
		        CreditCardNumber = CreditCardNumber.Text,
                CreditCardSecurityCode = SecurityCode.Text
		    };

            int dateValue;
            if (int.TryParse(creditCardMonth.SelectedValue, out dateValue))
                payment.ExpirationMonth = dateValue;
            if (int.TryParse(creditCardYear.SelectedValue, out dateValue))
                payment.ExpirationYear = dateValue;

            return payment;
		}

        /// <summary>
        /// Validates input data for the control. In case of Credit card pre authentication will be the best way to
        /// validate. The error message if any should be displayed within a control itself.
        /// </summary>
        /// <returns>Returns false if validation is failed.</returns>
        public bool ValidateData()
        {
            this.Page.Validate(this.ID);
            return this.Page.IsValid;
        }

        /// <summary>
        /// This method is called before the order is completed. This method should check all the parameters
        /// and validate the credit card or other parameters accepted.
        /// </summary>
        /// <param name="orderForm"></param>
        /// <returns>bool</returns>
        public Payment PreProcess(OrderForm orderForm)
        {
            var payment = GetCreditCardPayment();
            if (!ValidateData() || payment == null)
            {
                // Intend to throw exception to stop processing unnecessary later steps (the sample site catch this exception to handle)
                throw new ArgumentException("Invalid credit card information.");
            }

            if (orderForm == null)
            {
                throw new ArgumentNullException("orderForm");
            }

            payment.BillingAddressId = orderForm.BillingAddressId;
            return payment;
        }

        /// <summary>
        /// This method is called after the order is placed. This method should be used by the gateways that want to
        /// redirect customer to their site.
        /// </summary>
        /// <param name="form">The form.</param>
        /// <returns></returns>
        public bool PostProcess(OrderForm form)
        {
            return true;
        }
	}
}