using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Sample.BaseControls;
using Mediachase.Commerce.Core;
using Mediachase.Commerce.Catalog;
using Mediachase.Commerce.Catalog.Managers;
using Mediachase.Commerce.Catalog.Objects;
using Mediachase.Commerce.Orders;
using Mediachase.Commerce.Website.Helpers;
using System;
using System.Linq;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.CategoryDisplay.SharedModules
{
    public partial class CommonPricingInfo : RendererControlBase<EntryContentBase>
    {
        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs" /> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindPrice();
            }
        }
        
        /// <summary>
        /// Set current entry.
        /// </summary>
        /// <param name="entry"></param>
        public void SetEntry(Entry entry)
        {
            Entry = entry;
        }

        private void BindPrice()
        {
            if (Entry != null)
            {
                var basePrice = StoreHelper.GetSalePrice(Entry, 1);

                if (basePrice != null)
                {
                    //set pricing fields
                    ListPrice.Text = basePrice.ToPriceString();

                    var discountPrice = StoreHelper.GetDiscountPrice(Entry);
                    if (discountPrice != null)
                    {
                        DiscountPricing.Text = discountPrice.ToPriceString();

                        var discountPriceNum = discountPrice.Money;
                        if (discountPriceNum.Amount == -1)
                        {
                            discountPriceNum = basePrice.Money;
                        }
                        var saved = basePrice.Money.Subtract(discountPriceNum);
                        DiscountAmount.Text = saved.ToString();
                    }
                }
            }
        }
    }
}
