#region Copyright © 1997-2007 EPiServer AB. All Rights Reserved.
/*
This code may only be used according to the EPiServer License Agreement.
The use of this code outside the EPiServer environment, in whole or in
parts, is forbidden without prior written permission from EPiServer AB.

EPiServer is a registered trademark of EPiServer AB. For more information 
see http://www.episerver.com/license or request a copy of the EPiServer 
License Agreement by sending an email to info@episerver.com
*/
#endregion

using System.Collections.Generic;
using System.Threading;
using EPiServer;
using EPiServer.Configuration;
using EPiServer.Core;
using EPiServer.DataAbstraction;
using EPiServer.DataAbstraction.RuntimeModel;
using EPiServer.Enterprise;
using EPiServer.Enterprise.Transfer;
using EPiServer.Search;
using EPiServer.ServiceLocation;
using EPiServer.Web;
using EPiServer.Web.Hosting;
using log4net;
using Mediachase.Commerce.BackgroundTasks;
using Mediachase.Commerce.Catalog.ImportExport;
using Mediachase.Commerce.Core;
using Mediachase.Commerce.Customers;
using Mediachase.Commerce.Extensions;
using Mediachase.Commerce.Shared;
using Mediachase.Search;
using System;
using System.IO;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Hosting;
using System.Linq;

namespace EPiServer.Commerce.Sample
{
    public partial class ImportSiteContent : System.Web.UI.Page
    {
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            
            var setupImporter = ServiceLocator.Current.GetInstance<ContentDataImporter>();
            if (!setupImporter.IsImporting)
            {
                string root = "~/App_Data/SampleData/";
                var siteContentPath = GetFilePathOrDefault("sitecontent", Path.Combine(root, "StarterDemoB2CSite.episerverdata"));
                var assetPath = GetFilePathOrDefault("asset", Path.Combine(root, "SampleAssets.episerverdata"));
                var catalogPath = GetFilePathOrDefault("catalog", Path.Combine(root, "StarterDemoDepartmental.zip"));

                var importActionString = HttpContext.Current.Request.QueryString["action"];
                var importAction = !string.IsNullOrEmpty(importActionString)
                    ? (ImportAction) Enum.Parse(typeof (ImportAction), importActionString, true)
                    : ImportAction.SiteContent | ImportAction.AssetContent | ImportAction.CatalogContent; // import all by default

                setupImporter.Url = HttpContext.Current.Request.Url;
                setupImporter.SiteContentPath = siteContentPath;
                setupImporter.AssetPath = assetPath;
                setupImporter.CatalogPackagePath = catalogPath;
                
                setupImporter.Import(importAction);
            }

            ImportLbl.Text = setupImporter.GetProgress();
            progressbar.Attributes["value"] = setupImporter.GetCurrentPercentage().ToString();
            if (setupImporter.IsDone)
            {
                // reset IsImporting and IsDone, so if we want to import other content, it will do.
                setupImporter.IsImporting = false;
                setupImporter.IsDone = false;
                Response.Redirect(HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority), false);
                Context.ApplicationInstance.CompleteRequest();
            }
            else if (setupImporter.IsFailed)
            {
                // reset IsImporting and IsFailed, so if we want to import other content, it will do.
                setupImporter.IsImporting = false;
                setupImporter.IsFailed = false;
                Response.StatusCode = (int)HttpStatusCode.InternalServerError;
                Response.TrySkipIisCustomErrors = true;
                // stop meta refresh
                Header.Controls.Remove(autoRefreshTag);
            }
        }

        private string GetFilePathOrDefault(string name, string defaultPath)
        {
            return !string.IsNullOrEmpty(HttpContext.Current.Request.QueryString[name])
                    ? HttpContext.Current.Request.QueryString[name]
                    : Server.MapPath(defaultPath);
        }

    }

    [Flags]
    internal enum ImportAction
    {
        None = 0,
        SiteContent = 1,
        AssetContent = 2,
        CatalogContent = 4
    }

    [ServiceConfiguration(Lifecycle = ServiceInstanceScope.Singleton)]
    internal class ContentDataImporter
    {
        private static readonly ILog _log = LogManager.GetLogger(typeof(ContentDataImporter));
        private readonly CatalogImportExport _importer;
        private readonly WebProgressMessenger _progressMessenger;
        private readonly ILanguageBranchRepository _languageBranchRepository;
        public Uri Url { get; set; }

        public string SiteContentPath { get; set; }
        public string AssetPath { get; set; }
        public string CatalogPackagePath { get; set; }
        public string AssetMappingPath { get; set; }

        public ContentDataImporter(CatalogImportExport importer, ILanguageBranchRepository languageBranchRepository)
        {
            _progressMessenger = new WebProgressMessenger();
            _importer = importer;
            _importer.ImportExportProgressMessage += ImportExport_ImportExportProgressMessage;
            _languageBranchRepository = languageBranchRepository;
        }

        public void Import(ImportAction action)
        {
            if (IsImporting)
            {
                return;
            }
            var customer = CustomerContext.Current.GetContactById(Guid.Empty);
            // instantiate the import job here so that it can capture the current EventContext instance.
            var importJob = new ImportJob(AppContext.Current.ApplicationId, CatalogPackagePath, "Catalog.xml", true);

            Action importAction = () =>
            {
                IsImporting = true;
                try
                {
                    if ((action & ImportAction.SiteContent) == ImportAction.SiteContent)
                    {
                        _progressMessenger.AddProgressMessageText("Importing Site content...", false, 0);
                        doImportEpiData(SiteContentPath);
                        _progressMessenger.AddProgressMessageText("Done importing Site content.", false, 5);
                    }

                    if ((action & ImportAction.AssetContent) == ImportAction.AssetContent)
                    {
                        _progressMessenger.AddProgressMessageText("Importing Asset content...", false, 10);
                        doImportEpiData(AssetPath);
                        _progressMessenger.AddProgressMessageText("Done importing Asset content.", false, 15);

                        //Reindex the asset contents to make them searchable
                        _progressMessenger.AddProgressMessageText("Start indexing asset contents.", false, 15);
                        ServiceLocator.Current.GetInstance<ReIndexManager>().ReIndex();
                        _progressMessenger.AddProgressMessageText("Done indexing asset contents.", false, 20);
                    }

                    #region Import catalog and asset mapping

                    if ((action & ImportAction.CatalogContent) == ImportAction.CatalogContent)
                    {
                        _progressMessenger.AddProgressMessageText("Importing Catalog content...", false, 20);
                        Action<IBackgroundTaskMessage> addMessage = msg =>
                        {
                            var isError = msg.MessageType == BackgroundTaskMessageType.Error;
                            var percent = (int)Math.Round(msg.GetOverallProgress() * 100);
                            var message = msg.Exception == null
                                ? msg.Message
                                : string.Format("{0} {1}", msg.Message, msg.ExceptionMessage);
                            _progressMessenger.AddProgressMessageText(message, isError, percent);
                        };
                        importJob.Execute(addMessage, CancellationToken.None);
                        _progressMessenger.AddProgressMessageText("Done importing Catalog content", false, 60);

                        //We are running in front-end site context, the metafield update events are ignored, we need to sync manually
                        _progressMessenger.AddProgressMessageText("Syncing metaclasses with content types", false, 60);
                        SyncMetaClassesToContentTypeModels();
                        _progressMessenger.AddProgressMessageText("Done syncing metaclasses with content types", false, 70);

                        _progressMessenger.AddProgressMessageText("Rebuilding index...", false, 70);
                        BuildIndex(_progressMessenger, AppContext.Current.ApplicationId, AppContext.Current.ApplicationName, true);
                        _progressMessenger.AddProgressMessageText("Done rebuilding index", false, 90);
                    }

                    #endregion

                    _progressMessenger.SetProgressDone();
                    IsDone = true;
                }
                catch (Exception ex)
                {
                    var error = ex.Message + "<br />" + ex.StackTrace;
                    _progressMessenger.AddProgressMessageText(error, true, 0);

                    _progressMessenger.SetProgressFailed();

                    IsFailed = true;

                    _log.Error("Import failed");
                    _log.Error(ex);

                    throw;
                }
            };
            Task.Factory.StartNew(importAction);
        }

        /// <summary>
        /// Synchronizes the meta classes to content type models.
        /// The synchronization will be done when site starts up. 
        /// To avoid restarting a site, we do the models synchronization manually.
        /// </summary>
        private void SyncMetaClassesToContentTypeModels()
        {
            var cachedRepository = ServiceLocator.Current.GetInstance<IContentTypeRepository>() as ICachedRepository;
            if (cachedRepository != null)
            {
                cachedRepository.ClearCache();
            }

            cachedRepository = ServiceLocator.Current.GetInstance<IPropertyDefinitionRepository>() as ICachedRepository;
            if (cachedRepository != null)
            {
                cachedRepository.ClearCache();
            }

            var tasks = new List<Task>();

            var contentScanner = ServiceLocator.Current.GetInstance<ContentTypeModelScanner>();
            tasks.AddRange(contentScanner.RegisterModels());
            tasks.AddRange(contentScanner.Sync(Settings.Instance.EnableModelSyncCommit));

            Task.WaitAll(tasks.ToArray());
        }

        private void doImportEpiData(string importPackagePath)
        {
            if (string.IsNullOrEmpty(importPackagePath))
            {
                return;
            }
            DataImporter importer = new DataImporter();
            if (importPackagePath.Contains("StarterDemoB2CSite.episerverdata"))
            {
                importer.DestinationRoot = PageReference.RootPage;
            }
            else if (importPackagePath.Contains("SampleAssets.episerverdata"))
            {
                importer.DestinationRoot = ContentReference.GlobalBlockFolder;
            }

            importer.Stream = new FileStream(importPackagePath, FileMode.Open, FileAccess.Read, FileShare.Read);

            // Clear the cache to ensure setup is running in a controlled environment, if perhaps we're developing and have just cleared
            // the database.
            CacheManager.Clear();
            importer.KeepIdentity = true;
            importer.Import();
            String logError = ReportStatus(importer);
            if (importer.Log.Errors.Count == 0)
            {
                if (importPackagePath.Contains("StarterDemoB2CSite.episerverdata"))
                {
                    if (SiteDefinition.Current.StartPage.ID <= 0)
                    {
                        UpdateLanguageBranches(importer);
                    }

                    UpdateSiteSettings(importer.CopiedContentLink.ToReferenceWithoutVersion());
                }
            }
            else
            {
                throw new Exception(" Site Content Data could not be imported due to: " + logError);
            }
        }

        private string ReportStatus(ITransferContext importer)
        {
            var logMessage = new StringBuilder();
            var lineBreak = "<br>";

            if (importer.Log.Errors.Count > 0)
            {
                foreach (string err in importer.Log.Errors)
                {
                    logMessage.Append(err).Append(lineBreak);
                }
            }

            if (importer.Log.Warnings.Count > 0)
            {
                foreach (string err in importer.Log.Warnings)
                {
                    logMessage.Append(err).Append(lineBreak);
                }
            }
            return logMessage.ToString();
        }

        private void UpdateLanguageBranches(DataImporter importer)
        {
            // Enable all language branches in the import package
            LanguageBranch languageBranch;
            foreach (string languageID in importer.ContentLanguages)
            {
                languageBranch = _languageBranchRepository.Load(languageID);

                if (languageBranch == null)
                {
                    languageBranch = new LanguageBranch(languageID, null);
                    _languageBranchRepository.Save(languageBranch);
                }
                else if (!languageBranch.Enabled)
                {
                    languageBranch = new LanguageBranch(languageBranch.ID, languageBranch.LanguageID, languageBranch.Name, languageBranch.SortIndex, languageBranch.RawIconPath, languageBranch.URLSegment, true);
                    _languageBranchRepository.Save(languageBranch);
                }
            }

        }

        private void UpdateSiteSettings(ContentReference startPage)
        {
            //If we install on a site that already has content, new start page will be updated.
            var context = HttpContext.Current.ContextBaseOrNull();
            var siteDefinition = SiteDefinition.Current;
            //Set start page in case upgrading 
            siteDefinition = siteDefinition.CreateWritableClone();
            siteDefinition.StartPage = startPage;

            siteDefinition.Name = HostingEnvironment.SiteName;

            UrlBuilder urlBuilder = new UrlBuilder(Url.GetLeftPart(UriPartial.Authority));
            urlBuilder.Path = GenericHostingEnvironment.ApplicationVirtualPath;            
            siteDefinition.SiteUrl = new Uri(VirtualPathUtility.AppendTrailingSlash((string)urlBuilder));

            //do not add duplicate host names
            var hostDefinitionExists = siteDefinition.Hosts.Any(x => x.Name.Equals(urlBuilder.Uri.Authority,StringComparison.OrdinalIgnoreCase));
            if (!hostDefinitionExists)
            {
                siteDefinition.Hosts.Add(new HostDefinition() { Name = urlBuilder.Uri.Authority });
                siteDefinition.Hosts.Add(new HostDefinition() { Name = SiteDefinition.WildcardHostName });
            }
            else
            {
                _progressMessenger.AddProgressMessageText(string.Format("Warning - Host name '{0}' already exists", urlBuilder.Uri.Authority), false, 0);
            }
            
            ServiceLocator.Current.GetInstance<SiteDefinitionRepository>().Save(siteDefinition);

            SiteDefinition.Current = siteDefinition;
        }

        /// <summary>
        /// Builds, or rebuilds catalog search index.
        /// </summary>
        /// <param name="progressMessenger">The progress messenger that handles progress messages.</param>
        /// <param name="applicationId">The application Id to build index.</param>
        /// <param name="applicationName">The application Name to build index.</param>
        /// <param name="rebuild">Flag to indicate whether rebuild or just build index.</param>
        private void BuildIndex(IProgressMessenger progressMessenger, Guid applicationId, string applicationName, bool rebuild)
        {
            var searchManager = new SearchManager(applicationName);
            searchManager.SearchIndexMessage += SearchManager_SearchIndexMessage;
            searchManager.BuildIndex(rebuild);
        }

        private void SearchManager_SearchIndexMessage(object source, SearchIndexEventArgs args)
        {
            // The whole index building process would take 20% (from 70 to 90) of the import process. Then the percent value here should be calculated based on 20%
            var percent = 70 + Convert.ToInt32(args.CompletedPercentage) * 2 / 10;
            _progressMessenger.AddProgressMessageText(args.Message, false, percent);
        }

        public bool IsImporting { get; set; }
        public bool IsDone { get; set; }
        public bool IsFailed { get; set; }

        public string GetProgress()
        {
            return _progressMessenger.Progress;
        }
        public int GetCurrentPercentage()
        {
            return _progressMessenger.CurrentPercentage;
        }

        private void ImportExport_ImportExportProgressMessage(object sender, ImportExportEventArgs args)
        {
            // The whole catalog import process would take 50% (from 20 to 70) of the import process. Then the percent value here should be calculated based on 50%
            var percent = 20 + Convert.ToInt32(args.CompletedPercentage) * 5 / 10;
            _progressMessenger.AddProgressMessageText(args.Message, false, percent);
        }

        private class WebProgressMessenger : IProgressMessenger
        {
            public string Progress { get; private set; }
            public int CurrentPercentage { get; private set; }

            public void AddProgressMessageText(string message, bool error, int percent)
            {
                var timeStamp = string.Format("{0:T}", DateTime.Now);
                CurrentPercentage = percent > 0 ? percent : CurrentPercentage;
                Progress = timeStamp + " : " + message + "<br />" + Progress;
            }

            public void SetProgressDone()
            {
                Progress = "<h2>Progress done, import succeeded.</h2> <br />" + Progress;
                CurrentPercentage = 100;
            }

            public void SetProgressFailed()
            {
                Progress = "<h2>Progress done, import failed.</h2><h2>Errors were logged.</h2><br />" + Progress;
            }
        }
    }
}
