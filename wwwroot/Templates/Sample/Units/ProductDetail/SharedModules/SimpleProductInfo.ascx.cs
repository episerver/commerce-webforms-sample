using System;
using System.Collections.Generic;
using System.Linq;
using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Catalog.Linking;
using EPiServer.Commerce.Sample.BaseControls;
using EPiServer.ServiceLocation;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.ProductDetail.SharedModules
{
    public partial class SimpleProductInfo : RendererControlBase<EntryContentBase>
	{
        public override void DataBind()
        {
            base.DataBind();

            PriceDetailsControl.FilterAction = (x => true);
            PriceDetailsControl.CurrentData = CurrentData;
            PriceDetailsControl.DataBind();

            AddToCartControl.FilterAction = (x => true);
            AddToCartControl.CurrentData = CurrentData;
            AddToCartControl.DataBind();
        }
	}
}
