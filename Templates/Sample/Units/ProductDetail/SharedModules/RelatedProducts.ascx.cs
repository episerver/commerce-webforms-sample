using System;
using System.Collections.Generic;
using System.Linq;
using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Catalog.Linking;
using EPiServer.Commerce.Sample.BaseControls;
using EPiServer.ServiceLocation;
using Mediachase.Commerce;

namespace EPiServer.Commerce.Sample.Templates.Sample.Units.ProductDetail.SharedModules
{
    public partial class RelatedProducts : RendererControlBase<EntryContentBase>
	{
        private static Injected<ILinksRepository> LinkRepository { get; set; }

        public string GroupName { get; set; }

        public override void DataBind()
        {
            base.DataBind();

            RelatedProductsRepeater.DataSource = GetRelatedContent();
            RelatedProductsRepeater.DataBind();
        }

        protected IEnumerable<EntryContentBase> GetRelatedContent()
        {
            if (CurrentData == null)
            {
                return Enumerable.Empty<EntryContentBase>();
            }

            var allAssociations = LinkRepository.Service.GetAssociations(CurrentData.ContentLink);

            var relatedItems = allAssociations.Where(a => a.Group.Name == GroupName).Select(a => ContentLoader.Get<EntryContentBase>(a.Target));
            var currentMarket = CurrentMarket.GetCurrentMarket();
            return ForVisitor(() => relatedItems.Where(i => !i.MarketFilter.Contains(currentMarket.MarketId.Value)));
        }
	}
}
