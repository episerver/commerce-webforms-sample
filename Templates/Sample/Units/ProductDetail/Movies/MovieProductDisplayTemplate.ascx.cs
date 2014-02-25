using EPiServer.Commerce.Sample.BaseControls;
using EPiServer.Commerce.Sample.Models.MetaDataClasses;
using System;
using System.Linq;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.ProductDetail.Movies
{
    public partial class MovieProductDisplayTemplate : RendererControlBase<MediaProductContent>
    {
        /// <summary>
        /// Raises the <see cref="E:System.Web.UI.Control.Load"/> event.
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
        public void UpdateFilterAction(Func<MediaItemContent, bool> filterAction)
        {
            if (filterAction == null)
            {
                return;
            }

            var variant = GetVariants<MediaItemContent>().FirstOrDefault(filterAction);
            if (variant == null)
            {
                return;
            }

            var newInnerProperty = ProductImage.InnerProperty.CreateWritableClone();
            newInnerProperty.LoadData(variant.CommerceMediaCollection);

            ProductImage.InnerProperty = newInnerProperty;
        }
    }
}