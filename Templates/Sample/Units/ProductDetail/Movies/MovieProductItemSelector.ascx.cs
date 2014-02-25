using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Sample.BaseControls;
using EPiServer.Commerce.Sample.Models.MetaDataClasses;
using System;
using System.Linq;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.ProductDetail.Movies
{
    public partial class MovieProductItemSelector : RendererControlBase<ProductContent>
    {
        #region Private Variables

        #endregion

        #region Properties  
        
        /// <summary>
        /// Update filter action for other controls
        /// </summary>
        public Action<Func<MediaItemContent, bool>> UpdateFilterAction { get; set; }
        
        #endregion

        #region "Page Events"

        /// <summary>
        /// 
        /// </summary>
        /// <param name="e"></param>
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            if (!IsPostBack)
            {
                BindMediaTypes();
            }            

            BindItem();
        }

        #endregion

        #region Helper Methods

        /// <summary>
        /// Binds Item.
        /// </summary>
        private void BindItem()
        {
            Func<VariationContent, bool> filterAction = x =>
                {
                    var mediaItemContent = x as MediaItemContent;
                    if (mediaItemContent == null)
                    {
                        return false;
                    }

                    return mediaItemContent.Facet_MediaType == mediatypes.SelectedValue;
                };

            AddToCart.FilterAction = filterAction;

            ProductPromotions.FilterAction = filterAction;
            ProductPromotions.DataBind();

            ProductPriceDetails.FilterAction = filterAction;
            ProductPriceDetails.DataBind();

            ProductWarehouseInfo.FilterAction = filterAction;
            ProductWarehouseInfo.DataBind();
        }
        /// <summary>
        /// Binds the sizes.
        /// </summary>

        /// <summary>
        /// Binds the Media TYpes.
        /// </summary>
        private void BindMediaTypes()
        {
            var childVariationContent = GetVariants<MediaItemContent>()
                .Where(x => !String.IsNullOrEmpty(x.Facet_MediaType))
                .GroupBy(x => x.Facet_MediaType)
                .Select(x => x.Key).ToList();

            mediatypes.DataSource = childVariationContent;
            mediatypes.DataBind();
        }      

        #endregion

        protected void attribute_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindItem();
        }   
    }
}