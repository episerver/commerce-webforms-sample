using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using Mediachase.Commerce.Orders;
using Mediachase.Commerce.Orders.Managers;
using Mediachase.Commerce.Website.Helpers;
using Mediachase.Commerce.Website;
using Mediachase.Commerce;
using EPiServer.ServiceLocation;
using System.Web.UI.HtmlControls;
using Mediachase.Commerce.Website.Controls;
using Mediachase.Commerce.Core;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.CartCheckout.SharedModules
{
    public partial class PaymentOptions : UserControlBase
    {
        private readonly CartHelper _cartHelper = new CartHelper(Cart.DefaultName);
        private readonly ICurrentMarket _currentMarketService = ServiceLocator.Current.GetInstance<ICurrentMarket>();
        private readonly Dictionary<PaymentMethod, string> _paymentDictionary = new Dictionary<PaymentMethod, string>();
        protected string ActiveControlId;

        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            //Get active payments, order by ordering (escending)
            var payments = PaymentManager.GetPaymentMethods(SiteContext.Current.LanguageName).PaymentMethod.AsQueryable().Where(c => c.IsActive);

            var paymentList = new List<PaymentMethod>();
            var defaultPayment = payments.OrderByDescending(c => c.Ordering).FirstOrDefault(c => c.IsDefault);
            if (defaultPayment == null)
            {
                defaultPayment = payments.OrderByDescending(c => c.Ordering).FirstOrDefault();
            }
            if (defaultPayment == null)
            {
                ErrorManager.GenerateError("No payment method available.");
                return;
            }
            foreach (var paymentRow in payments)
            {
                var paymentMethod = new PaymentMethod(paymentRow);
                var marketId = _currentMarketService.GetCurrentMarket().MarketId;
                if (!paymentMethod.MarketId.Contains(marketId))
                    continue;

                paymentList.Add(paymentMethod);
                string controlId;
                if (defaultPayment.PaymentMethodId == paymentMethod.PaymentMethodId)
                {
                    controlId = BindPaymentControls(paymentMethod, true);
                    ActiveControlId = controlId;
                }
                else
                {
                    controlId = BindPaymentControls(paymentMethod, false);
                }
                _paymentDictionary.Add(paymentMethod, controlId);
            }

            PaymentOptionList.DataSource = paymentList;
            PaymentOptionList.DataBind();
        }

        /// <summary>
        /// Places the order.
        /// </summary>
        public bool FullfilPayment()
        {
            // find selected payment gateway:
            IPaymentOption selectedPayment = null;
            Mediachase.Commerce.Orders.Dto.PaymentMethodDto.PaymentMethodRow paymentMethodRow = null;
            var payments = PaymentManager.GetPaymentMethods(SiteContext.Current.LanguageName);
            for (int i = 0; i < PaymentContent.Controls.Count; i++)
            {
                Control control = PaymentContent.Controls[i];

                var radioButton = control.Controls[0] as GlobalRadioButton;
                if (radioButton.Checked)
                {
                    selectedPayment = control.Controls[1] as IPaymentOption;
                    paymentMethodRow = payments.PaymentMethod[i];
                    break;
                }
            }

            if (selectedPayment == null)
            {
                ErrorManager.GenerateError("Fatal error, system administrator has been notified.");
                return false;
            }
            try
            {
                var payment = selectedPayment.PreProcess(_cartHelper.OrderForm);
                if (payment != null)
                {
                    payment.PaymentMethodId = paymentMethodRow.PaymentMethodId;
                    payment.PaymentMethodName = paymentMethodRow.Name;
                    payment.BillingAddressId = _cartHelper.OrderForm.BillingAddressId;
                    payment.Amount = _cartHelper.OrderForm.Total;
                    _cartHelper.Cart.OrderForms[0].Payments.Add(payment);
                    // Save changes

                    _cartHelper.Cart.AcceptChanges();
                    return true;
                }
            }
            catch (Exception ex)
            {
                ErrorManager.GenerateError(ex.Message);
                return false;
            }

            ErrorManager.GenerateError("Please choose a payment method.");
            return false;
        }

        public string BindPaymentControls(PaymentMethod paymentMethod, bool isDefault)
        {
            var radioButton = new GlobalRadioButton() { GroupName = "ChoosePayment" };
            radioButton.Text = string.Format("&nbsp;Use {0}", paymentMethod.Name.ToHtmlEncode());
            radioButton.Checked = isDefault;

            var control = LoadControl(string.Format("~/Templates/Sample/Units/CartCheckout/{0}/PaymentMethod.ascx", paymentMethod.SystemKeyword));
            HtmlGenericControl div = new HtmlGenericControl("div");
            div.Attributes.Add("class", isDefault ? "tab-pane active" : "tab-pane fade");
            div.Controls.Add(radioButton);
            div.Controls.Add(control);

            PaymentContent.Controls.Add(div);

            return div.ClientID.ToString();
        }

        public string GetControlIDFromPayment(object paymentMethodObj)
        {
            var paymentMethod = paymentMethodObj as PaymentMethod;
            return _paymentDictionary[paymentMethod].ToString();
        }
    }
}