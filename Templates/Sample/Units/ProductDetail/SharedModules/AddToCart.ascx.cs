using System;
using System.Linq;
using EPiServer.Commerce.Sample.BaseControls;
using EPiServer.Commerce.Sample.Helpers;
using Mediachase.Commerce;
using Mediachase.Commerce.Catalog.Managers;
using Mediachase.Commerce.Orders;
using Mediachase.Commerce.Pricing;
using Mediachase.Commerce.Website.Helpers;
using EPiServer.Commerce.Catalog.ContentTypes;
using System.Web.UI.WebControls;
using System.Web.UI;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.ProductDetail.SharedModules
{
    public partial class AddToCart : RendererControlBase<EntryContentBase>
    {
        private VariationContent _variationContent;
        private MarketId _marketId;

        /// <summary>
        /// Gets or sets the filter action.
        /// </summary>
        /// <value>The filter action.</value>
        public Func<VariationContent, bool> FilterAction { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            _marketId = CurrentMarket.GetCurrentMarket().MarketId;
            //Store the LastCatalogPageUrl to allow "continue shopping" redirect
            Session[Constants.LastCatalogPageUrl] = Request.Url.ToString();
        }

        protected VariationContent VariationContent
        {
            get
            {
                if (_variationContent == null && CurrentData != null)
                {
                    _variationContent = CurrentData as VariationContent;
                    if (_variationContent == null)
                    {
                        _variationContent = GetVariants<VariationContent>().FirstOrDefault(FilterAction);
                    }
                }

                return _variationContent;
            }
        }

        /// <summary>
        /// Locate a control by searching through a hierarchy of naming containers
        /// </summary>
        /// <param name="rootControl">The root control</param>
        /// <param name="controlID">ID of the control to locate</param>
        /// <returns></returns>
        private Control FindControlRecursive(Control rootControl, string controlID)
        {
            if (rootControl.ID == controlID) return rootControl;

            foreach (Control controlToSearch in rootControl.Controls)
            {
                Control controlToReturn =
                    FindControlRecursive(controlToSearch, controlID);
                if (controlToReturn != null) return controlToReturn;
            }
            return null;
        }

        /// <summary>
        /// Handles the Click event of the PurchaseLink control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.ImageClickEventArgs"/> instance containing the event data.</param>
        protected void BuyButton_Click(object sender, EventArgs e)
        {
            CartHelper ch = new CartHelper(Cart.DefaultName);
            CartHelper wishList = new CartHelper(CartHelper.WishListName);

            if (VariationContent != null)
            {
                //get quantity when use AddToCart into Repeater (case: Relate Product)
                var linkButtonControl = (sender as System.Web.UI.Control);
                var addToCartControl = linkButtonControl.Parent;
                var txtQuantityControl = addToCartControl.FindControl("txtQuantity");

                var entry = VariationContent.LoadEntry(CatalogEntryResponseGroup.ResponseGroup.CatalogEntryInfo | CatalogEntryResponseGroup.ResponseGroup.Inventory);
                var warehouseField = FindControlRecursive(this.Parent, "hidWarehouseCode") as HiddenField;
                var warehouseCode = String.Empty;
                if (warehouseField != null && !string.IsNullOrEmpty(warehouseField.Value))
                {
                    warehouseCode = warehouseField.Value;
                }

                decimal quantity = decimal.Parse(System.Web.HttpContext.Current.Request.Form[txtQuantityControl.UniqueID].ToString());
                string errorMessage;
                if (!SampleStoreHelper.AllowAddToCart(
                    ch.Cart, 
                    entry, 
                    false, 
                    quantity, 
                    String.IsNullOrEmpty(warehouseCode) ? Constants.DefaultWarehouseCode : warehouseCode, 
                    out errorMessage))
                {
                    ErrorMessage.Text = errorMessage;
                    divErrorMsg.Style.Add("display", "block");
                    //We will do a postback here, reset the warehouse code to empty
                    if (warehouseField != null)
                    {
                        warehouseField.Value = string.Empty;
                    }
                    return;
                }

                if (entry.IsAvailableInMarket(_marketId))
                {
                    ch.AddEntry(entry, quantity, false, warehouseCode, new CartHelper[] { wishList });
                    Response.Redirect(GetUrl(Settings.CartPage));
                }
            }
        }

        /// <summary>
        /// Handles the Click event of the WishListLink control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="System.Web.UI.ImageClickEventArgs"/> instance containing the event data.</param>
        protected void WishListButton_Click(object sender, EventArgs e)
        {
            CartHelper ch = new CartHelper(Cart.DefaultName);
            CartHelper wishList = new CartHelper(CartHelper.WishListName);

            if (VariationContent != null)
            {

                if (VariationContent.GetPrices(_marketId, CustomerPricing.AllCustomers).Count > 0)
                {
                    var entry = VariationContent.LoadEntry();
                    var warehouseField = FindControlRecursive(this.Parent, "hidWarehouseCode") as HiddenField;
                    var warehouseCode = Constants.DefaultWarehouseCode;
                    if (warehouseField != null && !string.IsNullOrEmpty(warehouseField.Value))
                    {
                        warehouseCode = warehouseField.Value;
                    }
                    wishList.AddEntry(entry, 1, true, warehouseCode, new[] { ch });
                    Response.Redirect(GetUrl(Settings.WishListPage));
                }
                else
                {
                    ErrorMessage.Text = "No Price.";
                    divErrorMsg.Style.Add("display", "block");
                }
            }
        }
    }
}