using EPiServer.Commerce.Catalog;
using EPiServer.Commerce.Catalog.ContentTypes;
using EPiServer.Commerce.Catalog.Linking;
using EPiServer.Commerce.Routing;
using EPiServer.Commerce.Sample.Helpers;
using EPiServer.Framework;
using EPiServer.Framework.Initialization;
using EPiServer.ServiceLocation;
using Mediachase.Commerce;
using System.Web.Routing;

namespace EPiServer.Commerce.Sample.Business.Initialization
{
    [ModuleDependency(typeof(EPiServer.Commerce.Initialization.InitializationModule))]
    public class InitializationModule : IConfigurableModule
    {
        public void Initialize(InitializationEngine context)
        {
            MapRoutes(RouteTable.Routes);

            // Check the HostType is WebApplication
            if (context == null || context.HostType != HostType.WebApplication)
            {
                return;
            }

            AddAssociationGroups(context);
            SetDefaultGroups(context);
        }

        private static void MapRoutes(RouteCollection routes)
        {
            CatalogRouteHelper.MapDefaultHierarchialRouter(routes, false);
        }

        public void Preload(string[] parameters)
        {
        }

        public void Uninitialize(InitializationEngine context)
        {
        }

        public void ConfigureContainer(ServiceConfigurationContext context)
        {
            context.Container.Configure(c => c.For<ICurrentMarket>().Singleton().Use<MarketStorage>());
        }

        private void AddAssociationGroups(InitializationEngine context)
        {
            // Add predefined selections CrossSell and UpSell
            // If they already exist nothing will be added
            var associationDefinitionRepository =
                context.Locate.Advanced.GetInstance<GroupDefinitionRepository<AssociationGroupDefinition>>();
            associationDefinitionRepository.Add(new AssociationGroupDefinition { Name = Constants.CrossSellGroupName });
            associationDefinitionRepository.Add(new AssociationGroupDefinition { Name = Constants.UpSellGroupName });
        }

        private void SetDefaultGroups(InitializationEngine context)
        {
            const string defaultGroup = "default";

            var assetUrlConventions = context.Locate.Advanced.GetInstance<AssetUrlConventions>();
            assetUrlConventions.AddDefaultGroup<EntryContentBase>(defaultGroup);
            assetUrlConventions.AddDefaultGroup<NodeContent>(defaultGroup);
        }
    }
}
