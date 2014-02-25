using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Sample.BaseControls;
using EPiServer.Commerce.Sample.Models.MetaDataClasses;
using System;
using System.Collections.Generic;
using System.Linq;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.ProductDetail.Clothing
{
    public partial class ClothingProductItemSelector : RendererControlBase<FashionProductContent>
    {
        /// <summary>
        /// Update filter action for other controls
        /// </summary>
        public Action<Func<FashionItemContent, bool>> UpdateFilterAction { get; set; }

        /// <summary>
        /// Raises the <see cref="E:System.Web.UI.Control.Load"/> event.
        /// </summary>
        /// <param name="e">The <see cref="T:System.EventArgs"/> object that contains the event data.</param>
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            if (!IsPostBack)
            {
                var variants = GetVariants<FashionItemContent>().ToList();

                BindColors(variants);
                BindSizes(variants);
            }

            BindItem();
        }

        /// <summary>
        /// Binds Item.
        /// </summary>
        private void BindItem()
        {
            Func<VariationContent, bool> filterAction = x =>
                {
                    var fashionItemContent = x as FashionItemContent;
                    if (fashionItemContent == null)
                    {
                        return false;
                    }

                    return fashionItemContent.Facet_Size == sizes.SelectedValue && fashionItemContent.Facet_Color == colors.SelectedValue;
            };

            AddToCart.FilterAction = filterAction;

            ProductPromotions.FilterAction = filterAction;
            ProductPromotions.DataBind();

            ProductPriceDetails.FilterAction = filterAction;
            ProductPriceDetails.DataBind();

            ProductWarehouseInfo.FilterAction = filterAction;
            ProductWarehouseInfo.DataBind();

            UpdateFilterAction(filterAction);
        }

        /// <summary>
        /// Binds the sizes.
        /// </summary>
        private void BindSizes(IEnumerable<FashionItemContent> variants)
        {
            var bindValues = variants
                .Where(x => !String.IsNullOrEmpty(x.Facet_Size))
                .GroupBy(x => x.Facet_Size)
                .Select(x => x.Key);

            sizes.DataSource = bindValues;
            sizes.DataBind();
        }

        /// <summary>
        /// Binds the colors.
        /// </summary>
        private void BindColors(IEnumerable<FashionItemContent> variants)
        {
            var bindValues = variants
                .Where(x => !String.IsNullOrEmpty(x.Facet_Color))
                .GroupBy(x => x.Facet_Color)
                .Select(x => x.Key);

            colors.DataSource = bindValues;
            colors.DataBind();
        }

        protected void attribute_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindItem();
        }
    }
}