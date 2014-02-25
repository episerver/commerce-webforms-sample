using EPiServer.Commerce.Sample.BaseControls;
using EPiServer.Commerce.Sample.Models.MetaDataClasses;
using System;
using System.Linq;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.ProductDetail.Clothing
{
    public partial class ClothingProductDisplayTemplate : RendererControlBase<FashionProductContent>
    {
        #region "Page Events"
        /// <summary>
        /// Raises the <see cref="System.Web.UI.Control.Load"/> event.
        /// </summary>
        /// <param name="e">The <see cref="T:System.EventArgs"/> object that contains the event data.</param>
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);

            ProductCommonModule.Entry = Entry;

            ProductItemSelectorID.UpdateFilterAction = UpdateFilterAction;
        }

        /// <summary>
        /// Updates product image, based on <paramref name="filterAction"/>.
        /// Product has image, but its variations have images too. When viewing a variation, this method will be invoked, to set variation image.
        /// </summary>
        /// <param name="filterAction">A filter action, to find a selected variation.</param>
        public void UpdateFilterAction(Func<FashionItemContent, bool> filterAction)
        {
            if (filterAction == null)
            {
                return;
            }

            var fashionItem = GetVariants<FashionItemContent>().FirstOrDefault(filterAction);
            if (fashionItem == null)
            {
                return;
            }

            var newInnerProperty = ProductImage.InnerProperty.CreateWritableClone();
            newInnerProperty.LoadData(fashionItem.CommerceMediaCollection);

            ProductImage.InnerProperty = newInnerProperty;
        }

        #endregion
    }
}