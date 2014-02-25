using Mediachase.Commerce.Orders;
using System;
using System.Linq;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.AccountManagement.OrderDetail
{
    public partial class PaymentInfo : UserControlBase
    {
        public PaymentCollection PaymentInfos { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            // Display only one transaction type of Payments, show the concise information.
            rptPayments.DataSource = PaymentInfos.ToArray().GroupBy(p => p.PaymentMethodName).Select(grp => grp.First());
            rptPayments.DataBind();
        }

        protected string Header
        {
            get
            {
                if (PaymentInfos == null)
                {
                    return "No Payment Information";
                }
                return "Method(s): ";
            }   
        }
    }
}