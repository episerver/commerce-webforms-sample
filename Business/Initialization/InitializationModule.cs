using System.Collections.Generic;
using System.Linq;
using System.Web.Routing;
using EPiServer.Business.Commerce;
using EPiServer.Commerce.Catalog.Linking;
using EPiServer.Commerce.Routing;
using EPiServer.Commerce.Sample.Helpers;
using EPiServer.Framework;
using EPiServer.Framework.Initialization;
using EPiServer.ServiceLocation;
using Mediachase.Commerce;
using Mediachase.Commerce.Markets;
using Mediachase.Commerce.Orders.Dto;
using Mediachase.Commerce.Orders.Managers;

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

            // Init only in Web context type and first loading time of EPiServer Commerce Sample Site
            if (SettingFactory.Instance.Setting.IsSampleDataConfigured)
                return;

            // switch the flag
            SettingFactory.Instance.Setting.IsSampleDataConfigured = true;
            SettingFactory.Instance.Save();
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
    }
}
