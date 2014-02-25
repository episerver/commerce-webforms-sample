using System;
using System.Data;
using System.Linq;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using EPiServer.Commerce.Sample.Helpers;
using Mediachase.Commerce;
using Mediachase.Commerce.Core;
using Mediachase.Commerce.Marketing;
using Mediachase.Commerce.Orders;
using Mediachase.Commerce.Orders.Managers;
using Mediachase.Commerce.Website.Controls;
using Mediachase.Commerce.Website.Helpers;
using Mediachase.Commerce.Customers;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.CartCheckout.SharedModules
{
    public partial class SplitShipmentControl : UserControlBase
    {
        private readonly CartHelper _cartHelper = new CartHelper(Cart.DefaultName);

        public Shipment SplitShipment { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            //Bind ShipmentId to button on AddressView control
            ShippingAddressInfo.ShipmentId = SplitShipment.ShipmentId.ToString();

            if (!string.IsNullOrEmpty(SplitShipment.ShippingAddressId))
            {
                // If Shipping method is hand off method -> Use Store to pickup
                var address = _cartHelper.FindAddressByName(SplitShipment.ShippingAddressId);
                if (address != null)
                {
                    ShippingAddressInfo.OrderAddress = address;
                    ShippingAddressInfo.DataBind();

                    if (ShippingManager.AddressIsHandoffLocation(address))
                    {
                        ShippingAddressInfo.UseWarehouseAddress = true;
                        var litMessage = shippingOptions.Controls[0].FindControl("litMessage") as Literal;
                        if (litMessage != null)
                        {
                            litMessage.Text = ShippingManager.PickupShippingMethodName;
                        }
                    }
                    else
                    {
                        SetShippingMethod(BindShippingMethods());
                    }
                }
            }
            else
            {
                SetShippingMethod(BindShippingMethods());
            }

            //Lineitem data
            LineItemsID.ShipmentLineItems = Shipment.GetShipmentLineItems(this.SplitShipment);
            LineItemsID.BindData();

            //Subtotal each line item
            OrderSubtotalID.SplitShipment = SplitShipment;
            OrderSubtotalID.DataBind();
        }

        /// <summary>
        /// Sets the shipping address
        /// </summary>
        /// <param name="address"> Shipping address </param>
        public void SetShippingAddresses(OrderAddress address)
        {
            ShippingAddressInfo.OrderAddress = address;
            ShippingAddressInfo.DataBind();
        }

        /// <summary>
        /// Onchange the Shipping.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
        protected void ChooseShipping_Onchange(object sender, EventArgs e)
        {
            ChangeShippingMethod();

            //redirect after post
            Context.RedirectFast(Request.RawUrl + "#ShippingRegion");
        }

        /// <summary>
        /// Change shipping method
        /// </summary>
        protected void ChangeShippingMethod()
        {
            var shippingMethodId = string.Empty;
            foreach (var item in shippingOptions.Items)
            {
                var rdo = item.FindControl("rdoChooseShipping") as GlobalRadioButton;
                if (rdo == null)
                    continue;
                if (!rdo.Checked)
                    continue;

                var hidden = item.FindControl("hiddenShippingId") as HtmlInputControl;
                if (hidden == null)
                    continue;

                shippingMethodId = hidden.Value;
                break;

            }

            var ship = _cartHelper.Cart.OrderForms[0].Shipments.ToArray().FirstOrDefault(s => s.Id == SplitShipment.Id);

            var dto = ShippingManager.GetShippingMethod(new Guid(shippingMethodId));
            if (dto != null || dto.ShippingMethod != null || dto.ShippingMethod.Count > 0)
            {
                ship.ShippingMethodId = dto.ShippingMethod[0].ShippingMethodId;
                ship.ShippingMethodName = dto.ShippingMethod[0].Name;
            }

            // restore coupon code to context
            string couponCode = Session[Constants.LastCouponCode] as string;
            if (!String.IsNullOrEmpty(couponCode))
            {
                MarketingContext.Current.AddCouponToMarketingContext(couponCode);
            }

            //Calculate shipping, discounts, totals, etc
            OrderGroupWorkflowManager.RunWorkflow(_cartHelper.Cart, OrderGroupWorkflowManager.CartPrepareWorkflowName);
            _cartHelper.Cart.AcceptChanges();
        }

        /// <summary>
        /// Binds the shipping methods.
        /// </summary>
        private string BindShippingMethods()
        {
            var defaultShippingMethodId = String.Empty;
            var dtShippingMethods = new DataTable();
            dtShippingMethods.Columns.Add(new DataColumn("ShippingName"));
            dtShippingMethods.Columns.Add(new DataColumn("Description"));
            dtShippingMethods.Columns.Add(new DataColumn("ShippingMethodId"));

            var shippingMethods = ShippingManager.GetShippingMethods(SiteContext.Current.LanguageName);

            if (shippingMethods == null || shippingMethods.ShippingMethod == null ||
                shippingMethods.ShippingMethod.Count == 0)
                return String.Empty;

            foreach (var shippingMethod in shippingMethods.ShippingMethod.OrderBy(c => c.Ordering))
            {
                string shippingMethodName;
                if (shippingMethod.BasePrice == 0m)
                {
                    shippingMethodName = string.Format("{0} - Free", shippingMethod.DisplayName);
                }
                {
                    Money currentPrice = SampleStoreHelper.ConvertCurrency(new Money(shippingMethod.BasePrice, shippingMethod.Currency), SiteContext.Current.Currency);
                    if (!string.IsNullOrEmpty(SplitShipment.ShippingAddressId))
                    {
                       currentPrice = SampleStoreHelper.GetShippingCost(shippingMethod, SplitShipment);
                    }
                    shippingMethodName = string.Format("{0} - {1}", shippingMethod.DisplayName, currentPrice.ToString());
                }
                dtShippingMethods.Rows.Add(shippingMethodName, shippingMethod.IsDescriptionNull() ? string.Empty : shippingMethod.Description, shippingMethod.ShippingMethodId);
                if (shippingMethod.IsDefault)
                {
                    defaultShippingMethodId = shippingMethod.ShippingMethodId.ToString();
                }
            }

            shippingOptions.DataSource = dtShippingMethods;
            shippingOptions.DataBind();

            return defaultShippingMethodId;
        }

        /// <summary>
        /// Sets the Shipping Method.
        /// </summary>
        /// <param name="defaultShippingMethodId">Default shipping method Id</param>
        private void SetShippingMethod(string defaultShippingMethodId)
        {
            var shippingMethodId = SplitShipment.ShippingMethodId.ToString();

            var shippingMethod = !string.IsNullOrEmpty(shippingMethodId) && !shippingMethodId.Equals(Guid.Empty.ToString())
                                                                ? shippingMethodId : defaultShippingMethodId;

            if (string.IsNullOrEmpty(shippingMethod))
                return;

            foreach (var item in shippingOptions.Items)
            {
                var rdo = item.FindControl("rdoChooseShipping") as GlobalRadioButton;
                var hidden = item.FindControl("hiddenShippingId") as HtmlInputControl;
                if (rdo == null || hidden == null)
                    continue;

                if (hidden.Value == shippingMethod)
                {
                    rdo.Checked = true;
                    if (!shippingMethod.Equals(shippingMethodId))
                    {
                        ChangeShippingMethod();
                    }
                    break;
                }
            }

        }
    }
}
