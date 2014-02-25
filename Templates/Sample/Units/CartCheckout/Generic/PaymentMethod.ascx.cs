using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Mediachase.Commerce.Orders;
using Mediachase.Commerce.Website;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.CartCheckout.SharedModules
{
    public partial class PayByPhone : System.Web.UI.UserControl, IPaymentOption
	{
		public string GetErrorMessage()
		{
			return "Please fix your error please.";
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
        /// <param name="form"></param>
        /// <returns>bool</returns>
        public Payment PreProcess(OrderForm form)
        {
            OtherPayment otherPayment = new OtherPayment();
            otherPayment.BillingAddressId = form.BillingAddressId;
            return (Payment)otherPayment;
        }

        /// <summary>
        /// This method is called after the order is placed. This method should be used by the gateways that want to
        /// redirect customer to their site.
        /// </summary>
        /// <param name="orderForm">The form.</param>
        /// <returns></returns>
        public bool PostProcess(OrderForm orderForm)
        {
            return true;
        }
	}
}