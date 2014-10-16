commerce-webforms-sample
========================

This repository is the sample site for EPiServer Commerce based on WebForms.  

Installation
------------

For less configuration steps clone the repository to C:\Projects\CommerceWebforms

1.  Open solution file and build solution to download nuget package dependencies
2.  Edit Setup\SetupDatabases.bat if you need to change the server for the databases.  
    If you change the database settings you will need to also update the connectionstrings.config file.  
    The sql statements are run with windows authentication so you will need to add username and password for the osql statements
    if you only have sql authentication		
3.  Execute SetupDatabases.bat		
4.  Open nuget package manager console and run Update-EPiDatabase to update to latest database versions
5.  Check configuration values for the following config files:    
        * EPiServerFramework.config
	* appSettings.config
	* EPiServerLog.config
	* Mediachase.Search.Config
	* connectionstrings.config
6.  Browse to http://localhost:51643/ImportSiteContent.aspx to finish installation
