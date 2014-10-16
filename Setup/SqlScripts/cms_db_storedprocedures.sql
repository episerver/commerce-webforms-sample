/****** Object:  StoredProcedure [dbo].[GetContentSchemaVersionNumber]    Script Date: 07/21/2009 17:20:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetContentSchemaVersionNumber]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetContentSchemaVersionNumber]
GO

/****** Object:  StoredProcedure [dbo].[cms_fs_FileTreeAdd]    Script Date: 07/21/2009 17:20:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_fs_FileTreeAdd]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_fs_FileTreeAdd]
GO

/****** Object:  StoredProcedure [dbo].[cms_fs_FileTreeGetRoot]    Script Date: 07/21/2009 17:20:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_fs_FileTreeGetRoot]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_fs_FileTreeGetRoot]
GO

/****** Object:  StoredProcedure [dbo].[cms_fs_FileTreeLoadAll]    Script Date: 07/21/2009 17:20:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_fs_FileTreeLoadAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_fs_FileTreeLoadAll]
GO

/****** Object:  StoredProcedure [dbo].[cms_fs_FileTreeLoadAllFolders]    Script Date: 07/21/2009 17:20:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_fs_FileTreeLoadAllFolders]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_fs_FileTreeLoadAllFolders]
GO

/****** Object:  StoredProcedure [dbo].[cms_fs_FileTreeLoadByFolderId]    Script Date: 07/21/2009 17:20:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_fs_FileTreeLoadByFolderId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_fs_FileTreeLoadByFolderId]
GO

/****** Object:  StoredProcedure [dbo].[cms_fs_FileTreeLoadById]    Script Date: 07/21/2009 17:20:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_fs_FileTreeLoadById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_fs_FileTreeLoadById]
GO

/****** Object:  StoredProcedure [dbo].[cms_fs_FileTreeLoadByOutline]    Script Date: 07/21/2009 17:20:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_fs_FileTreeLoadByOutline]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_fs_FileTreeLoadByOutline]
GO

/****** Object:  StoredProcedure [dbo].[cms_fs_FileTreeLoadByOutlineAll]    Script Date: 07/21/2009 17:20:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_fs_FileTreeLoadByOutlineAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_fs_FileTreeLoadByOutlineAll]
GO

/****** Object:  StoredProcedure [dbo].[cms_fs_FileTreeLoadParent]    Script Date: 07/21/2009 17:20:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_fs_FileTreeLoadParent]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_fs_FileTreeLoadParent]
GO

/****** Object:  StoredProcedure [dbo].[cms_fs_FileTreeLoadParentAll]    Script Date: 07/21/2009 17:20:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_fs_FileTreeLoadParentAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_fs_FileTreeLoadParentAll]
GO

/****** Object:  StoredProcedure [dbo].[cms_fs_FileTreeUpdate]    Script Date: 07/21/2009 17:20:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_fs_FileTreeUpdate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_fs_FileTreeUpdate]
GO

/****** Object:  StoredProcedure [dbo].[cms_GlobalVariablesAdd]    Script Date: 07/21/2009 17:20:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_GlobalVariablesAdd]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_GlobalVariablesAdd]
GO

/****** Object:  StoredProcedure [dbo].[cms_GlobalVariablesDelete]    Script Date: 07/21/2009 17:20:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_GlobalVariablesDelete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_GlobalVariablesDelete]
GO

/****** Object:  StoredProcedure [dbo].[cms_GlobalVariablesLoadByKey]    Script Date: 07/21/2009 17:20:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_GlobalVariablesLoadByKey]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_GlobalVariablesLoadByKey]
GO

/****** Object:  StoredProcedure [dbo].[cms_GlobalVariablesUpdate]    Script Date: 07/21/2009 17:21:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_GlobalVariablesUpdate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_GlobalVariablesUpdate]
GO

/****** Object:  StoredProcedure [dbo].[cms_LanguageInfo_Add]    Script Date: 07/21/2009 17:21:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_LanguageInfo_Add]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_LanguageInfo_Add]
GO

/****** Object:  StoredProcedure [dbo].[cms_LanguageInfo_Delete]    Script Date: 07/21/2009 17:21:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_LanguageInfo_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_LanguageInfo_Delete]
GO

/****** Object:  StoredProcedure [dbo].[cms_LanguageInfo_GetByLangName]    Script Date: 07/21/2009 17:21:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_LanguageInfo_GetByLangName]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_LanguageInfo_GetByLangName]
GO

/****** Object:  StoredProcedure [dbo].[cms_LanguageInfo_LoadById]    Script Date: 07/21/2009 17:21:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_LanguageInfo_LoadById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_LanguageInfo_LoadById]
GO

/****** Object:  StoredProcedure [dbo].[cms_LanguageInfo_Update]    Script Date: 07/21/2009 17:21:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_LanguageInfo_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_LanguageInfo_Update]
GO

/****** Object:  StoredProcedure [dbo].[cms_LanguageInfoLoadAll]    Script Date: 07/21/2009 17:21:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_LanguageInfoLoadAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_LanguageInfoLoadAll]
GO

/****** Object:  StoredProcedure [dbo].[cms_menu_LoadById]    Script Date: 07/21/2009 17:21:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_menu_LoadById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_menu_LoadById]
GO

/****** Object:  StoredProcedure [dbo].[cms_menu_LoadByMenuItemId]    Script Date: 07/21/2009 17:21:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_menu_LoadByMenuItemId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_menu_LoadByMenuItemId]
GO

/****** Object:  StoredProcedure [dbo].[cms_menu_LoadBySiteId]    Script Date: 07/21/2009 17:21:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_menu_LoadBySiteId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_menu_LoadBySiteId]
GO

/****** Object:  StoredProcedure [dbo].[cms_menu_MenuAdd]    Script Date: 07/21/2009 17:21:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_menu_MenuAdd]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_menu_MenuAdd]
GO

/****** Object:  StoredProcedure [dbo].[cms_menu_MenuDelete]    Script Date: 07/21/2009 17:21:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_menu_MenuDelete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_menu_MenuDelete]
GO

/****** Object:  StoredProcedure [dbo].[cms_menu_MenuGetById]    Script Date: 07/21/2009 17:21:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_menu_MenuGetById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_menu_MenuGetById]
GO

/****** Object:  StoredProcedure [dbo].[cms_menu_MenuGetByName]    Script Date: 07/21/2009 17:21:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_menu_MenuGetByName]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_menu_MenuGetByName]
GO

/****** Object:  StoredProcedure [dbo].[cms_menu_MenuItemGetAllRoot]    Script Date: 07/21/2009 17:21:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_menu_MenuItemGetAllRoot]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_menu_MenuItemGetAllRoot]
GO

/****** Object:  StoredProcedure [dbo].[cms_menu_MenuUpdate]    Script Date: 07/21/2009 17:21:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_menu_MenuUpdate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_menu_MenuUpdate]
GO

/****** Object:  StoredProcedure [dbo].[cms_NavigationCommandAll]    Script Date: 07/21/2009 17:21:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_NavigationCommandAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_NavigationCommandAll]
GO

/****** Object:  StoredProcedure [dbo].[cms_NavigationCommandDelete]    Script Date: 07/21/2009 17:21:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_NavigationCommandDelete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_NavigationCommandDelete]
GO

/****** Object:  StoredProcedure [dbo].[cms_NavigationCommandInsert]    Script Date: 07/21/2009 17:21:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_NavigationCommandInsert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_NavigationCommandInsert]
GO

/****** Object:  StoredProcedure [dbo].[cms_NavigationCommandSelect]    Script Date: 07/21/2009 17:21:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_NavigationCommandSelect]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_NavigationCommandSelect]
GO

/****** Object:  StoredProcedure [dbo].[cms_NavigationCommandSelectByItemId]    Script Date: 07/21/2009 17:21:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_NavigationCommandSelectByItemId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_NavigationCommandSelectByItemId]
GO

/****** Object:  StoredProcedure [dbo].[cms_NavigationCommandSelectByPageId]    Script Date: 07/21/2009 17:21:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_NavigationCommandSelectByPageId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_NavigationCommandSelectByPageId]
GO

/****** Object:  StoredProcedure [dbo].[cms_NavigationCommandUpdate]    Script Date: 07/21/2009 17:21:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_NavigationCommandUpdate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_NavigationCommandUpdate]
GO

/****** Object:  StoredProcedure [dbo].[cms_NavigationItemsDelete]    Script Date: 07/21/2009 17:21:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_NavigationItemsDelete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_NavigationItemsDelete]
GO

/****** Object:  StoredProcedure [dbo].[cms_NavigationItemsInsert]    Script Date: 07/21/2009 17:21:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_NavigationItemsInsert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_NavigationItemsInsert]
GO

/****** Object:  StoredProcedure [dbo].[cms_NavigationItemsSelect]    Script Date: 07/21/2009 17:21:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_NavigationItemsSelect]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_NavigationItemsSelect]
GO

/****** Object:  StoredProcedure [dbo].[cms_NavigationItemsSelectAll]    Script Date: 07/21/2009 17:21:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_NavigationItemsSelectAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_NavigationItemsSelectAll]
GO

/****** Object:  StoredProcedure [dbo].[cms_NavigationItemsSelectByName]    Script Date: 07/21/2009 17:21:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_NavigationItemsSelectByName]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_NavigationItemsSelectByName]
GO

/****** Object:  StoredProcedure [dbo].[cms_NavigationItemsUpdate]    Script Date: 07/21/2009 17:21:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_NavigationItemsUpdate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_NavigationItemsUpdate]
GO

/****** Object:  StoredProcedure [dbo].[cms_NavigationParamsDelete]    Script Date: 07/21/2009 17:21:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_NavigationParamsDelete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_NavigationParamsDelete]
GO

/****** Object:  StoredProcedure [dbo].[cms_NavigationParamsInsert]    Script Date: 07/21/2009 17:21:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_NavigationParamsInsert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_NavigationParamsInsert]
GO

/****** Object:  StoredProcedure [dbo].[cms_NavigationParamsSelectAll]    Script Date: 07/21/2009 17:21:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_NavigationParamsSelectAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_NavigationParamsSelectAll]
GO

/****** Object:  StoredProcedure [dbo].[cms_NavigationParamsSelectByItemId]    Script Date: 07/21/2009 17:21:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_NavigationParamsSelectByItemId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_NavigationParamsSelectByItemId]
GO

/****** Object:  StoredProcedure [dbo].[cms_NavigationParamsUpdate]    Script Date: 07/21/2009 17:21:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_NavigationParamsUpdate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_NavigationParamsUpdate]
GO

/****** Object:  StoredProcedure [dbo].[cms_page_PageVersionGetByUserId2]    Script Date: 07/21/2009 17:21:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_page_PageVersionGetByUserId2]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_page_PageVersionGetByUserId2]
GO

/****** Object:  StoredProcedure [dbo].[cms_PageStateGetAll]    Script Date: 07/21/2009 17:21:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_PageStateGetAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_PageStateGetAll]
GO

/****** Object:  StoredProcedure [dbo].[cms_PageStateGetById]    Script Date: 07/21/2009 17:21:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_PageStateGetById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_PageStateGetById]
GO

/****** Object:  StoredProcedure [dbo].[cms_Site]    Script Date: 07/21/2009 17:21:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_Site]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_Site]
GO

/****** Object:  StoredProcedure [dbo].[cms_TemplatesLoadById]    Script Date: 07/21/2009 17:21:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_TemplatesLoadById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_TemplatesLoadById]
GO

/****** Object:  StoredProcedure [dbo].[cms_Workflow_Add]    Script Date: 07/21/2009 17:21:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_Workflow_Add]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_Workflow_Add]
GO

/****** Object:  StoredProcedure [dbo].[cms_Workflow_Delete]    Script Date: 07/21/2009 17:21:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_Workflow_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_Workflow_Delete]
GO

/****** Object:  StoredProcedure [dbo].[cms_Workflow_GetAll]    Script Date: 07/21/2009 17:21:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_Workflow_GetAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_Workflow_GetAll]
GO

/****** Object:  StoredProcedure [dbo].[cms_Workflow_GetById]    Script Date: 07/21/2009 17:21:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_Workflow_GetById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_Workflow_GetById]
GO

/****** Object:  StoredProcedure [dbo].[cms_Workflow_GetDefault]    Script Date: 07/21/2009 17:21:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_Workflow_GetDefault]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_Workflow_GetDefault]
GO

/****** Object:  StoredProcedure [dbo].[cms_Workflow_Update]    Script Date: 07/21/2009 17:21:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_Workflow_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_Workflow_Update]
GO

/****** Object:  StoredProcedure [dbo].[cms_WorkflowStatus_Add]    Script Date: 07/21/2009 17:21:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_WorkflowStatus_Add]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_WorkflowStatus_Add]
GO

/****** Object:  StoredProcedure [dbo].[cms_WorkflowStatus_Delete]    Script Date: 07/21/2009 17:21:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_WorkflowStatus_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_WorkflowStatus_Delete]
GO

/****** Object:  StoredProcedure [dbo].[cms_WorkflowStatus_GetAll]    Script Date: 07/21/2009 17:21:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_WorkflowStatus_GetAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_WorkflowStatus_GetAll]
GO

/****** Object:  StoredProcedure [dbo].[cms_WorkflowStatus_GetArcStatus]    Script Date: 07/21/2009 17:21:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_WorkflowStatus_GetArcStatus]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_WorkflowStatus_GetArcStatus]
GO

/****** Object:  StoredProcedure [dbo].[cms_WorkflowStatus_GetById]    Script Date: 07/21/2009 17:21:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_WorkflowStatus_GetById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_WorkflowStatus_GetById]
GO

/****** Object:  StoredProcedure [dbo].[cms_WorkflowStatus_GetByWorkflowId]    Script Date: 07/21/2009 17:21:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_WorkflowStatus_GetByWorkflowId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_WorkflowStatus_GetByWorkflowId]
GO

/****** Object:  StoredProcedure [dbo].[cms_WorkflowStatus_GetDraftStatus]    Script Date: 07/21/2009 17:21:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_WorkflowStatus_GetDraftStatus]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_WorkflowStatus_GetDraftStatus]
GO

/****** Object:  StoredProcedure [dbo].[cms_WorkflowStatus_Update]    Script Date: 07/21/2009 17:21:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_WorkflowStatus_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_WorkflowStatus_Update]
GO

/****** Object:  StoredProcedure [dbo].[cms_WorkflowStatusAccess_Add]    Script Date: 07/21/2009 17:21:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_WorkflowStatusAccess_Add]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_WorkflowStatusAccess_Add]
GO

/****** Object:  StoredProcedure [dbo].[cms_WorkflowStatusAccess_Delete]    Script Date: 07/21/2009 17:21:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_WorkflowStatusAccess_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_WorkflowStatusAccess_Delete]
GO

/****** Object:  StoredProcedure [dbo].[cms_WorkflowStatusAccess_GetAll]    Script Date: 07/21/2009 17:21:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_WorkflowStatusAccess_GetAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_WorkflowStatusAccess_GetAll]
GO

/****** Object:  StoredProcedure [dbo].[cms_WorkflowStatusAccess_GetById]    Script Date: 07/21/2009 17:21:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_WorkflowStatusAccess_GetById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_WorkflowStatusAccess_GetById]
GO

/****** Object:  StoredProcedure [dbo].[cms_WorkflowStatusAccess_GetByRoleId]    Script Date: 07/21/2009 17:21:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_WorkflowStatusAccess_GetByRoleId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_WorkflowStatusAccess_GetByRoleId]
GO

/****** Object:  StoredProcedure [dbo].[cms_WorkflowStatusAccess_GetByRoleIdStatusId]    Script Date: 07/21/2009 17:21:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_WorkflowStatusAccess_GetByRoleIdStatusId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_WorkflowStatusAccess_GetByRoleIdStatusId]
GO

/****** Object:  StoredProcedure [dbo].[cms_WorkflowStatusAccess_GetByRoleIdStatusIdNotEveryone]    Script Date: 07/21/2009 17:21:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_WorkflowStatusAccess_GetByRoleIdStatusIdNotEveryone]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_WorkflowStatusAccess_GetByRoleIdStatusIdNotEveryone]
GO

/****** Object:  StoredProcedure [dbo].[cms_WorkflowStatusAccess_GetByStatusId]    Script Date: 07/21/2009 17:21:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_WorkflowStatusAccess_GetByStatusId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_WorkflowStatusAccess_GetByStatusId]
GO

/****** Object:  StoredProcedure [dbo].[cms_WorkflowStatusAccess_GetNextStatus]    Script Date: 07/21/2009 17:21:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_WorkflowStatusAccess_GetNextStatus]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_WorkflowStatusAccess_GetNextStatus]
GO

/****** Object:  StoredProcedure [dbo].[cms_WorkflowStatusAccess_GetPrevStatus]    Script Date: 07/21/2009 17:21:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_WorkflowStatusAccess_GetPrevStatus]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_WorkflowStatusAccess_GetPrevStatus]
GO

/****** Object:  StoredProcedure [dbo].[cms_WorkflowStatusAccess_Update]    Script Date: 07/21/2009 17:21:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_WorkflowStatusAccess_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[cms_WorkflowStatusAccess_Update]
GO

/****** Object:  StoredProcedure [dbo].[dps_Control_Add]    Script Date: 07/21/2009 17:21:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_Control_Add]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dps_Control_Add]
GO

/****** Object:  StoredProcedure [dbo].[dps_Control_Delete]    Script Date: 07/21/2009 17:21:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_Control_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dps_Control_Delete]
GO

/****** Object:  StoredProcedure [dbo].[dps_Control_GetById]    Script Date: 07/21/2009 17:21:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_Control_GetById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dps_Control_GetById]
GO

/****** Object:  StoredProcedure [dbo].[dps_Control_GetByNodeId]    Script Date: 07/21/2009 17:21:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_Control_GetByNodeId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dps_Control_GetByNodeId]
GO

/****** Object:  StoredProcedure [dbo].[dps_Control_GetByUID]    Script Date: 07/21/2009 17:21:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_Control_GetByUID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dps_Control_GetByUID]
GO

/****** Object:  StoredProcedure [dbo].[dps_Control_Update]    Script Date: 07/21/2009 17:21:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_Control_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dps_Control_Update]
GO

/****** Object:  StoredProcedure [dbo].[dps_ControlSettings_GetByControlId]    Script Date: 07/21/2009 17:21:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_ControlSettings_GetByControlId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dps_ControlSettings_GetByControlId]
GO

/****** Object:  StoredProcedure [dbo].[dps_ControlSettings_GetByKeyAndControlId]    Script Date: 07/21/2009 17:21:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_ControlSettings_GetByKeyAndControlId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dps_ControlSettings_GetByKeyAndControlId]
GO

/****** Object:  StoredProcedure [dbo].[dps_ControlStorage_Add]    Script Date: 07/21/2009 17:21:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_ControlStorage_Add]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dps_ControlStorage_Add]
GO

/****** Object:  StoredProcedure [dbo].[dps_ControlStorage_Delete]    Script Date: 07/21/2009 17:21:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_ControlStorage_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dps_ControlStorage_Delete]
GO

/****** Object:  StoredProcedure [dbo].[dps_ControlStorage_GetByControlId]    Script Date: 07/21/2009 17:21:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_ControlStorage_GetByControlId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dps_ControlStorage_GetByControlId]
GO

/****** Object:  StoredProcedure [dbo].[dps_ControlStorage_GetById]    Script Date: 07/21/2009 17:21:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_ControlStorage_GetById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dps_ControlStorage_GetById]
GO

/****** Object:  StoredProcedure [dbo].[dps_ControlStorage_Update]    Script Date: 07/21/2009 17:21:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_ControlStorage_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dps_ControlStorage_Update]
GO

/****** Object:  StoredProcedure [dbo].[dps_Node_Add]    Script Date: 07/21/2009 17:21:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_Node_Add]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dps_Node_Add]
GO

/****** Object:  StoredProcedure [dbo].[dps_Node_Delete]    Script Date: 07/21/2009 17:21:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_Node_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dps_Node_Delete]
GO

/****** Object:  StoredProcedure [dbo].[dps_Node_GetByControlPlaceId]    Script Date: 07/21/2009 17:21:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_Node_GetByControlPlaceId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dps_Node_GetByControlPlaceId]
GO

/****** Object:  StoredProcedure [dbo].[dps_Node_GetById]    Script Date: 07/21/2009 17:21:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_Node_GetById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dps_Node_GetById]
GO

/****** Object:  StoredProcedure [dbo].[dps_Node_GetByPageId]    Script Date: 07/21/2009 17:21:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_Node_GetByPageId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dps_Node_GetByPageId]
GO

/****** Object:  StoredProcedure [dbo].[dps_Node_GetByUID]    Script Date: 07/21/2009 17:21:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_Node_GetByUID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dps_Node_GetByUID]
GO

/****** Object:  StoredProcedure [dbo].[dps_Node_Update]    Script Date: 07/21/2009 17:21:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_Node_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dps_Node_Update]
GO

/****** Object:  StoredProcedure [dbo].[dps_NodeType_Add]    Script Date: 07/21/2009 17:21:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_NodeType_Add]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dps_NodeType_Add]
GO

/****** Object:  StoredProcedure [dbo].[dps_NodeType_Delete]    Script Date: 07/21/2009 17:21:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_NodeType_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dps_NodeType_Delete]
GO

/****** Object:  StoredProcedure [dbo].[dps_NodeType_GetById]    Script Date: 07/21/2009 17:21:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_NodeType_GetById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dps_NodeType_GetById]
GO

/****** Object:  StoredProcedure [dbo].[dps_NodeType_Update]    Script Date: 07/21/2009 17:21:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_NodeType_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dps_NodeType_Update]
GO

/****** Object:  StoredProcedure [dbo].[dps_PageDocument_Add]    Script Date: 07/21/2009 17:21:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_PageDocument_Add]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dps_PageDocument_Add]
GO

/****** Object:  StoredProcedure [dbo].[dps_PageDocument_Delete]    Script Date: 07/21/2009 17:21:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_PageDocument_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dps_PageDocument_Delete]
GO

/****** Object:  StoredProcedure [dbo].[dps_PageDocument_GetById]    Script Date: 07/21/2009 17:21:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_PageDocument_GetById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dps_PageDocument_GetById]
GO

/****** Object:  StoredProcedure [dbo].[dps_PageDocument_GetByPageVersionId]    Script Date: 07/21/2009 17:21:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_PageDocument_GetByPageVersionId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dps_PageDocument_GetByPageVersionId]
GO

/****** Object:  StoredProcedure [dbo].[dps_PageDocument_Update]    Script Date: 07/21/2009 17:21:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_PageDocument_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dps_PageDocument_Update]
GO

/****** Object:  StoredProcedure [dbo].[dps_TemporaryStorage_Add]    Script Date: 07/21/2009 17:21:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_TemporaryStorage_Add]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dps_TemporaryStorage_Add]
GO

/****** Object:  StoredProcedure [dbo].[dps_TemporaryStorage_Delete]    Script Date: 07/21/2009 17:21:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_TemporaryStorage_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dps_TemporaryStorage_Delete]
GO

/****** Object:  StoredProcedure [dbo].[dps_TemporaryStorage_GetById]    Script Date: 07/21/2009 17:21:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_TemporaryStorage_GetById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dps_TemporaryStorage_GetById]
GO

/****** Object:  StoredProcedure [dbo].[dps_TemporaryStorage_GetByPageVersionId]    Script Date: 07/21/2009 17:21:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_TemporaryStorage_GetByPageVersionId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dps_TemporaryStorage_GetByPageVersionId]
GO

/****** Object:  StoredProcedure [dbo].[dps_TemporaryStorage_Update]    Script Date: 07/21/2009 17:21:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_TemporaryStorage_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dps_TemporaryStorage_Update]
GO

/****** Object:  StoredProcedure [dbo].[main_FileTreeDelete]    Script Date: 07/21/2009 17:21:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_FileTreeDelete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_FileTreeDelete]
GO

/****** Object:  StoredProcedure [dbo].[main_FileTreeLoadFolderWithContent]    Script Date: 07/21/2009 17:21:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_FileTreeLoadFolderWithContent]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_FileTreeLoadFolderWithContent]
GO

/****** Object:  StoredProcedure [dbo].[main_FileTreeMoveTo]    Script Date: 07/21/2009 17:21:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_FileTreeMoveTo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_FileTreeMoveTo]
GO

/****** Object:  StoredProcedure [dbo].[main_FileTreeLoadFolderDefaultPage]    Script Date: 07/21/2009 17:21:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_FileTreeLoadFolderDefaultPage]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_FileTreeLoadFolderDefaultPage]
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItem_ResourcesAdd]    Script Date: 07/21/2009 17:21:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItem_ResourcesAdd]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_MenuItem_ResourcesAdd]
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItem_ResourcesDelete]    Script Date: 07/21/2009 17:21:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItem_ResourcesDelete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_MenuItem_ResourcesDelete]
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItem_ResourcesGetAvaliableLanguage]    Script Date: 07/21/2009 17:21:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItem_ResourcesGetAvaliableLanguage]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_MenuItem_ResourcesGetAvaliableLanguage]
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItem_ResourcesUpdate]    Script Date: 07/21/2009 17:21:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItem_ResourcesUpdate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_MenuItem_ResourcesUpdate]
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItemAdd]    Script Date: 07/21/2009 17:21:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItemAdd]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_MenuItemAdd]
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItemDelete]    Script Date: 07/21/2009 17:21:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItemDelete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_MenuItemDelete]
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItemGetAllChild]    Script Date: 07/21/2009 17:21:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItemGetAllChild]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_MenuItemGetAllChild]
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItemGetByMenuIdLanguageId]    Script Date: 07/21/2009 17:21:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItemGetByMenuIdLanguageId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_MenuItemGetByMenuIdLanguageId]
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItemGetByMenuId]    Script Date: 07/21/2009 17:21:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItemGetByMenuId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_MenuItemGetByMenuId]
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItemGetByMenuItemId]    Script Date: 07/21/2009 17:21:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItemGetByMenuItemId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_MenuItemGetByMenuItemId]
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItemGetByMenuItemIdAndLanguageId]    Script Date: 07/21/2009 17:21:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItemGetByMenuItemIdAndLanguageId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_MenuItemGetByMenuItemIdAndLanguageId]
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItemGetBySiteIdLanguageId]    Script Date: 07/21/2009 17:21:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItemGetBySiteIdLanguageId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_MenuItemGetBySiteIdLanguageId]
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItemGetParentByMenuItemId]    Script Date: 07/21/2009 17:21:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItemGetParentByMenuItemId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_MenuItemGetParentByMenuItemId]
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItemGetPathByMenuItemId]    Script Date: 07/21/2009 17:21:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItemGetPathByMenuItemId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_MenuItemGetPathByMenuItemId]
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItemGetRootByMenuId]    Script Date: 07/21/2009 17:21:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItemGetRootByMenuId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_MenuItemGetRootByMenuId]
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItemGetSubMenuByMenuItemId]    Script Date: 07/21/2009 17:21:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItemGetSubMenuByMenuItemId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_MenuItemGetSubMenuByMenuItemId]
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItemGetSubMenuByMenuItemIdAndLanguageId]    Script Date: 07/21/2009 17:21:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItemGetSubMenuByMenuItemIdAndLanguageId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_MenuItemGetSubMenuByMenuItemIdAndLanguageId]
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItemMoveTo]    Script Date: 07/21/2009 17:21:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItemMoveTo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_MenuItemMoveTo]
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItemUpdate]    Script Date: 07/21/2009 17:21:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItemUpdate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_MenuItemUpdate]
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItemUpdateSortOrder]    Script Date: 07/21/2009 17:21:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItemUpdateSortOrder]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_MenuItemUpdateSortOrder]
GO

/****** Object:  StoredProcedure [dbo].[main_PageAttributesAdd]    Script Date: 07/21/2009 17:21:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageAttributesAdd]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_PageAttributesAdd]
GO

/****** Object:  StoredProcedure [dbo].[main_PageAttributesDelete]    Script Date: 07/21/2009 17:21:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageAttributesDelete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_PageAttributesDelete]
GO

/****** Object:  StoredProcedure [dbo].[main_PageAttributesDeleteByPageId]    Script Date: 07/21/2009 17:21:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageAttributesDeleteByPageId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_PageAttributesDeleteByPageId]
GO

/****** Object:  StoredProcedure [dbo].[main_PageAttributesGetById]    Script Date: 07/21/2009 17:21:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageAttributesGetById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_PageAttributesGetById]
GO

/****** Object:  StoredProcedure [dbo].[main_PageAttributesGetByPageId]    Script Date: 07/21/2009 17:21:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageAttributesGetByPageId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_PageAttributesGetByPageId]
GO

/****** Object:  StoredProcedure [dbo].[main_PageAttributesUpdate]    Script Date: 07/21/2009 17:21:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageAttributesUpdate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_PageAttributesUpdate]
GO

/****** Object:  StoredProcedure [dbo].[main_PageTreeAccess_Add]    Script Date: 07/21/2009 17:21:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageTreeAccess_Add]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_PageTreeAccess_Add]
GO

/****** Object:  StoredProcedure [dbo].[main_PageTreeAccess_Delete]    Script Date: 07/21/2009 17:21:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageTreeAccess_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_PageTreeAccess_Delete]
GO

/****** Object:  StoredProcedure [dbo].[main_PageTreeAccess_GetAll]    Script Date: 07/21/2009 17:21:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageTreeAccess_GetAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_PageTreeAccess_GetAll]
GO

/****** Object:  StoredProcedure [dbo].[main_PageTreeAccess_GetById]    Script Date: 07/21/2009 17:21:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageTreeAccess_GetById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_PageTreeAccess_GetById]
GO

/****** Object:  StoredProcedure [dbo].[main_PageTreeAccess_GetByPageId]    Script Date: 07/21/2009 17:21:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageTreeAccess_GetByPageId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_PageTreeAccess_GetByPageId]
GO

/****** Object:  StoredProcedure [dbo].[main_PageTreeAccess_GetByRoleIdPageId]    Script Date: 07/21/2009 17:21:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageTreeAccess_GetByRoleIdPageId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_PageTreeAccess_GetByRoleIdPageId]
GO

/****** Object:  StoredProcedure [dbo].[main_PageTreeAccess_Update]    Script Date: 07/21/2009 17:21:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageTreeAccess_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_PageTreeAccess_Update]
GO

/****** Object:  StoredProcedure [dbo].[main_PageVersionAdd]    Script Date: 07/21/2009 17:21:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageVersionAdd]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_PageVersionAdd]
GO

/****** Object:  StoredProcedure [dbo].[main_PageVersionAdd2]    Script Date: 07/21/2009 17:21:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageVersionAdd2]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_PageVersionAdd2]
GO

/****** Object:  StoredProcedure [dbo].[main_PageVersionAddDraft]    Script Date: 07/21/2009 17:21:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageVersionAddDraft]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_PageVersionAddDraft]
GO

/****** Object:  StoredProcedure [dbo].[main_PageVersionDelete]    Script Date: 07/21/2009 17:21:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageVersionDelete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_PageVersionDelete]
GO

/****** Object:  StoredProcedure [dbo].[main_PageVersionGetById]    Script Date: 07/21/2009 17:21:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageVersionGetById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_PageVersionGetById]
GO

/****** Object:  StoredProcedure [dbo].[main_PageVersionGetByLangId]    Script Date: 07/21/2009 17:21:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageVersionGetByLangId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_PageVersionGetByLangId]
GO

/****** Object:  StoredProcedure [dbo].[main_PageVersionGetByLangIdAndStatusId]    Script Date: 07/21/2009 17:21:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageVersionGetByLangIdAndStatusId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_PageVersionGetByLangIdAndStatusId]
GO

/****** Object:  StoredProcedure [dbo].[main_PageVersionGetByPageId]    Script Date: 07/21/2009 17:21:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageVersionGetByPageId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_PageVersionGetByPageId]
GO

/****** Object:  StoredProcedure [dbo].[main_PageVersionGetByStateId]    Script Date: 07/21/2009 17:21:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageVersionGetByStateId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_PageVersionGetByStateId]
GO

/****** Object:  StoredProcedure [dbo].[main_PageVersionGetByStatusId]    Script Date: 07/21/2009 17:21:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageVersionGetByStatusId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_PageVersionGetByStatusId]
GO

/****** Object:  StoredProcedure [dbo].[main_PageVersionGetByUserId]    Script Date: 07/21/2009 17:21:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageVersionGetByUserId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_PageVersionGetByUserId]
GO

/****** Object:  StoredProcedure [dbo].[main_PageVersionUpdate]    Script Date: 07/21/2009 17:21:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageVersionUpdate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[main_PageVersionUpdate]
GO

/****** Object:  UserDefinedFunction [dbo].[cms_splitlist]    Script Date: 07/21/2009 17:21:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_splitlist]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[cms_splitlist]
GO

/****** Object:  StoredProcedure [dbo].[GetContentSchemaVersionNumber]    Script Date: 07/21/2009 17:21:36 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetContentSchemaVersionNumber]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetContentSchemaVersionNumber]
AS
	with PatchVersion (Major, Minor, Patch) as
		(SELECT max([Major]) as Major,
			max([Minor]) as Minor,
			max([Patch]) as Patch
			FROM [SchemaVersion]),
	PatchDate (Major, Minor, Patch, InstallDate) as 
		(SELECT Major, Minor, Patch, InstallDate from [SchemaVersion])
	SELECT PD.Major as Major, PD.Minor as Minor, PD.Patch as Patch, PD.InstallDate as InstallDate 
		FROM PatchDate PD, PatchVersion PV 
		WHERE PD.[Major]=PV.[Major] AND 
			PD.[Minor]=PV.[Minor] AND 
			PD.[Patch]=PV.[Patch]' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_fs_FileTreeAdd]    Script Date: 07/21/2009 17:21:36 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_fs_FileTreeAdd]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_fs_FileTreeAdd]
	@Name nvarchar(250),
	@IsPublic bit,
	@IsFolder bit,
	@IsDefault bit,
	@MasterPage nvarchar(256),
	@SiteId uniqueidentifier,
	@retval int output 
 AS
-- get maxOrder
DECLARE @MaxOrder int
SELECT @MaxOrder = MAX([Order]) FROM dbo.main_PageTree 
	WHERE [SiteId]=@SiteId
SET @MaxOrder = COALESCE(@MaxOrder, -1)
--add new element to root
INSERT INTO dbo.[main_PageTree]
	([Name],[IsPublic], [IsFolder], [IsDefault], [Outline], [OutlineLevel], [Order], [MasterPage], [SiteId]) 
	VALUES
	(@Name, @IsPublic, @IsFolder, @IsDefault, 
		case @IsFolder
				when 1 then CAST(''/''+@Name+''/'' AS NVARCHAR(2048))
				else CAST(''/''+@Name AS NVARCHAR(2048))
			   end,
		1, @MaxOrder + 1, @MasterPage, @SiteId)
SET @retval = SCOPE_IDENTITY()' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_fs_FileTreeGetRoot]    Script Date: 07/21/2009 17:21:36 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_fs_FileTreeGetRoot]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_fs_FileTreeGetRoot]
	@SiteId uniqueidentifier,
	@retval int output 
 AS
SELECT @retval = [PageId] FROM [main_PageTree] WHERE [OutlineLevel] = 0 and [SiteId] = @SiteId
IF @retval IS NULL
BEGIN
INSERT INTO [main_PageTree]
	([Name],[IsPublic], [IsFolder], [IsDefault], [Outline], [OutlineLevel], [Order], [SiteId]) 
	VALUES
	(''Root'',1,1,0, ''/'', 0, 0, @SiteId)
SET @retval = SCOPE_IDENTITY()
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_fs_FileTreeLoadAll]    Script Date: 07/21/2009 17:21:37 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_fs_FileTreeLoadAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_fs_FileTreeLoadAll] 
	@SiteId uniqueidentifier
AS
BEGIN
	SELECT [PageId], [Name], [Outline], [OutlineLevel], [IsFolder], [IsDefault], [Order], [IsPublic], isnull([MasterPage], ''''), SiteId FROM
		dbo.[main_PageTree]
	where SiteId = @SiteId
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_fs_FileTreeLoadAllFolders]    Script Date: 07/21/2009 17:21:37 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_fs_FileTreeLoadAllFolders]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_fs_FileTreeLoadAllFolders] 
	@SiteId uniqueidentifier
AS
SELECT [PageId], [Name], [Outline], [OutlineLevel], [IsFolder], [IsDefault], [Order], [IsPublic], SiteId
	FROM dbo.main_PageTree
	WHERE [IsFolder] = 1 and SiteId = @SiteId
	ORDER BY [Order]' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_fs_FileTreeLoadByFolderId]    Script Date: 07/21/2009 17:21:37 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_fs_FileTreeLoadByFolderId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_fs_FileTreeLoadByFolderId] 
	@FolderId int
AS
DECLARE @FolderOutline nvarchar(2048)
DECLARE @SiteId uniqueidentifier
DECLARE @OutlineLevel int
--get folder outline
SELECT @SiteId = SiteId, @FolderOutline = [Outline],@OutlineLevel = [OutlineLevel]
	FROM dbo.main_PageTree
	WHERE [PageId] = @FolderId
--get all files in folder
SELECT [PageId], [Name], [Outline], [OutlineLevel], [IsFolder], [IsDefault], [Order], [IsPublic], isnull([MasterPage], '''') as MasterPage, [SiteId]
	FROM dbo.main_PageTree
	WHERE ([Outline] LIKE @FolderOutline + ''%'') AND ([PageId] != @FolderId)  AND ([OutlineLevel] = @OutlineLevel + 1) AND SiteId = @SiteId
	ORDER BY [Name]' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_fs_FileTreeLoadById]    Script Date: 07/21/2009 17:21:38 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_fs_FileTreeLoadById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_fs_FileTreeLoadById] 
	@PageId int
AS
SELECT [PageId], [Name], [Outline], [OutlineLevel], [IsFolder], [IsDefault], [Order], [IsPublic], isnull([MasterPage], '''') as MasterPage, [SiteId]
	FROM dbo.main_PageTree
	WHERE [PageId] = @PageId' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_fs_FileTreeLoadByOutline]    Script Date: 07/21/2009 17:21:38 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_fs_FileTreeLoadByOutline]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_fs_FileTreeLoadByOutline] 
	@Outline nvarchar(2048),
	@SiteId uniqueidentifier
AS
--Get page OR default folder page
IF (SELECT  [IsFolder] FROM dbo.main_PageTree WHERE [Outline] LIKE @Outline and SiteId = @SiteId) = 1 
BEGIN
	DECLARE @FolderOutlineLevel int
	SELECT @FolderOutlineLevel = [OutlineLevel]
		FROM dbo.main_PageTree
		WHERE  [Outline] LIKE @Outline and SiteId = @SiteId
	SELECT [PageId], [Name], [Outline], [OutlineLevel], [IsFolder], [IsDefault], [Order], [IsPublic], isnull([MasterPage], '''') as MasterPage 
		FROM dbo.main_PageTree
		WHERE ([Outline] LIKE @Outline+''%'' AND [IsDefault] = 1)  AND ([OutlineLevel] = @FolderOutlineLevel + 1) and SiteId = @SiteId
END
ELSE
BEGIN
	SELECT [PageId], [Name], [Outline], [OutlineLevel], [IsFolder], [IsDefault], [Order], [IsPublic]
		FROM dbo.main_PageTree
		WHERE ([Outline] LIKE @Outline) and SiteId = @SiteId
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_fs_FileTreeLoadByOutlineAll]    Script Date: 07/21/2009 17:21:38 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_fs_FileTreeLoadByOutlineAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_fs_FileTreeLoadByOutlineAll] 
	@outline nvarchar(2048),
	@SiteId uniqueidentifier
AS
 begin
	SELECT [PageId], [Name], [Outline], [OutlineLevel], [IsFolder], [IsDefault], [Order], [IsPublic] , isnull([MasterPage], '''') as MasterPage 
		FROM dbo.main_PageTree
		WHERE ([Outline] LIKE @Outline) and SiteId = @SiteId
 end' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_fs_FileTreeLoadParent]    Script Date: 07/21/2009 17:21:38 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_fs_FileTreeLoadParent]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_fs_FileTreeLoadParent] 
	@PageId int
AS
DECLARE @FolderOutline nvarchar(2048)
DECLARE @OutlineLevel int
DECLARE @SiteId uniqueidentifier
--get folder outline
SELECT @FolderOutline = [Outline],@OutlineLevel = [OutlineLevel], @SiteId = SiteId
	FROM dbo.main_PageTree
	WHERE [PageId] = @PageId
--get all files in folder
SELECT [PageId], [Name], [Outline], [OutlineLevel], [IsFolder], [IsDefault], [Order], [IsPublic], isnull([MasterPage], '''') as MasterPage, SiteId
	FROM dbo.main_PageTree
	WHERE (@FolderOutline LIKE [Outline] + ''%'')   AND ([OutlineLevel] = @OutlineLevel - 1) and SiteId = @SiteId' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_fs_FileTreeLoadParentAll]    Script Date: 07/21/2009 17:21:39 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_fs_FileTreeLoadParentAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_fs_FileTreeLoadParentAll] 
	@PageId int
AS
DECLARE @FolderOutline nvarchar(2048)
DECLARE @OutlineLevel int
DECLARE @SiteId uniqueidentifier
--get folder outline
SELECT @FolderOutline = [Outline],@OutlineLevel = [OutlineLevel], @SiteId = SiteId
	FROM dbo.main_PageTree
	WHERE [PageId] = @PageId
--get all files in folder
SELECT [PageId], [Name], [Outline], [OutlineLevel], [IsFolder], [IsDefault], [Order], [IsPublic], isnull([MasterPage], '''') as MasterPage, SiteId
	FROM dbo.main_PageTree
	WHERE (@FolderOutline LIKE [Outline] + ''%'') AND SiteId = @SiteId
	ORDER BY [OutlineLevel]' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_fs_FileTreeUpdate]    Script Date: 07/21/2009 17:21:39 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_fs_FileTreeUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_fs_FileTreeUpdate]
	@PageId int,
	@Name nvarchar(250),
	@IsPublic bit,
	@IsFolder bit,
	@IsDefault bit,
	@MasterPage nvarchar(256),
	@SiteId uniqueidentifier
 AS
DECLARE @OutlineOld nvarchar(2048)
DECLARE @OutlineNew nvarchar(2048)
DECLARE @NameOld nvarchar(250)
--get old Outline
SELECT @OutlineOld = [Outline], @NameOld = [Name]
	FROM dbo.main_PageTree
	WHERE [PageId] = @PageId

IF @NameOld <> @Name
BEGIN
--exclude old file name 
	SET @OutlineNew = REVERSE(@OutlineOld)
	PRINT @OutlineNew
	SET @OutlineNew = SUBSTRING(@OutlineNew,2,LEN(@OutlineNew) )
	PRINT @OutlineNew
	SET @OutlineNew = SUBSTRING(@OutlineNew,CHARINDEX(''/'',@OutlineNew) ,LEN(@OutlineNew) - LEN(@NameOld) + 1)
	SET @OutlineNew = REVERSE(@OutlineNew)
	--finish new outline
	SET @OutlineNew = @OutlineNew + @Name
	IF (SELECT [IsFolder] FROM dbo.main_PageTree WHERE [PageId] = @PageId) = 1
		SET @OutlineNew = @OutlineNew + ''/''
	--replace old outline and update
	UPDATE dbo.main_PageTree 
		SET 
		[Name] = @Name,
		[Outline] = REPLACE([Outline],@OutlineOld,@OutlineNew),
		[IsPublic] = @IsPublic,
		[IsDefault] = @IsDefault,
		[MasterPage] = @MasterPage,
		[SiteId] = @SiteId
		WHERE ([PageId] = @PageId) 
	--replace old outline in child outline
	UPDATE dbo.main_PageTree 
		SET [Outline] = REPLACE([Outline],@OutlineOld,@OutlineNew)
		WHERE ([Outline] LIKE @OutlineOld + ''%'') AND [SiteId]=@SiteId
END
ELSE
BEGIN
	UPDATE dbo.main_PageTree 
		SET 
		[Name] = @Name,
		[IsPublic] = @IsPublic,
		[IsDefault] = @IsDefault,
		[MasterPage] = @MasterPage,
		[SiteId] = @SiteId
		WHERE ([PageId] = @PageId)
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_GlobalVariablesAdd]    Script Date: 07/21/2009 17:21:39 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_GlobalVariablesAdd]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [cms_GlobalVariablesAdd]
	@Key nvarchar(250),
	@Value nvarchar(1024),
	@SiteId uniqueidentifier,
	@retval int output
 AS
INSERT INTO [main_GlobalVariables]
	([KEY],[VALUE], SiteId) VALUES (@Key,@Value, @SiteId)
SET @retval = SCOPE_IDENTITY()' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_GlobalVariablesDelete]    Script Date: 07/21/2009 17:21:40 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_GlobalVariablesDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_GlobalVariablesDelete]
	@GlobalVariableId int
 AS
DELETE FROM dbo.main_GlobalVariables
	WHERE [GlobalVariableId] = @GlobalVariableId

' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_GlobalVariablesLoadByKey]    Script Date: 07/21/2009 17:21:40 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_GlobalVariablesLoadByKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_GlobalVariablesLoadByKey]
	@Key nvarchar(250),
	@SiteId uniqueidentifier
 AS
SELECT [GlobalVariableId],[Key],[Value]
	FROM  dbo.main_GlobalVariables
	WHERE [Key] = @Key and SiteId = @SiteId


' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_GlobalVariablesUpdate]    Script Date: 07/21/2009 17:21:40 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_GlobalVariablesUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_GlobalVariablesUpdate]
	@GlobalVariableId int,
	@Key nvarchar(250),
	@SiteId uniqueidentifier,
	@Value nvarchar(1024)
 AS
UPDATE dbo.main_GlobalVariables
	SET
	[Key] = @Key,
	[Value] = @Value,
	[SiteId] = @SiteId
	WHERE [GlobalVariableId] = @GlobalVariableId

' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_LanguageInfo_Add]    Script Date: 07/21/2009 17:21:40 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_LanguageInfo_Add]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [cms_LanguageInfo_Add]
	@LangName varchar(50),
	@FriendlyName varchar(50),
	@IsDefault bit,
	@ApplicationId uniqueidentifier,
	@retval int output
 AS
INSERT INTO [main_LanguageInfo]
	([LangName], [FriendlyName], [IsDefault], [ApplicationId]) VALUES (@LangName, @FriendlyName, @IsDefault, @ApplicationId)
SET @retval = SCOPE_IDENTITY()' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_LanguageInfo_Delete]    Script Date: 07/21/2009 17:21:41 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_LanguageInfo_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
create PROCEDURE [dbo].[cms_LanguageInfo_Delete]
	@LangId int
 AS
DELETE FROM dbo.main_LanguageInfo
	WHERE [LangId] = @LangId

' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_LanguageInfo_GetByLangName]    Script Date: 07/21/2009 17:21:41 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_LanguageInfo_GetByLangName]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_LanguageInfo_GetByLangName] 
	@langName varchar(50),
	@ApplicationId uniqueidentifier
AS
 BEGIN
	SELECT [langId], [langName], [FriendlyName], [IsDefault], ApplicationId
	FROM main_LanguageInfo
	WHERE langName = @langName and ApplicationId = @ApplicationId
 END' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_LanguageInfo_LoadById]    Script Date: 07/21/2009 17:21:41 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_LanguageInfo_LoadById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_LanguageInfo_LoadById] 
	@LangId int
AS
 BEGIN
	SELECT [LangId] as LangId, [LangName] as LangName, [FriendlyName] as FriendlyName, [IsDefault] as IsDefault, ApplicationId
		FROM dbo.main_LanguageInfo
		WHERE @LangId = LangId
 END' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_LanguageInfo_Update]    Script Date: 07/21/2009 17:21:42 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_LanguageInfo_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_LanguageInfo_Update] 
	@LangId as int,
	@LangName as varchar(50),
	@FriendlyName as varchar(50),
	@IsDefault as bit,
	@ApplicationId uniqueidentifier
AS
UPDATE dbo.main_LanguageInfo
	SET LangName = @LangName, FriendlyName = @FriendlyName, IsDefault = @IsDefault, ApplicationId = @ApplicationId
	WHERE LangId = @LangId' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_LanguageInfoLoadAll]    Script Date: 07/21/2009 17:21:42 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_LanguageInfoLoadAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_LanguageInfoLoadAll]
	@ApplicationId uniqueidentifier	
 AS
SELECT [LangId],[LangName], [FriendlyName], [IsDefault], ApplicationId
	FROM dbo.main_LanguageInfo
	where ApplicationId = @ApplicationId' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_menu_LoadById]    Script Date: 07/21/2009 17:21:42 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_menu_LoadById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_menu_LoadById]
	@MenuId int
 AS
SELECT M.* FROM main_Menu M WHERE M.[MenuId] = @MenuId

SELECT I.* FROM main_MenuItem I INNER JOIN main_Menu M ON M.MenuId = I.MenuId WHERE M.[MenuId] = @MenuId

SELECT R.* FROM main_MenuItem_Resources R INNER JOIN main_MenuItem I ON R.MenuItemId = I.MenuItemId INNER JOIN main_Menu M ON M.MenuId = I.MenuId WHERE M.[MenuId] = @MenuId' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_menu_LoadByMenuItemId]    Script Date: 07/21/2009 17:21:43 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_menu_LoadByMenuItemId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_menu_LoadByMenuItemId]
	@MenuItemId int
AS
SELECT M.* FROM main_Menu M 
INNER JOIN main_MenuItem I ON M.[MenuId]=I.[MenuId]
WHERE I.[MenuItemId] = @MenuItemId

SELECT I.* FROM main_MenuItem I WHERE I.[MenuItemId] = @MenuItemId

SELECT R.* FROM main_MenuItem_Resources R 
INNER JOIN main_MenuItem I ON R.MenuItemId = I.MenuItemId 
WHERE I.[MenuItemId] = @MenuItemId' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_menu_LoadBySiteId]    Script Date: 07/21/2009 17:21:43 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_menu_LoadBySiteId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_menu_LoadBySiteId]
	@SiteId uniqueidentifier
 AS

SELECT M.* FROM main_Menu M WHERE M.[SiteId] = @SiteId

SELECT I.* FROM main_MenuItem I INNER JOIN main_Menu M ON M.MenuId = I.MenuId WHERE M.[SiteId] = @SiteId

SELECT R.* FROM main_MenuItem_Resources R INNER JOIN main_MenuItem I ON R.MenuItemId = I.MenuItemId INNER JOIN main_Menu M ON M.MenuId = I.MenuId WHERE M.[SiteId] = @SiteId


' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_menu_MenuAdd]    Script Date: 07/21/2009 17:21:43 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_menu_MenuAdd]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_menu_MenuAdd]
	@FriendlyName nvarchar(250),
	@SiteId uniqueidentifier,
	@retval int output
 AS
	INSERT INTO [main_Menu]
		([FriendlyName], [SiteId]) VALUES (@FriendlyName, @SiteId)
	SET @retval = SCOPE_IDENTITY()
	--add new virtual root to main_MenuItem
	INSERT INTO [main_MenuItem]
		([MenuId], [CommandType], [Text], [Order], [Outline], [OutlineLevel], [IsRoot], [IsVisible], [IsInherits])
	VALUES 
		(@retval, 0, @FriendlyName, 0, ''.'', 0, 1, 0, 0)' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_menu_MenuDelete]    Script Date: 07/21/2009 17:21:43 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_menu_MenuDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_menu_MenuDelete]
	@MenuId int
 AS
DELETE FROM dbo.main_Menu
	WHERE [MenuId] = @MenuId
DELETE FROM dbo.main_MenuItem
	WHERE [MenuId] = @MenuId

' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_menu_MenuGetById]    Script Date: 07/21/2009 17:21:44 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_menu_MenuGetById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_menu_MenuGetById]
	@MenuId int
AS
SELECT [MenuId],[FriendlyName]
	FROM dbo.main_Menu
	WHERE ([MenuId] = @MenuId)' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_menu_MenuGetByName]    Script Date: 07/21/2009 17:21:44 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_menu_MenuGetByName]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_menu_MenuGetByName]
	@FriendlyName nvarchar(250),
	@SiteId uniqueidentifier
 AS
SELECT [MenuId],[FriendlyName]
	FROM dbo.main_Menu
	WHERE ([FriendlyName] = @FriendlyName) AND ([SiteId] = @SiteId)' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_menu_MenuItemGetAllRoot]    Script Date: 07/21/2009 17:21:44 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_menu_MenuItemGetAllRoot]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_menu_MenuItemGetAllRoot]
	@SiteId uniqueidentifier
 AS
SELECT I.[MenuItemId], I.[Text], I.[CommandText], I.[CommandType], I.[Outline], I.[OutlineLevel], I.[IsRoot], I.[IsVisible], I.[MenuId], I.[LeftImageUrl], I.[RightImageUrl], I.[IsInherits], I.[Order], M.[SiteId]
	FROM dbo.main_MenuItem I
	INNER JOIN main_Menu M ON M.MenuId = I.MenuId
	where M.SiteId = @SiteId AND [IsRoot] = 1
	ORDER BY [Order]' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_menu_MenuUpdate]    Script Date: 07/21/2009 17:21:45 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_menu_MenuUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_menu_MenuUpdate]
	@MenuId int,
	@FriendlyName nvarchar(250)
 AS
UPDATE dbo.main_Menu
	SET [FriendlyName] = @FriendlyName
	WHERE [MenuId] = @MenuId
UPDATE dbo.main_MenuItem 
	SET [Text] = @FriendlyName
	WHERE [MenuId] = @MenuId AND [IsRoot] = 1' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_NavigationCommandAll]    Script Date: 07/21/2009 17:21:45 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_NavigationCommandAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [cms_NavigationCommandAll]
	@ApplicationId uniqueidentifier
AS
	SELECT NC.[Id], NC.[UrlUID], NC.[ItemId], NC.[Params], NC.[TrigerParam] FROM [NavigationCommand] NC
	INNER JOIN [NavigationItems] NI ON NC.[ItemId]=NI.[ItemId]	
	WHERE NI.[ApplicationId] = @ApplicationId' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_NavigationCommandDelete]    Script Date: 07/21/2009 17:21:45 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_NavigationCommandDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
create PROCEDURE [dbo].[cms_NavigationCommandDelete]
(
	@Id int
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [NavigationCommand]
	WHERE  
		[Id] = @Id

	RETURN @@Error' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_NavigationCommandInsert]    Script Date: 07/21/2009 17:21:45 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_NavigationCommandInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[cms_NavigationCommandInsert]
(
	@UrlUID nvarchar(256),
	@ItemId int = NULL,
	@Params nvarchar(1024) = NULL,
	@TrigerParam nvarchar(256) = NULL,
	@retval INT OUTPUT
)
AS
	SET NOCOUNT ON

	INSERT INTO [NavigationCommand]
	(
		[UrlUID],
		[ItemId],
		[Params],
		[TrigerParam]
	)
	VALUES
	(
		@UrlUID,
		@ItemId,
		@Params,
		@TrigerParam
	)

	SELECT @retval = SCOPE_IDENTITY();

	RETURN @@Error' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_NavigationCommandSelect]    Script Date: 07/21/2009 17:21:46 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_NavigationCommandSelect]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[cms_NavigationCommandSelect]
(
	@Id int
)
AS
	SET NOCOUNT ON
	
	SELECT 		[Id],
		[UrlUID],
		[ItemId],
		[Params],
		[TrigerParam] FROM [NavigationCommand]
	WHERE 
		[Id] = @Id' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_NavigationCommandSelectByItemId]    Script Date: 07/21/2009 17:21:46 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_NavigationCommandSelectByItemId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[cms_NavigationCommandSelectByItemId]
(
	@ItemId int
)
AS
	SET NOCOUNT ON
	
	SELECT 		[Id],
		[UrlUID],
		[ItemId],
		[Params],
		[TrigerParam] FROM [NavigationCommand]
	WHERE 
		[ItemId] = @ItemId' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_NavigationCommandSelectByPageId]    Script Date: 07/21/2009 17:21:46 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_NavigationCommandSelectByPageId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[cms_NavigationCommandSelectByPageId]
(
	@UrlUID int
)
AS
	SET NOCOUNT ON
	
	SELECT 		[Id],
		[UrlUID],
		[ItemId],
		[Params],
		[TrigerParam] FROM [NavigationCommand]
	WHERE 
		[UrlUID] = @UrlUID' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_NavigationCommandUpdate]    Script Date: 07/21/2009 17:21:47 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_NavigationCommandUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
create PROCEDURE [dbo].[cms_NavigationCommandUpdate]
(
	@Id int,
	@UrlUID nvarchar(256),
	@ItemId int = NULL,
	@Params nvarchar(1024) = NULL,
	@TrigerParam nvarchar(256) = NULL
)
AS
	SET NOCOUNT ON
	
	UPDATE [NavigationCommand]
	SET
		[UrlUID] = @UrlUID,
		[ItemId] = @ItemId,
		[Params] = @Params,
		[TrigerParam] = @TrigerParam
	WHERE 
		[Id] = @Id

	RETURN @@Error' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_NavigationItemsDelete]    Script Date: 07/21/2009 17:21:47 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_NavigationItemsDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
create PROCEDURE [dbo].[cms_NavigationItemsDelete]
(
	@ItemId int
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [NavigationItems]
	WHERE  
		[ItemId] = @ItemId

	RETURN @@Error' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_NavigationItemsInsert]    Script Date: 07/21/2009 17:21:47 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_NavigationItemsInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [cms_NavigationItemsInsert]
(
	@ItemName nvarchar(256) = NULL,
	@ApplicationId uniqueidentifier,
	@retval int = NULL output
)
AS
	SET NOCOUNT ON

	INSERT INTO [NavigationItems]
	(
		[ItemName],
		[ApplicationId]
	)
	VALUES
	(
		@ItemName,
		@ApplicationId
	)

	SELECT @retval = SCOPE_IDENTITY()

	SET NOCOUNT OFF

	RETURN @@Error' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_NavigationItemsSelect]    Script Date: 07/21/2009 17:21:47 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_NavigationItemsSelect]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[cms_NavigationItemsSelect]
(
	@ItemId int
)
AS
	SET NOCOUNT ON
	
	SELECT 		[ItemId],
		[ItemName] FROM [NavigationItems]
	WHERE 
		[ItemId] = @ItemId' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_NavigationItemsSelectAll]    Script Date: 07/21/2009 17:21:48 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_NavigationItemsSelectAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [cms_NavigationItemsSelectAll]
	@ApplicationId uniqueidentifier
AS	
	SELECT [ItemId], [ItemName], [ApplicationId]
	FROM [NavigationItems]
	WHERE [ApplicationId] = @ApplicationId' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_NavigationItemsSelectByName]    Script Date: 07/21/2009 17:21:48 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_NavigationItemsSelectByName]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [cms_NavigationItemsSelectByName]
(
	@ApplicationId uniqueidentifier,
	@ItemName nvarchar(256)
)
AS	
	SELECT [ItemId], [ItemName], [ApplicationId] FROM [NavigationItems]
	WHERE 
		[ApplicationId] = @ApplicationId AND 
		[ItemName] = @ItemName' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_NavigationItemsUpdate]    Script Date: 07/21/2009 17:21:48 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_NavigationItemsUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_NavigationItemsUpdate]
(
	@ItemId int,
	@ItemName nvarchar(256) = NULL
)
AS
	SET NOCOUNT ON
	
	UPDATE [NavigationItems]
	SET
		[ItemName] = @ItemName
	WHERE 
		[ItemId] = @ItemId

	RETURN @@Error' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_NavigationParamsDelete]    Script Date: 07/21/2009 17:21:49 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_NavigationParamsDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_NavigationParamsDelete]
(
	@Id int
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [NavigationParams]
	WHERE  
		[Id] = @Id

	RETURN @@Error' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_NavigationParamsInsert]    Script Date: 07/21/2009 17:21:49 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_NavigationParamsInsert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_NavigationParamsInsert]
(
	@ItemId int,
	@Name nvarchar(256) = NULL,
	@Value nvarchar(256) = NULL,
	@IsRequired bit = NULL,
	@retval int = NULL OUTPUT
)
AS
	SET NOCOUNT ON

	INSERT INTO [NavigationParams]
	(
		[ItemId],
		[Name],
		[Value],
		[IsRequired]
	)
	VALUES
	(
		@ItemId,
		@Name,
		@Value,
		@IsRequired
	)

	SELECT @retval = SCOPE_IDENTITY();

	RETURN @@Error' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_NavigationParamsSelectAll]    Script Date: 07/21/2009 17:21:49 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_NavigationParamsSelectAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [cms_NavigationParamsSelectAll]
	@ApplicationId uniqueidentifier
AS
	SELECT NP.[Id], NP.[ItemId], NP.[Name], NP.[Value], NP.[IsRequired] FROM [NavigationParams] NP
	INNER JOIN [NavigationItems] NI ON NP.[ItemId]=NI.[ItemId]	
	WHERE NI.[ApplicationId] = @ApplicationId' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_NavigationParamsSelectByItemId]    Script Date: 07/21/2009 17:21:50 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_NavigationParamsSelectByItemId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_NavigationParamsSelectByItemId]
(
	@ItemId int
)
AS
	SET NOCOUNT ON
	
	SELECT 		[Id],
		[ItemId],
		[Name],
		[Value],
		[IsRequired] FROM [NavigationParams]
	WHERE 
		[ItemId] = @ItemId' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_NavigationParamsUpdate]    Script Date: 07/21/2009 17:21:50 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_NavigationParamsUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_NavigationParamsUpdate]
(
	@Id int,
	@ItemId int,
	@Name nvarchar(256) = NULL,
	@Value nvarchar(256) = NULL,
	@IsRequired bit = NULL
)
AS
	SET NOCOUNT ON
	
	UPDATE [NavigationParams]
	SET
		[ItemId] = @ItemId,
		[Name] = @Name,
		[Value] = @Value,
		[IsRequired] = @IsRequired
	WHERE 
		[Id] = @Id

	RETURN @@Error' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_page_PageVersionGetByUserId2]    Script Date: 07/21/2009 17:21:50 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_page_PageVersionGetByUserId2]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_page_PageVersionGetByUserId2] 
	@ApplicationId uniqueidentifier,
	@UserId uniqueidentifier,
	@RoleNames nvarchar(1000)
AS
BEGIN
SELECT  PV.[VersionId], PV.[TemplateId], PV.[VersionNum], PV.[LangId], PV.[StatusId], PV.[Created], PV.[CreatorUID], PV.[Edited], PV.[EditorUID], PV.[StateId], PV.[Comment], PV.[PageId], P.SiteId
	FROM main_PageVersion PV
		INNER JOIN main_PageTree P ON PV.PageId = P.PageId
		INNER JOIN [Site] S ON P.SiteId = S.SiteId 
	WHERE
		S.ApplicationId = @ApplicationId AND 
		PV.StatusId IN (
			SELECT StatusId FROM WorkflowStatusAccess
				WHERE 
					RoleId IN (SELECT Item from cms_splitlist(@RoleNames)) OR
					RoleID = N''Everyone''
			)
UNION	 		 
SELECT  PV.[VersionId], PV.[TemplateId], PV.[VersionNum], PV.[LangId], PV.[StatusId], PV.[Created], PV.[CreatorUID], PV.[Edited], PV.[EditorUID], PV.[StateId], PV.[Comment], PV.[PageId], P.SiteId
		FROM main_PageVersion PV
		INNER JOIN main_PageTree P ON PV.PageId = P.PageId
		INNER JOIN [Site] S ON P.SiteId = S.SiteId
	WHERE 
		S.ApplicationId = @ApplicationId AND
		PV.CreatorUID = @UserId  AND PV.StatusId = -1
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_PageStateGetAll]    Script Date: 07/21/2009 17:21:50 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_PageStateGetAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [cms_PageStateGetAll]
	@ApplicationId uniqueidentifier
AS
	SELECT [StateId], [FriendlyName] FROM [main_PageState] 
	WHERE [ApplicationId] = @ApplicationId' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_PageStateGetById]    Script Date: 07/21/2009 17:21:51 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_PageStateGetById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_PageStateGetById]
	@StateId INT
AS
 BEGIN
	SELECT [StateId], [FriendlyName] FROM [main_PageState]
	WHERE [StateId] = @StateId
 END' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_Site]    Script Date: 07/21/2009 17:21:51 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_Site]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_Site]
    @ApplicationId uniqueidentifier,
	@SiteId uniqueidentifier = null,
	@ReturnInactive bit = 0
AS
BEGIN
	if(LEN(@SiteId) = 0)
		set @SiteId = null

	SELECT S.* from [Site] S
	WHERE
		S.ApplicationId = @ApplicationId AND
		(S.IsActive = 1 or @ReturnInactive = 1) AND 
		S.SiteId = COALESCE(@SiteId, S.SiteId)

	SELECT G.* from [main_GlobalVariables] G
		INNER JOIN [Site] S ON G.SiteId = S.SiteId
	WHERE
		S.ApplicationId = @ApplicationId AND
		(S.IsActive = 1 or @ReturnInactive = 1) AND 
		S.SiteId = COALESCE(@SiteId, S.SiteId)

	SELECT L.* from [SiteLanguage] L
		INNER JOIN [Site] S ON L.SiteId = S.SiteId
	WHERE
		S.ApplicationId = @ApplicationId AND 
		(S.IsActive = 1 or @ReturnInactive = 1) AND 
		S.SiteId = COALESCE(@SiteId, S.SiteId)
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_TemplatesLoadById]    Script Date: 07/21/2009 17:21:51 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_TemplatesLoadById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create PROCEDURE [dbo].[cms_TemplatesLoadById]
	@ApplicationId uniqueidentifier,
	@TemplateId int
 AS
SELECT *
	FROM dbo.main_Templates
	WHERE (([TemplateId] = @TemplateId) OR (@TemplateId = 0)) and ApplicationId = @ApplicationId

' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_Workflow_Add]    Script Date: 07/21/2009 17:21:52 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_Workflow_Add]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [cms_Workflow_Add] 
	@FriendlyName nvarchar(250),
	@IsDefault bit,
	@ApplicationId uniqueidentifier,
	@retval int output
AS
BEGIN
	INSERT INTO [Workflow] (FriendlyName, IsDefault, ApplicationId)
	VALUES (@FriendlyName, @IsDefault, @ApplicationId)
	SET @retval = SCOPE_IDENTITY()
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_Workflow_Delete]    Script Date: 07/21/2009 17:21:52 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_Workflow_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create PROCEDURE [dbo].[cms_WorkFlow_Delete] 
	@WorkFlowId INT
AS
 BEGIN
--dodelat
	DELETE FROM WorkFlow WHERE [WorkFlowId] = @WorkFlowId
 END' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_Workflow_GetAll]    Script Date: 07/21/2009 17:21:52 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_Workflow_GetAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_WorkFlow_GetAll] 
	@ApplicationId uniqueidentifier
AS
 begin
	SELECT [WorkFlowId] as WorkFlowId,
		 [FriendlyName] as FriendlyName,
		 [IsDefault] as IsDefault
	FROM dbo.[WorkFlow]
	WHERE ApplicationId = @ApplicationId
 end' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_Workflow_GetById]    Script Date: 07/21/2009 17:21:52 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_Workflow_GetById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_WorkFlow_GetById] 
	@WorkFlowId INT
AS
 BEGIN
	SELECT [WorkFlowId] as WorkFlowId, [FriendlyName] as FriendlyName, [IsDefault] as IsDefault
	FROM dbo.[WorkFlow]
	WHERE [WorkFlowId] = @WorkFlowId
 END' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_Workflow_GetDefault]    Script Date: 07/21/2009 17:21:53 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_Workflow_GetDefault]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create PROCEDURE [dbo].[cms_WorkFlow_GetDefault]
	@ApplicationId uniqueidentifier
AS
 BEGIN
	SELECT [WorkFlowId] as WorkFlowId, [FriendlyName] as FriendlyName, [IsDefault] as IsDefault
	FROM dbo.[WorkFlow]
	WHERE [IsDefault] = 1 AND ApplicationId = @ApplicationId
 END' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_Workflow_Update]    Script Date: 07/21/2009 17:21:53 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_Workflow_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create PROCEDURE [dbo].[cms_WorkFlow_Update]
	@WorkFlowId INT,
	@FriendlyName NVARCHAR(250),
	@IsDefault BIT,
	@ApplicationId uniqueidentifier
AS
 BEGIN
	UPDATE [WorkFlow] SET
		[FriendlyName] = @FriendlyName,
		[IsDefault] = @IsDefault,
		ApplicationId = @ApplicationId
	WHERE [WorkFlowId] = @WorkFlowId
 END' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_WorkflowStatus_Add]    Script Date: 07/21/2009 17:21:53 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_WorkflowStatus_Add]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [cms_WorkflowStatus_Add]
	@WorkflowId int,
	@Weight int,
	@FriendlyName nvarchar(250),
	@retval int output
AS
BEGIN
	INSERT INTO [WorkflowStatus] ([WorkflowId], [Weight], [FriendlyName])
	VALUES (@WorkflowId, @Weight, @FriendlyName)
	SET @retval = SCOPE_IDENTITY()
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_WorkflowStatus_Delete]    Script Date: 07/21/2009 17:21:54 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_WorkflowStatus_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_WorkFlowStatus_Delete]
	@StatusId INT
AS
 BEGIN
	DELETE FROM [WorkFlowStatusAccess] WHERE [StatusId] =@StatusId
	DELETE FROM [WorkFlowStatus] WHERE [StatusId] = @StatusId
 END
' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_WorkflowStatus_GetAll]    Script Date: 07/21/2009 17:21:54 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_WorkflowStatus_GetAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_WorkFlowStatus_GetAll] 
	@ApplicationId uniqueidentifier
AS
 BEGIN
	SELECT WS.[StatusId] as StatusId,
		 WS.[WorkFlowId] as WorkFlowId,
		 WS.[Weight] as Weight,
		 WS.[FriendlyName] as FriendlyName
	FROM [WorkFlowStatus] WS INNER JOIN Workflow W ON WS.WorkflowId = W.WorkflowId
	WHERE ApplicationId = @ApplicationId
 END' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_WorkflowStatus_GetArcStatus]    Script Date: 07/21/2009 17:21:54 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_WorkflowStatus_GetArcStatus]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_WorkFlowStatus_GetArcStatus] 
	@StatusId INT,
	@ApplicationId uniqueidentifier,
	@retval INT OUTPUT
AS
 BEGIN
	DECLARE @WorkFlowId INT
	--GA
	SELECT @WorkFlowId = [WorkFlowId] FROM [WorkFlow] WHERE [IsDefault] = 1 AND ApplicationId = @ApplicationId
	IF @StatusId != 0 
	BEGIN
		SELECT @WorkFlowId = [WorkFlowId] FROM  [WorkFlowStatus]
			WHERE [StatusId] = @StatusId
	END
		SELECT @retval = [StatusId]  FROM [WorkFlowStatus]
			WHERE [Weight] = -1 and [WorkFlowId] = @WorkFlowId
	
 END
' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_WorkflowStatus_GetById]    Script Date: 07/21/2009 17:21:54 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_WorkflowStatus_GetById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_WorkFlowStatus_GetById]
	@StatusId INT,
	@ApplicationId uniqueidentifier
AS
 BEGIN
	SELECT WS.[StatusId] as StatusId,
		 WS.[WorkFlowId] as WorkFlowId,
		 WS.[Weight] as Weight,
		 WS.[FriendlyName] as FriendlyName
	FROM [WorkFlowStatus] WS INNER JOIN Workflow W ON WS.WorkflowId = W.WorkflowId
	WHERE ApplicationId = @ApplicationId AND [StatusId] = @StatusId
 END
' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_WorkflowStatus_GetByWorkflowId]    Script Date: 07/21/2009 17:21:55 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_WorkflowStatus_GetByWorkflowId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_WorkFlowStatus_GetByWorkflowId]
	@WorkFlowId INT
AS
 BEGIN
	SELECT [StatusId] as StatusId,
		 [WorkFlowId] as WorkFlowId,
		 [Weight] as Weight,
		 [FriendlyName] as FriendlyName
	FROM WorkFlowStatus
	WHERE [WorkFlowId] = @WorkFlowId
	ORDER BY Weight ASC
 END
' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_WorkflowStatus_GetDraftStatus]    Script Date: 07/21/2009 17:21:55 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_WorkflowStatus_GetDraftStatus]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_WorkFlowStatus_GetDraftStatus] 
	@ApplicationId uniqueidentifier,
	@retval INT OUTPUT
AS
 BEGIN
	DECLARE @WorkFlowId INT

	SELECT @WorkFlowId = [WorkFlowId] FROM [WorkFlow] WHERE [IsDefault] = 1 AND ApplicationId = @ApplicationId
	SELECT @retval = MIN(StatusId) FROM [WorkFlowStatus]
			WHERE [Weight] > -1 and [WorkFlowId] = @WorkFlowId	

	IF @retval IS NULL
		SET @retval = -1
 END' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_WorkflowStatus_Update]    Script Date: 07/21/2009 17:21:55 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_WorkflowStatus_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[cms_WorkFlowStatus_Update] 
	@StatusId INT,
	@WorkFlowId INT,
	@Weight INT,
	@FriendlyName NVARCHAR(250)
AS
 BEGIN
	UPDATE [WorkFlowStatus] SET
		[WorkFlowId] = @WorkFlowId,
		[Weight] = @Weight,
		[FriendlyName] = @FriendlyName
	WHERE StatusId = @StatusId
	
 END
' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_WorkflowStatusAccess_Add]    Script Date: 07/21/2009 17:21:56 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_WorkflowStatusAccess_Add]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [cms_WorkflowStatusAccess_Add]
	@StatusId int,
	@RoleId nvarchar(256),
	@retval int output
AS
BEGIN
	INSERT INTO [WorkflowStatusAccess] (StatusId, RoleId)
	VALUES (@StatusId, @RoleId)
	SET @retval = SCOPE_IDENTITY()
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_WorkflowStatusAccess_Delete]    Script Date: 07/21/2009 17:21:56 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_WorkflowStatusAccess_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [cms_WorkflowStatusAccess_Delete] 
	@StatusAccessId int
AS
BEGIN
	DELETE FROM [WorkflowStatusAccess] WHERE [StatusAccessId] = @StatusAccessId
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_WorkflowStatusAccess_GetAll]    Script Date: 07/21/2009 17:21:56 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_WorkflowStatusAccess_GetAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [cms_WorkflowStatusAccess_GetAll] 
	@ApplicationId uniqueidentifier
AS
BEGIN
	SELECT WSA.[StatusAccessId], WSA.[StatusId], WSA.[RoleId] FROM [WorkflowStatusAccess] WSA
	INNER JOIN [WorkflowStatus] WS ON WS.[StatusId] = WSA.[StatusId]
	INNER JOIN [Workflow] W ON W.[WorkflowId] = WS.[WorkflowId]
		WHERE W.[ApplicationId] = @ApplicationId
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_WorkflowStatusAccess_GetById]    Script Date: 07/21/2009 17:21:56 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_WorkflowStatusAccess_GetById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [cms_WorkflowStatusAccess_GetById]
	@StatusAccessId int
AS
BEGIN
	SELECT [StatusAccessId], [StatusId], [RoleId] FROM [WorkflowStatusAccess]
		WHERE [StatusAccessId] = @StatusAccessId
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_WorkflowStatusAccess_GetByRoleId]    Script Date: 07/21/2009 17:21:57 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_WorkflowStatusAccess_GetByRoleId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [cms_WorkflowStatusAccess_GetByRoleId]
	@ApplicationId uniqueidentifier, 
	@RoleId nvarchar(256),
	@EveryoneRoleId nvarchar(256)
AS
BEGIN
	SELECT WSA.[StatusAccessId], WSA.[StatusId], WSA.[RoleId] FROM [WorkflowStatusAccess] WSA 
	INNER JOIN [WorkflowStatus] WS ON WS.[StatusId] = WSA.[StatusId]
	INNER JOIN [Workflow] W ON W.[WorkflowId] = WS.[WorkflowId]
	WHERE W.[ApplicationId] = @ApplicationId and 
		([RoleId] = @RoleId or [RoleId] = @EveryoneRoleId /* Everyone */)
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_WorkflowStatusAccess_GetByRoleIdStatusId]    Script Date: 07/21/2009 17:21:57 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_WorkflowStatusAccess_GetByRoleIdStatusId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [cms_WorkflowStatusAccess_GetByRoleIdStatusId] 
	@ApplicationId uniqueidentifier,
	@RoleId nvarchar(256),
	@StatusId int,
	@EveryoneRoleId nvarchar(256)
AS
BEGIN
	SELECT WSA.[StatusAccessId], WSA.[StatusId], WSA.[RoleId] FROM [WorkflowStatusAccess] WSA 
	INNER JOIN [WorkflowStatus] WS ON WS.[StatusId] = WSA.[StatusId]
	INNER JOIN [Workflow] W ON W.[WorkflowId] = WS.[WorkflowId]
	WHERE W.[ApplicationId] = @ApplicationId and 
		([RoleId] = @RoleId or [RoleId] = @EveryoneRoleId /*Everyone*/) and 
		WSA.[StatusId] = @StatusId
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_WorkflowStatusAccess_GetByRoleIdStatusIdNotEveryone]    Script Date: 07/21/2009 17:21:57 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_WorkflowStatusAccess_GetByRoleIdStatusIdNotEveryone]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [cms_WorkflowStatusAccess_GetByRoleIdStatusIdNotEveryone] 
	@ApplicationId uniqueidentifier,
	@RoleId nvarchar(256),
	@StatusId int
AS
BEGIN
	SELECT WSA.[StatusAccessId], WSA.[StatusId], WSA.[RoleId] FROM [WorkflowStatusAccess] WSA 
	INNER JOIN [WorkflowStatus] WS ON WS.[StatusId] = WSA.[StatusId]
	INNER JOIN [Workflow] W ON W.[WorkflowId] = WS.[WorkflowId]
	WHERE W.[ApplicationId] = @ApplicationId and 
		 WSA.[RoleId] = @RoleId and WSA.[StatusId] = @StatusId
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_WorkflowStatusAccess_GetByStatusId]    Script Date: 07/21/2009 17:21:58 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_WorkflowStatusAccess_GetByStatusId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [cms_WorkflowStatusAccess_GetByStatusId] 
	@ApplicationId uniqueidentifier,
	@StatusId int
AS
BEGIN
	SELECT WSA.[StatusAccessId], WSA.[StatusId], WSA.[RoleId] FROM [WorkflowStatusAccess] WSA 
	INNER JOIN [WorkflowStatus] WS ON WS.[StatusId] = WSA.[StatusId]
	INNER JOIN [Workflow] W ON W.[WorkflowId] = WS.[WorkflowId]
	WHERE W.[ApplicationId] = @ApplicationId and 
		WSA.[StatusId] = @StatusId
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_WorkflowStatusAccess_GetNextStatus]    Script Date: 07/21/2009 17:21:58 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_WorkflowStatusAccess_GetNextStatus]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [cms_WorkflowStatusAccess_GetNextStatus] 
	@ApplicationId uniqueidentifier,
	@StatusId int
AS
BEGIN
	declare @nextStatusWeight int
	declare @Weight int
	declare @wfId int

	IF @StatusId = -1
		BEGIN		
			SET @Weight = -1
			SELECT @wfId = [WorkFlowId] FROM [Workflow] 
				WHERE [ApplicationId] = @ApplicationId and [IsDefault] = 1
		END
	ELSE
		SELECT @Weight = WS.[Weight], @wfId = WS.[WorkflowId] FROM [WorkflowStatus] WS
		INNER JOIN [Workflow] W ON WS.[WorkflowId] = W.[WorkflowId]
			WHERE W.[ApplicationId] = @ApplicationId and WS.[StatusId] = @StatusId

	SELECT @nextStatusWeight = ISNULL(MIN([Weight]), -1) FROM [WorkflowStatus] WS 
	INNER JOIN [Workflow] W ON WS.[WorkflowId] = W.[WorkflowId]
		WHERE W.[ApplicationId] = @ApplicationId and WS.[Weight] > @Weight
	
	SELECT ISNULL(WS.[StatusId], -1) StatusId, RoleId FROM [WorkflowStatus] WS 
	INNER JOIN [WorkflowStatusAccess] A ON WS.[StatusId] = A.[StatusId]
	INNER JOIN [Workflow] W ON WS.[WorkflowId] = W.[WorkflowId]
		WHERE W.[ApplicationId] = @ApplicationId and 
			WS.[Weight] = @nextStatusWeight and WS.[WorkflowId] = @wfId
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_WorkflowStatusAccess_GetPrevStatus]    Script Date: 07/21/2009 17:21:58 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_WorkflowStatusAccess_GetPrevStatus]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [cms_WorkflowStatusAccess_GetPrevStatus] 
	@ApplicationId uniqueidentifier,
	@StatusId int
AS
BEGIN
	declare @prevStatusWeight int
	declare @Weight int
	declare @wfId int

	IF @StatusId = -1 
		RETURN

	SELECT @Weight = [Weight], @wfId = WS.[WorkflowId] FROM [WorkflowStatus] WS
	INNER JOIN [Workflow] W ON WS.[WorkflowId] = W.[WorkflowId]
		WHERE W.[ApplicationId] = @ApplicationId and [StatusId] = @StatusId

	SELECT @prevStatusWeight = ISNULL(MAX(WS.[Weight]), -1) FROM [WorkflowStatus] WS
	INNER JOIN [Workflow] W ON WS.[WorkflowId] = W.[WorkflowId]
	WHERE W.[ApplicationId] = @ApplicationId and WS.[Weight] < @Weight and WS.[Weight] > -1

	IF @prevStatusWeight = -1
		RETURN
	
	SELECT ISNULL(WS.[StatusId], -1) StatusId, A.[RoleId] FROM [WorkflowStatus] WS 
	INNER JOIN [WorkflowStatusAccess] A ON WS.[StatusId] = A.[StatusId]
	INNER JOIN [Workflow] W ON WS.[WorkflowId] = W.[WorkflowId]
	WHERE W.[ApplicationId] = @ApplicationId and 
		WS.[Weight] = @prevStatusWeight and WS.[WorkFlowId] = @wfId
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[cms_WorkflowStatusAccess_Update]    Script Date: 07/21/2009 17:21:59 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_WorkflowStatusAccess_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [cms_WorkflowStatusAccess_Update] 
	@StatusAccessId int,
	@StatusId int,
	@RoleId nvarchar(256)
AS
BEGIN
	UPDATE [WorkflowStatusAccess] 
	SET
		[StatusId] = @StatusId,
		[RoleId] = @RoleId
	WHERE [StatusAccessId] = @StatusAccessId
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[dps_Control_Add]    Script Date: 07/21/2009 17:21:59 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_Control_Add]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[dps_Control_Add]
	@NodeId as int,
	@ControlUID as nvarchar(255),
	@retval int output
AS
INSERT INTO dps_Control (NodeId, ControlUID) VALUES (@NodeId, @ControlUID)
select @retval = @@identity' 
END
GO

/****** Object:  StoredProcedure [dbo].[dps_Control_Delete]    Script Date: 07/21/2009 17:21:59 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_Control_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[dps_Control_Delete]
	@ControlId as int
AS
DELETE FROM dps_Control WHERE (ControlId = @ControlId)' 
END
GO

/****** Object:  StoredProcedure [dbo].[dps_Control_GetById]    Script Date: 07/21/2009 17:21:59 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_Control_GetById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[dps_Control_GetById]
	@ControlId as int
AS
SELECT ControlId, NodeId, ControlUID FROM dps_Control WHERE ControlId = @ControlId' 
END
GO

/****** Object:  StoredProcedure [dbo].[dps_Control_GetByNodeId]    Script Date: 07/21/2009 17:22:00 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_Control_GetByNodeId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[dps_Control_GetByNodeId]
	@NodeId as int
AS
SELECT ControlId, NodeId, ControlUID FROM dps_Control WHERE (NodeId = @NodeId)' 
END
GO

/****** Object:  StoredProcedure [dbo].[dps_Control_GetByUID]    Script Date: 07/21/2009 17:22:00 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_Control_GetByUID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[dps_Control_GetByUID]
	@ControlUID as nvarchar(255)
AS
SELECT ControlId, NodeId, ControlUID FROM dps_Control WHERE (ControlUID = @ControlUID)' 
END
GO

/****** Object:  StoredProcedure [dbo].[dps_Control_Update]    Script Date: 07/21/2009 17:22:00 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_Control_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[dps_Control_Update]
	@ControlId as int,
	@NodeId as int,
	@ControlUID as nvarchar(255)
	
AS
UPDATE dps_Control SET NodeId = @NodeId, ControlUID = @ControlUID WHERE (ControlId = @ControlId)' 
END
GO

/****** Object:  StoredProcedure [dbo].[dps_ControlSettings_GetByControlId]    Script Date: 07/21/2009 17:22:00 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_ControlSettings_GetByControlId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[dps_ControlSettings_GetByControlId]
	@ControlId as int
AS
SELECT ControlStorageId, [Key], [Value]
FROM dps_ControlStorage WHERE ControlId = @ControlId' 
END
GO

/****** Object:  StoredProcedure [dbo].[dps_ControlSettings_GetByKeyAndControlId]    Script Date: 07/21/2009 17:22:01 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_ControlSettings_GetByKeyAndControlId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[dps_ControlSettings_GetByKeyAndControlId]
	@Key as nvarchar(255),
	@ControlId as int
AS
SELECT ControlStorageId, [Key], [Value] FROM dps_ControlStorage WHERE ControlId = @ControlId AND [Key] = @Key' 
END
GO

/****** Object:  StoredProcedure [dbo].[dps_ControlStorage_Add]    Script Date: 07/21/2009 17:22:01 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_ControlStorage_Add]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[dps_ControlStorage_Add]
	@ControlId as int,
	@Key as nvarchar(255),
	@Value as image,
	@retval int output
AS
INSERT INTO dps_ControlStorage (ControlId, [Key], [Value]) VALUES (@ControlId, @Key, @Value)
select @retval = @@identity' 
END
GO

/****** Object:  StoredProcedure [dbo].[dps_ControlStorage_Delete]    Script Date: 07/21/2009 17:22:01 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_ControlStorage_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[dps_ControlStorage_Delete]
	@ControlStorageId as int
AS
DELETE FROM dps_ControlStorage WHERE (ControlStorageId = @ControlStorageId)' 
END
GO

/****** Object:  StoredProcedure [dbo].[dps_ControlStorage_GetByControlId]    Script Date: 07/21/2009 17:22:02 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_ControlStorage_GetByControlId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[dps_ControlStorage_GetByControlId]
	@ControlId as int
AS
SELECT ControlStorageId, ControlId, [Key], [Value] FROM dps_ControlStorage WHERE ControlId = @ControlId' 
END
GO

/****** Object:  StoredProcedure [dbo].[dps_ControlStorage_GetById]    Script Date: 07/21/2009 17:22:02 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_ControlStorage_GetById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[dps_ControlStorage_GetById]
	@ControlStorageId as int
AS
SELECT ControlStorageId, ControlId, [Key], [Value] FROM dps_ControlStorage WHERE ControlStorageId = @ControlStorageId' 
END
GO

/****** Object:  StoredProcedure [dbo].[dps_ControlStorage_Update]    Script Date: 07/21/2009 17:22:02 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_ControlStorage_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[dps_ControlStorage_Update]
	@ControlStorageId as int,
	@ControlId as int,
	@Key as nvarchar(255),
	@Value as image

AS
UPDATE dps_ControlStorage SET ControlId = @ControlId, [Key] = @Key, [Value] = @Value WHERE (ControlStorageId = @ControlStorageId)' 
END
GO

/****** Object:  StoredProcedure [dbo].[dps_Node_Add]    Script Date: 07/21/2009 17:22:03 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_Node_Add]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[dps_Node_Add]
	@PageId as int,
	@NodeTypeId as int,
	@NodeUID as nvarchar(255),
	@FactoryUID as nvarchar(255),
	@FactoryControlUID as nvarchar(255),
	@ControlPlaceId as nvarchar(255),
	@ControlPlaceIndex as int,
	@retval int output
AS
INSERT INTO dps_Node (PageId, NodeTypeId, NodeUID, FactoryUID, FactoryControlUID, ControlPlaceId, ControlPlaceIndex) VALUES (@PageId, @NodeTypeId, @NodeUID, @FactoryUID, @FactoryControlUID, @ControlPlaceId, @ControlPlaceIndex)
select @retval = @@identity' 
END
GO

/****** Object:  StoredProcedure [dbo].[dps_Node_Delete]    Script Date: 07/21/2009 17:22:03 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_Node_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[dps_Node_Delete]
	@NodeId as int
AS
DELETE FROM dps_Node WHERE (NodeId = @NodeId)' 
END
GO

/****** Object:  StoredProcedure [dbo].[dps_Node_GetByControlPlaceId]    Script Date: 07/21/2009 17:22:03 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_Node_GetByControlPlaceId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[dps_Node_GetByControlPlaceId]
	@ControlPlaceId as nvarchar(255)
AS
SELECT NodeId, PageId, NodeTypeId, NodeUID, FactoryUID, FactoryControlUID, ControlPlaceId, ControlPlaceIndex 
FROM dps_Node WHERE ControlPlaceId = @ControlPlaceId
ORDER BY ControlPlaceIndex' 
END
GO

/****** Object:  StoredProcedure [dbo].[dps_Node_GetById]    Script Date: 07/21/2009 17:22:03 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_Node_GetById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[dps_Node_GetById]
	@NodeId as int
AS
SELECT NodeId, PageId, NodeTypeId, NodeUID, FactoryUID, FactoryControlUID, ControlPlaceId, ControlPlaceIndex 
FROM dps_Node WHERE NodeId = @NodeId
ORDER BY ControlPlaceIndex' 
END
GO

/****** Object:  StoredProcedure [dbo].[dps_Node_GetByPageId]    Script Date: 07/21/2009 17:22:04 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_Node_GetByPageId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[dps_Node_GetByPageId]
	@PageId as int
AS
SELECT NodeId, PageId, NodeTypeId, NodeUID, FactoryUID, FactoryControlUID, ControlPlaceId, ControlPlaceIndex 
FROM dps_Node WHERE PageId = @PageId
ORDER BY ControlPlaceIndex' 
END
GO

/****** Object:  StoredProcedure [dbo].[dps_Node_GetByUID]    Script Date: 07/21/2009 17:22:04 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_Node_GetByUID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[dps_Node_GetByUID]
	@NodeUID as nvarchar(255),
	@PageID as int
AS
SELECT NodeId, PageId, NodeTypeId, NodeUID, FactoryUID, FactoryControlUID, ControlPlaceId, ControlPlaceIndex 
FROM dps_Node WHERE ((NodeUID = @NodeUID)and(PageId=@PageId))
ORDER BY ControlPlaceIndex' 
END
GO

/****** Object:  StoredProcedure [dbo].[dps_Node_Update]    Script Date: 07/21/2009 17:22:04 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_Node_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[dps_Node_Update]
	@NodeId as int,
	@PageId as int,
	@NodeTypeId as int,
	@NodeUID as nvarchar(255),
	@FactoryUID as nvarchar(255),
	@FactoryControlUID as nvarchar(255),
	@ControlPlaceId as nvarchar(255),
	@ControlPlaceIndex as int
	
AS
UPDATE dps_Node SET PageId = @PageId, NodeTypeId = @NodeTypeId, NodeUID = @NodeUID, FactoryUID = @FactoryUID, FactoryControlUID = @FactoryControlUID, ControlPlaceId = @ControlPlaceId, ControlPlaceIndex = @ControlPlaceIndex 
WHERE (NodeId = @NodeId)' 
END
GO

/****** Object:  StoredProcedure [dbo].[dps_NodeType_Add]    Script Date: 07/21/2009 17:22:05 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_NodeType_Add]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[dps_NodeType_Add]
	@TypeName as nvarchar(255),
	@retval int output
AS
INSERT INTO dps_NodeType (TypeName) VALUES (@TypeName)
select @retval = @@identity' 
END
GO

/****** Object:  StoredProcedure [dbo].[dps_NodeType_Delete]    Script Date: 07/21/2009 17:22:05 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_NodeType_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[dps_NodeType_Delete]
	@NodeTypeId as int
AS
DELETE FROM dps_NodeType WHERE (NodeTypeId = @NodeTypeId)' 
END
GO

/****** Object:  StoredProcedure [dbo].[dps_NodeType_GetById]    Script Date: 07/21/2009 17:22:05 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_NodeType_GetById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[dps_NodeType_GetById]
	@NodeTypeId as int
AS
SELECT NodeTypeId, TypeName FROM dps_NodeType WHERE NodeTypeId = @NodeTypeId' 
END
GO

/****** Object:  StoredProcedure [dbo].[dps_NodeType_Update]    Script Date: 07/21/2009 17:22:05 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_NodeType_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[dps_NodeType_Update]
	@NodeTypeId as int,
	@TypeName as nvarchar(255)
	
AS
UPDATE dps_NodeType SET TypeName = @TypeName WHERE (NodeTypeId = @NodeTypeId)' 
END
GO

/****** Object:  StoredProcedure [dbo].[dps_PageDocument_Add]    Script Date: 07/21/2009 17:22:06 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_PageDocument_Add]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[dps_PageDocument_Add]
	@PageVersionId as int,
	@retval int output
AS
INSERT INTO dps_PageDocument ( PageVersionId) VALUES ( @PageVersionId)
select @retval = @@identity' 
END
GO

/****** Object:  StoredProcedure [dbo].[dps_PageDocument_Delete]    Script Date: 07/21/2009 17:22:06 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_PageDocument_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[dps_PageDocument_Delete]
	@PageId as int
AS
DELETE FROM dps_PageDocument WHERE (PageId = @PageId)' 
END
GO

/****** Object:  StoredProcedure [dbo].[dps_PageDocument_GetById]    Script Date: 07/21/2009 17:22:06 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_PageDocument_GetById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[dps_PageDocument_GetById]
	@PageId as int
AS
SELECT PageId, PageVersionId FROM dps_PageDocument WHERE PageId = @PageId' 
END
GO

/****** Object:  StoredProcedure [dbo].[dps_PageDocument_GetByPageVersionId]    Script Date: 07/21/2009 17:22:07 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_PageDocument_GetByPageVersionId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[dps_PageDocument_GetByPageVersionId]
	@PageVersionId as int
AS
SELECT PageId, PageVersionId FROM dps_PageDocument WHERE PageVersionId = @PageVersionId' 
END
GO

/****** Object:  StoredProcedure [dbo].[dps_PageDocument_Update]    Script Date: 07/21/2009 17:22:07 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_PageDocument_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[dps_PageDocument_Update]
	@PageId as int,
	@PageVersionId as int	
AS
UPDATE dps_PageDocument SET PageVersionId = @PageVersionId WHERE (PageId = @PageId)' 
END
GO

/****** Object:  StoredProcedure [dbo].[dps_TemporaryStorage_Add]    Script Date: 07/21/2009 17:22:07 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_TemporaryStorage_Add]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[dps_TemporaryStorage_Add]
	@PageVersionId as int,
	@Expire as int,
	@PageDocument as image,
	@CreatorUID as uniqueidentifier,
	@retval int output
AS
BEGIN
    declare @utcnow datetime = GETUTCDATE()
    DELETE FROM dps_TemporaryStorage 
    WHERE DATEADD(mi, Expire, Created) < @utcnow

    INSERT INTO dps_TemporaryStorage (PageVersionId, Created, Expire, PageDocument, CreatorUID)
    VALUES (@PageVersionId, @utcnow, @Expire, @PageDocument, @CreatorUID)

    select @retval = @@identity
END'
END
GO

/****** Object:  StoredProcedure [dbo].[dps_TemporaryStorage_Delete]    Script Date: 07/21/2009 17:22:07 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_TemporaryStorage_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[dps_TemporaryStorage_Delete]
	@StorageId as int
AS
DELETE FROM dps_TemporaryStorage WHERE (StorageId = @StorageId)' 
END
GO

/****** Object:  StoredProcedure [dbo].[dps_TemporaryStorage_GetById]    Script Date: 07/21/2009 17:22:08 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_TemporaryStorage_GetById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[dps_TemporaryStorage_GetById]
	@StorageId as int
AS
BEGIN
    DELETE FROM dps_TemporaryStorage
    WHERE DATEADD(mi, Expire, Created) < GETUTCDATE()

    SELECT StorageId, PageVersionId, Created, Expire, PageDocument, CreatorUID 
    FROM dps_TemporaryStorage 
    WHERE StorageId = @StorageId
END'
END
GO

/****** Object:  StoredProcedure [dbo].[dps_TemporaryStorage_GetByPageVersionId]    Script Date: 07/21/2009 17:22:08 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_TemporaryStorage_GetByPageVersionId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[dps_TemporaryStorage_GetByPageVersionId]
	@PageVersionId as int,
	@CreatorUID as uniqueidentifier
AS
BEGIN
    DELETE FROM dps_TemporaryStorage 
    WHERE DATEADD(mi, Expire, Created) < GETUTCDATE()

    SELECT StorageId, PageVersionId, Created, Expire, PageDocument, CreatorUID 
    FROM dps_TemporaryStorage 
    WHERE PageVersionId = @PageVersionId and CreatorUID=@CreatorUID
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[dps_TemporaryStorage_Update]    Script Date: 07/21/2009 17:22:08 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dps_TemporaryStorage_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[dps_TemporaryStorage_Update]
	@StorageId as int,
	@PageVersionId as int,
	@Expire as int,
	@PageDocument as image,
	@CreatorUID as uniqueidentifier	
AS
BEGIN
    UPDATE dps_TemporaryStorage 
    SET PageVersionId = @PageVersionId, Created = GETUTCDATE(), Expire = @Expire, PageDocument = @PageDocument, CreatorUID = @CreatorUID
    WHERE StorageId = @StorageId
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_FileTreeDelete]    Script Date: 07/21/2009 17:22:09 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_FileTreeDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_FileTreeDelete]
	@PageId int
 AS
-- get siteId
declare @SiteId uniqueidentifier
set @SiteId=(SELECT [SiteId] FROM [main_PageTree] WHERE [PageId] = @PageId)
--get element order
DECLARE @Order int 
SELECT @Order = [Order] 
	FROM dbo.main_PageTree
	WHERE [PageId] = @PageId
--print ''pageid=''+cast(@PageId as nvarchar(10))+''  order=''+cast(@order as nvarchar(10))
DECLARE @Count int
--delete element
IF (SELECT [IsFolder] FROM [main_PageTree] WHERE [PageId]  = @PageId) = 1
BEGIN
--FOLDER
--get folder outline
	DECLARE @Outline nvarchar(2048)

	SELECT @Outline = [Outline] 
		FROM [main_PageTree]
		WHERE [PageId] = @PageId

	--print ''outline=''+cast(@outline as nvarchar(10))

--count files in this folder
	SELECT @Count = COUNT(*) 
		FROM [main_PageTree]
		WHERE ([Outline] = @Outline) OR ([Outline] LIKE @Outline + ''%'') AND [SiteId]=@SiteId

--delete all child versions
	DELETE FROM [main_PageVersion] 
		WHERE [PageId] in (SELECT [PageId] FROM [main_PageTree] 
				WHERE ([Outline] LIKE @Outline + ''%'') AND [SiteId]=@SiteId)

--delete all children
	DECLARE @ChildPageId int
	DECLARE @CurrentOutlineLevel int
	SET @CurrentOutlineLevel = (SELECT [OutlineLevel] FROM [main_PageTree] WHERE [PageId]=@PageId)
	--print ''@CurrentOutlineLevel=''+cast(@CurrentOutlineLevel as nvarchar(10))
	WHILE EXISTS(SELECT null FROM [main_PageTree] WHERE ([Outline] LIKE @Outline + ''%'') AND ([OutlineLevel]=@CurrentOutlineLevel+1) AND [SiteId]=@SiteId)
	BEGIN
		SET @ChildPageId = (SELECT TOP 1 [PageId] FROM [main_PageTree] WHERE ([Outline] LIKE @Outline + ''%'') AND ([OutlineLevel]=@CurrentOutlineLevel+1) AND [SiteId]=@SiteId)
		--print ''@ChildPageId=''+cast(@ChildPageId as nvarchar(10))
		exec [main_FileTreeDelete] @ChildPageId
	END

-- delete navigation
	DELETE FROM [NavigationCommand]
		WHERE [UrlUID] = @PageId

-- delete page access records
	DELETE FROM [main_PageTreeAccess]
		WHERE [PageId] = @PageId

-- delete page attributes
	DELETE FROM [main_PageAttributes]
		WHERE [PageId] = @PageId

--delete folder
	DELETE FROM [main_PageTree]
		WHERE [PageId] = @PageId
END
ELSE
BEGIN
--SINGLE FILE

	--DECLARE @PageOutline nvarchar(200)
	--SELECT @PageOutline = [Outline] FROM [main_PageTree] WHERE [PageId] = @PageId
	--print ''deleting page ''+@PageOutline
	
-- delete navigation
	DELETE FROM [NavigationCommand]
		WHERE [UrlUID] = @PageId

-- delete page access records
	DELETE FROM [main_PageTreeAccess]
		WHERE [PageId] = @PageId

-- delete page attributes
	DELETE FROM [main_PageAttributes]
		WHERE [PageId] = @PageId

-- Delete all versions of the file
	DELETE FROM [main_PageVersion]
		WHERE [PageId] = @PageId

--delete file
	DELETE FROM [main_PageTree]
		WHERE [PageId] = @PageId

--TODO add settings delete
	SET @Count = 1
END
--UPDATE ORDER
UPDATE [main_PageTree]
	SET [Order] = [Order] -  @Count
	WHERE [Order] > @Order AND [SiteId]=@SiteId' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_FileTreeLoadFolderWithContent]    Script Date: 07/21/2009 17:22:09 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_FileTreeLoadFolderWithContent]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_FileTreeLoadFolderWithContent] 
	@FolderId int
AS
DECLARE @FolderOutline nvarchar(2048)
DECLARE @OutlineLevel int
--get folder outline
SELECT @FolderOutline = [Outline],@OutlineLevel = [OutlineLevel]
	FROM dbo.main_PageTree
	WHERE [PageId] = @FolderId
--get all files in folder
SELECT [PageId], [Name], [Outline], [OutlineLevel], [IsFolder], [IsDefault], [Order], [IsPublic], isnull([MasterPage], '''')
	FROM dbo.main_PageTree
	WHERE ([Outline] LIKE @FolderOutline + ''%'') OR ([PageId] = @FolderId)' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_FileTreeMoveTo]    Script Date: 07/21/2009 17:22:09 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_FileTreeMoveTo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_FileTreeMoveTo] 
	@PageId int,
	@NewParentId int
AS

DECLARE @Count int, @MaxOrder int
DECLARE @OutlineOld nvarchar(2048), @OutlineNew nvarchar(2048)

DECLARE @SiteId uniqueidentifier
DECLARE @OrderPar int, @FirstOrder int, @ParLevel int, @FirstLevel int

--if parent IsFolder = 1 - proceed
IF (SELECT [IsFolder] FROM dbo.main_PageTree WHERE [PageId] = @NewParentId) = 1 
BEGIN

	-- get siteId, parent Order, parent outline
	SELECT @SiteId = [SiteId], @OrderPar = [Order], @OutlineNew = [Outline], @ParLevel = [OutlineLevel] 
		FROM dbo.main_PageTree WHERE [PageId] = @NewParentId

	-- if @PageId specified the page, move only this page; otherwise it''s a folder it''ll be moved with all its pages (by outline)
	-- @useOutline is used to determine whether to move only the page or the whole folder
	declare @useOutline bit
	select @useOutline = [IsFolder], @OutlineOld = [Outline], 
			@OutlineNew = case [IsFolder]
							when 1 then @OutlineNew + [Name] + ''/''
							else @OutlineNew + [Name]
						  end,
			@FirstOrder = [Order] - 1,
			@FirstLevel = [OutlineLevel] - 1
		from dbo.[main_PageTree] 
			where [PageId] = @PageId

	set @useOutline = coalesce(@useOutline, 0)

	--get element count
	SELECT @Count = COUNT(*), @MaxOrder = MAX([Order]) FROM dbo.main_PageTree
		WHERE ([PageId] = @PageId) OR (@useOutline=1 AND ([Outline] LIKE @outlineOld + ''%'' AND [SiteId]=@SiteId))

	--update order
	UPDATE dbo.main_PageTree
		SET [Order] = [Order] - @Count
			WHERE [Order] > @MaxOrder AND [SiteId]=@SiteId	
	UPDATE dbo.main_PageTree
		SET [Order] = [Order] + @Count
		WHERE [Order] > @OrderPar AND [SiteId]=@SiteId

	--update outline, order, outline level
	UPDATE dbo.main_PageTree
		SET [Outline] = REPLACE([Outline],@OutlineOld,@OutlineNew),
			[Order] = [Order] - @FirstOrder + @OrderPar,
			[OutlineLevel] = [OutlineLevel] - @FirstLevel + @ParLevel
		WHERE ([PageId] = @PageId) OR (@useOutline=1 AND ([Outline] LIKE @OutlineOld + ''%'' AND [SiteId]=@SiteId))
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_FileTreeLoadFolderDefaultPage]    Script Date: 07/21/2009 17:22:10 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_FileTreeLoadFolderDefaultPage]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_FileTreeLoadFolderDefaultPage] 
	@folderId int
AS
 begin
	DECLARE @FolderOutline nvarchar(2048)
	DECLARE @OutlineLevel int
	--get folder outline
	SELECT @FolderOutline = [Outline],@OutlineLevel = [OutlineLevel]
		FROM dbo.main_PageTree
	WHERE [PageId] = @FolderId
	--get all files in folder
	SELECT [PageId], [Name], [Outline], [OutlineLevel], [IsFolder], [IsDefault], [Order], [IsPublic], isnull([MasterPage], '''')
		FROM dbo.main_PageTree
	WHERE ([Outline] LIKE @FolderOutline + ''%'') AND ([IsDefault] = 1)
 end' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItem_ResourcesAdd]    Script Date: 07/21/2009 17:22:10 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItem_ResourcesAdd]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_MenuItem_ResourcesAdd]
	@MenuItemId int,
	@LanguageId int,
	@Text nvarchar(250),
	@ToolTip nvarchar(250),
	@retval int output
 AS
INSERT dbo.main_MenuItem_Resources ([MenuItemId],[LanguageId],[Text],[ToolTip])
	VALUES  (@MenuItemId, @LanguageId, @Text,@ToolTip)
SET @retval = @@IDENTITY' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItem_ResourcesDelete]    Script Date: 07/21/2009 17:22:10 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItem_ResourcesDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_MenuItem_ResourcesDelete]
	@MenuItemId int,
	@LanguageId int
 AS
DELETE FROM dbo.main_MenuItem_Resources
	WHERE [MenuItemId] = @MenuItemId AND ([LanguageId] = @LanguageId OR @LanguageId = 0)' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItem_ResourcesGetAvaliableLanguage]    Script Date: 07/21/2009 17:22:10 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItem_ResourcesGetAvaliableLanguage]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_MenuItem_ResourcesGetAvaliableLanguage]
	@MenuItemId int
 AS
SELECT DISTINCT([LanguageId]) FROM dbo.main_MenuItem_Resources
	WHERE MenuItemId = @MenuItemId' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItem_ResourcesUpdate]    Script Date: 07/21/2009 17:22:11 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItem_ResourcesUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_MenuItem_ResourcesUpdate]
	@MenuItemId int,
	@LanguageId int,
	@Text nvarchar(250),
	@ToolTip nvarchar(250)
 AS
UPDATE dbo.main_MenuItem_Resources
	SET [Text] = @Text,
	[ToolTip] = @ToolTip
	WHERE [MenuItemId] = @MenuItemId AND [LanguageId] = @LanguageId' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItemAdd]    Script Date: 07/21/2009 17:22:11 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItemAdd]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_MenuItemAdd]
	@MenuId int,
	@CommandText nvarchar(1024) = '''',
	@CommandType int = 0,
	@Text nvarchar(250) = ''Mediachase CMS'',
	@LeftImageUrl nvarchar(1024) = NULL,
	@RightImageUrl nvarchar(1024) = NULL,
	@IsVisible bit = 1,
	@IsInherits bit = 0,
	@Order int = 0,
	@retval int output
AS
BEGIN
--get menu item [Outline]
DECLARE @Outline  nvarchar(1024)
SELECT @Outline = [Outline]  + CAST([MenuItemId] AS NVARCHAR(2048)) + ''.''
	FROM dbo.main_MenuItem
	WHERE [MenuId] = @MenuId AND [IsRoot] = 1
--append item to bottom
INSERT INTO dbo.main_MenuItem
	([MenuId],[CommandText],[CommandType],[Text],[LeftImageUrl],[RightImageUrl],[IsVisible],[IsInherits],[Order],[Outline],[OutlineLevel], [IsRoot])
	VALUES
	(@MenuId, @CommandText, @CommandType, @Text, @LeftImageUrl, @RightImageUrl, @IsVisible, @IsInherits, @Order, @Outline, 1, 0 )
SET @retval = SCOPE_IDENTITY()
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItemDelete]    Script Date: 07/21/2009 17:22:11 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItemDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_MenuItemDelete]
	@MenuItemId int
 AS
--get menu id
DECLARE @MenuId int
SELECT @MenuId = MenuId
	FROM dbo.main_MenuItem
	WHERE [MenuItemId] = @MenuItemId
--get element order
DECLARE @OrderFirst int
SELECT @OrderFirst = [Order]
	FROM dbo.main_MenuItem
	WHERE [MenuItemId] = @MenuItemId
--get outline
DECLARE @Outline nvarchar(2048)
SELECT @Outline = [Outline] + CAST([MenuItemId] AS NVARCHAR(2048)) +''.''
	FROM dbo.main_MenuItem
	WHERE [MenuItemId] = @MenuItemId
--get count of items to remove (menu item and its children)
DECLARE @ItemCount int
SELECT @ItemCount = COUNT(*) + 1
	FROM dbo.main_MenuItem
	WHERE [MenuId] = @MenuId 
		AND [Outline] LIKE @Outline +''%''
--preserve order for remaining menu items
--remove menu item and its children
DELETE FROM dbo.main_MenuItem
	WHERE [MenuItemId] = @MenuItemId 
		OR [Outline] LIKE @Outline + ''%''
'
END
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItemGetAllChild]    Script Date: 07/21/2009 17:22:11 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItemGetAllChild]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_MenuItemGetAllChild]
	@MenuItemId int
 AS
DECLARE @OutlineLevel int
DECLARE @Outline nvarchar(2048)
DECLARE @MenuId int
SELECT @OutlineLevel = [OutlineLevel] ,@Outline = [Outline] + CAST([MenuItemId] AS NVARCHAR(2048)) +''.'', @MenuId = [MenuId]
	FROM dbo.main_MenuItem
	WHERE [MenuItemId] = @MenuItemId
SELECT [MenuItemId], [Text], [CommandText], [CommandType], [Outline], [OutlineLevel], [IsRoot], [IsVisible], [MenuId], [LeftImageUrl],[RightImageUrl], [IsInherits],[Order]
	FROM dbo.main_MenuItem
	WHERE [Outline] Like @Outline +''%''  AND [MenuId] = @MenuId
	ORDER BY [Order]
' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItemGetByMenuIdLanguageId]    Script Date: 07/21/2009 17:22:12 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItemGetByMenuIdLanguageId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_MenuItemGetByMenuIdLanguageId]
	@MenuId int,
	@LanguageId int
 AS
	SELECT t1.MenuItemId, t1.MenuId, t1.CommandText, t1.CommandType, t1.LeftImageUrl, t1.RightImageUrl, t1.IsVisible, t1.IsRoot, t1.[Order], t2.[Text], t2.ToolTip, t2.LanguageId, t1.Outline, t1.OutlineLevel, t1.IsInherits
	FROM main_MenuItem t1 JOIN main_MenuItem_Resources t2 ON(t1.MenuItemId = t2.MenuItemId)
	WHERE (t1.MenuId = @MenuId)   AND (@LanguageId = t2.LanguageId OR @LanguageId = 0)' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItemGetByMenuId]    Script Date: 07/21/2009 17:22:12 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItemGetByMenuId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_MenuItemGetByMenuId]
	@MenuId int
 AS
SELECT [MenuItemId], [Text], [CommandText], [CommandType], [Outline], [OutlineLevel], [IsRoot], [IsVisible], [MenuId], [LeftImageUrl],[RightImageUrl], [IsInherits],[Order]
	FROM dbo.main_MenuItem
	WHERE [MenuId] = @MenuId AND [IsRoot] = 0
	ORDER BY [Order]
' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItemGetByMenuItemId]    Script Date: 07/21/2009 17:22:12 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItemGetByMenuItemId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_MenuItemGetByMenuItemId]
	@MenuItemId int
 AS
SELECT [MenuItemId], [Text], [CommandText], [CommandType], [Outline], [OutlineLevel], [IsRoot], [IsVisible], [MenuId], [LeftImageUrl],[RightImageUrl], [IsInherits],[Order]
	FROM dbo.main_MenuItem
	WHERE [MenuItemId] = @MenuItemId
' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItemGetByMenuItemIdAndLanguageId]    Script Date: 07/21/2009 17:22:12 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItemGetByMenuItemIdAndLanguageId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_MenuItemGetByMenuItemIdAndLanguageId]
	@MenuItemId int,
	@LanguageId int
 AS
SELECT t1.MenuItemId, t1.MenuId, t1.CommandText, t1.CommandType, t1.LeftImageUrl, t1.RightImageUrl, t1.IsVisible, t1.IsRoot, t1.[Order], t2.[Text], t2.ToolTip, t2.LanguageId, t1.Outline, t1.OutlineLevel, t1.IsInherits
	FROM main_MenuItem t1 JOIN main_MenuItem_Resources t2 ON(t1.MenuItemId = t2.MenuItemId)
	WHERE (t1.MenuItemId = @MenuItemId)   AND (@LanguageId = t2.LanguageId OR @LanguageId = 0)' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItemGetBySiteIdLanguageId]    Script Date: 07/21/2009 17:22:13 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItemGetBySiteIdLanguageId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_MenuItemGetBySiteIdLanguageId]
	@SiteId uniqueidentifier,
	@LanguageId int
AS
SELECT t1.MenuItemId, t1.MenuId, t1.CommandText, t1.CommandType, t1.LeftImageUrl, t1.RightImageUrl, t1.IsVisible, t1.IsRoot, t1.[Order], t2.[Text], t2.ToolTip, t2.LanguageId, t1.Outline, t1.OutlineLevel, t1.IsInherits
	FROM main_MenuItem t1 LEFT JOIN main_MenuItem_Resources t2 ON(t1.MenuItemId = t2.MenuItemId  AND (@LanguageId = t2.LanguageId OR @LanguageId = 0))
	INNER JOIN main_Menu M ON M.MenuId = t1.MenuId
	WHERE M.SiteId = @SiteId
	ORDER BY [Order]' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItemGetParentByMenuItemId]    Script Date: 07/21/2009 17:22:13 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItemGetParentByMenuItemId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_MenuItemGetParentByMenuItemId]
	@MenuItemId int
 AS
DECLARE @Outline nvarchar(2048)
SELECT @Outline = [Outline]
	FROM dbo.main_MenuItem
	WHERE [MenuItemId] = @MenuItemId
SELECT [MenuItemId], [Text], [CommandText], [CommandType], [Outline], [OutlineLevel], [IsRoot], [IsVisible], [MenuId], [LeftImageUrl],[RightImageUrl], [IsInherits],[Order]
	FROM dbo.main_MenuItem
	WHERE [Outline] + CAST([MenuItemId] AS NVARCHAR(2048)) + ''.'' =  @Outline
' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItemGetPathByMenuItemId]    Script Date: 07/21/2009 17:22:13 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItemGetPathByMenuItemId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_MenuItemGetPathByMenuItemId]
	@MenuItemId int
 AS
DECLARE @Outline nvarchar(2048)
DECLARE @MenuId int
SELECT @Outline = [Outline], @MenuId =[MenuId]
	FROM dbo.main_MenuItem
	WHERE [MenuItemId] = @MenuItemId
SELECT [MenuItemId], [Text], [CommandText], [CommandType], [Outline], [OutlineLevel], [IsRoot], [IsVisible], [MenuId], [LeftImageUrl],[RightImageUrl], [IsInherits],[Order]
	FROM dbo.main_MenuItem
	WHERE @Outline LIKE [Outline] + CAST([MenuItemId] AS NVARCHAR(2048)) +''.%'' AND [MenuId] = @MenuId
	ORDER BY [OutlineLevel]
' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItemGetRootByMenuId]    Script Date: 07/21/2009 17:22:13 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItemGetRootByMenuId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_MenuItemGetRootByMenuId]
	@MenuId int
 AS
SELECT [MenuItemId], [Text], [CommandText], [CommandType], [Outline], [OutlineLevel], [IsRoot], [IsVisible], [MenuId], [LeftImageUrl],[RightImageUrl], [IsInherits],[Order]
	FROM dbo.main_MenuItem
	WHERE [MenuId] = @MenuId AND [IsRoot] = 1
	ORDER BY [Order]
' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItemGetSubMenuByMenuItemId]    Script Date: 07/21/2009 17:22:14 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItemGetSubMenuByMenuItemId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_MenuItemGetSubMenuByMenuItemId]
	@MenuItemId int
 AS
DECLARE @OutlineLevel int
DECLARE @Outline nvarchar(2048)
DECLARE @MenuId int
SELECT @OutlineLevel = [OutlineLevel] ,@Outline = [Outline] + CAST([MenuItemId] AS NVARCHAR(2048)) +''.'', @MenuId = [MenuId]
	FROM dbo.main_MenuItem
	WHERE [MenuItemId] = @MenuItemId
SELECT [MenuItemId], [Text], [CommandText], [CommandType], [Outline], [OutlineLevel], [IsRoot], [IsVisible], [MenuId], [LeftImageUrl],[RightImageUrl], [IsInherits],[Order]
	FROM dbo.main_MenuItem
	WHERE [Outline] Like @Outline +''%'' AND [OutlineLevel] = @OutlineLevel + 1 AND [IsRoot] = 0
	ORDER BY [Order]
' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItemGetSubMenuByMenuItemIdAndLanguageId]    Script Date: 07/21/2009 17:22:14 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItemGetSubMenuByMenuItemIdAndLanguageId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_MenuItemGetSubMenuByMenuItemIdAndLanguageId]
	@MenuItemId int,
	@LanguageId int
 AS
DECLARE @OutlineLevel int
DECLARE @Outline nvarchar(2048)
DECLARE @MenuId int
SELECT @OutlineLevel = [OutlineLevel] ,@Outline = [Outline] + CAST([MenuItemId] AS NVARCHAR(2048)) +''.'', @MenuId = [MenuId]
	FROM dbo.main_MenuItem
	WHERE [MenuItemId] = @MenuItemId

SELECT t1.MenuItemId, t1.MenuId, t1.CommandText, t1.CommandType, t1.LeftImageUrl, t1.RightImageUrl, t1.IsVisible, t1.IsRoot, t1.[Order], t2.[Text], t2.ToolTip, t2.LanguageId, t1.Outline, t1.OutlineLevel, t1.IsInherits
	FROM main_MenuItem t1 JOIN main_MenuItem_Resources t2 ON(t1.MenuItemId = t2.MenuItemId)
	WHERE t1.[Outline] Like @Outline +''%'' AND t1.[OutlineLevel] = @OutlineLevel + 1 AND t1.[IsRoot] = 0   AND (@LanguageId = t2.LanguageId OR @LanguageId = 0)
	ORDER BY t1.[Order]' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItemMoveTo]    Script Date: 07/21/2009 17:22:14 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItemMoveTo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_MenuItemMoveTo]
	@MenuItemId int,
	@TargetMenuItemId int,
	@MoveToMode int
AS
--  1 moved item will be the first among the siblings
--  2 moved item will be the last among the siblings
--  3 sort order will not be changed

if (@MenuItemId = @TargetMenuItemId)
	return

--get start item outline
declare @Outline nvarchar(2048)
select @Outline = [Outline] + cast([MenuItemId] as nvarchar(2048)) + ''.''
	from dbo.main_MenuItem
	where [MenuItemId] = @MenuItemId

--get start item order
declare @CurrentOrder int
select @CurrentOrder = [Order] from dbo.main_MenuItem where [MenuItemId]  = @MenuItemId

--get target outline
declare @TargetOutline nvarchar(2048)
select @TargetOutline = [Outline] + cast([MenuItemId] as nvarchar(2048)) + ''.''
	from dbo.main_MenuItem
	where [MenuItemId] = @TargetMenuItemId

-- if target is child of a source, generate error
if left(@TargetOutline, len(@Outline)) = @Outline
begin
	RAISERROR(''Cannot move parent to a child.'', 1, 1)
	return
end

-- move item
if @Outline != @TargetOutline
begin
	-- get outline level
	declare @OutlineLevel int
	select @OutlineLevel = [OutlineLevel] from dbo.main_MenuItem
		where [MenuItemId] = @MenuItemId
	
	declare @TargetOutlineLevel int
	select @TargetOutlineLevel = [OutlineLevel] from dbo.main_MenuItem
		where [MenuItemId] = @TargetMenuItemId
	
	--update outline level
	update dbo.main_MenuItem
		set [OutlineLevel] = [OutlineLevel] - @OutlineLevel + @TargetOutlineLevel + 1
		where [Outline] LIKE @Outline + ''%'' OR [MenuItemId] = @MenuItemId 

	-- update outline
	-- item''s outline
	update [main_MenuItem] set [Outline] = @TargetOutline
		where [MenuItemId] = @MenuItemId

	-- children''s outline
	update [main_MenuItem]
		set [Outline] = replace([Outline], @Outline, @TargetOutline + cast(@MenuItemId AS NVARCHAR(2048)) + ''.'')
		where [Outline] like @Outline + ''%''
end

-------------- Update traget order ------------------
declare @TargetOrder int

------------- insert first ----------------
if @MoveToMode = 1
begin
	select @TargetOrder = coalesce(min([Order]), 0) from dbo.main_MenuItem 
		where ([Outline] = @TargetOutline and [MenuItemId] != @MenuItemId and [MenuItemId] != @TargetMenuItemId )

	if (@TargetOrder > 0)
		set @TargetOrder = @TargetOrder - 1

	--update item order
	update [main_MenuItem] set [Order] = @TargetOrder
		where [MenuItemId] = @MenuItemId
END

------------ insert last ----------------
IF @MoveToMode = 2
BEGIN

	select @TargetOrder = coalesce(max([Order]), 0) from dbo.main_MenuItem 
		where ([Outline] = @TargetOutline and [MenuItemId] != @MenuItemId and [MenuItemId] != @TargetMenuItemId )

	if (@TargetOrder < 0)
		set @TargetOrder = 0 
	else
		set @TargetOrder = @TargetOrder + 1

	--update item order
	update [main_MenuItem] set [Order] = @TargetOrder
		where [MenuItemId] = @MenuItemId
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItemUpdate]    Script Date: 07/21/2009 17:22:15 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItemUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_MenuItemUpdate]
	@MenuItemId int,
	@CommandText nvarchar(1024) = '''',
	@CommandType int = 0,
	@Text nvarchar(250) = ''Mediachase CMS'',
	@LeftImageUrl nvarchar(1024) = NULL,
	@RightImageUrl nvarchar(1024) = NULL,
	@IsVisible bit = 1,
	@IsInherits bit = 0,
	@Order int = 0
AS
	UPDATE dbo.main_MenuItem
	SET
		[CommandText] = @CommandText,
		[CommandType] = @CommandType,
		[Text] = @Text,
		[LeftImageUrl] = @LeftImageUrl,
		[RightImageUrl] = @RightImageUrl,
		[IsVisible] = @IsVisible,
		[IsInherits] = @IsInherits,
		[Order] = @Order
	WHERE [MenuItemId] = @MenuItemId' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_MenuItemUpdateSortOrder]    Script Date: 07/21/2009 17:22:15 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_MenuItemUpdateSortOrder]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_MenuItemUpdateSortOrder]
	@MenuItemId int,
	@Order int = 0
AS
	UPDATE dbo.main_MenuItem
	SET 
		[Order] = @Order
	WHERE [MenuItemId] = @MenuItemId' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_PageAttributesAdd]    Script Date: 07/21/2009 17:22:15 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageAttributesAdd]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_PageAttributesAdd] 
	@PageId INT,
	@Title NVARCHAR(256),
	@MetaKeys NVARCHAR(4000),
	@MetaDescriptions NVARCHAR(4000),
	@retval INT OUTPUT
AS
 BEGIN
	INSERT INTO [main_PageAttributes] ([PageId], [Title], [MetaKeys], [MetaDescriptions])
		VALUES (@PageId, @Title, @MetaKeys, @MetaDescriptions)
	SET @retval = @@IDENTITY
 END' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_PageAttributesDelete]    Script Date: 07/21/2009 17:22:15 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageAttributesDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_PageAttributesDelete] 
	@Id INT
AS
 BEGIN
	DELETE FROM [main_PageAttributes] WHERE [Id] = @Id
 END' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_PageAttributesDeleteByPageId]    Script Date: 07/21/2009 17:22:16 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageAttributesDeleteByPageId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_PageAttributesDeleteByPageId] 
	@PageId INT
AS
 BEGIN
	DELETE FROM [main_PageAttributes] WHERE [PageId] = @PageId
 END' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_PageAttributesGetById]    Script Date: 07/21/2009 17:22:16 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageAttributesGetById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_PageAttributesGetById] 
	@Id INT
AS
 BEGIN
	SELECT [Id] as Id, [Title] as Title, [MetaKeys] as MetaKeys, [MetaDescriptions] as MetaDescriptions
		FROM [main_PageAttributes] WHERE [Id] = @Id
 END' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_PageAttributesGetByPageId]    Script Date: 07/21/2009 17:22:16 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageAttributesGetByPageId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_PageAttributesGetByPageId] 
	@PageId INT
AS
 BEGIN
	SELECT [Id] as Id, [PageId] as PageId, [Title] as Title, [MetaKeys] as MetaKeys, [MetaDescriptions] as MetaDescriptions
		FROM [main_PageAttributes] WHERE [PageId] = @PageId
 END' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_PageAttributesUpdate]    Script Date: 07/21/2009 17:22:17 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageAttributesUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_PageAttributesUpdate] 
	@PageId INT,
	@Title NVARCHAR(256),
	@MetaKeys NVARCHAR(4000),
	@MetaDescriptions NVARCHAR(4000)
AS
 BEGIN
	UPDATE [main_PageAttributes] SET
		[Title] = @Title,
		[MetaKeys] = @MetaKeys,
		[MetaDescriptions] = @MetaDescriptions
	WHERE [PageId] = @PageId
 END' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_PageTreeAccess_Add]    Script Date: 07/21/2009 17:22:17 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageTreeAccess_Add]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_PageTreeAccess_Add] 
	@RoleId NVARCHAR(256),
	@PageId INT,
	@retval INT OUTPUT
AS
 BEGIN
	INSERT INTO [main_PageTreeAccess] (RoleId, PageId)
	VALUES (@RoleId, @PageId)
	SET @retval = @@IDENTITY
 END' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_PageTreeAccess_Delete]    Script Date: 07/21/2009 17:22:17 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageTreeAccess_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_PageTreeAccess_Delete] 
	@PageAccessId INT
AS
 BEGIN
	DELETE FROM [main_PageTreeAccess] WHERE [PageAccessId] = @PageAccessId
 END' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_PageTreeAccess_GetAll]    Script Date: 07/21/2009 17:22:17 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageTreeAccess_GetAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [main_PageTreeAccess_GetAll]
	@SiteId uniqueidentifier
AS
BEGIN
	SELECT PTA.[PageAccessId], PTA.[RoleId], PTA.[PageId] FROM [main_PageTreeAccess] PTA
	INNER JOIN [main_PageTree] PT ON PT.[PageId] = PTA.[PageId]
	WHERE PT.[SiteId] = @SiteId
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_PageTreeAccess_GetById]    Script Date: 07/21/2009 17:22:18 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageTreeAccess_GetById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_PageTreeAccess_GetById] 
	@PageAccessId INT
AS
 BEGIN
	SELECT [PageAccessId] as PageAccessId, [RoleId] as RoleId, [PageId] as PageId FROM [main_PageTreeAccess]
	WHERE [PageAccessId] = @PageAccessId
 END' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_PageTreeAccess_GetByPageId]    Script Date: 07/21/2009 17:22:18 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageTreeAccess_GetByPageId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_PageTreeAccess_GetByPageId] 
	@PageId INT
AS
 BEGIN
	SELECT [PageAccessId] as PageAccessId, [RoleId] as RoleId, [PageId] as PageId FROM [main_PageTreeAccess]
	WHERE [PageId] = @PageId
 END' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_PageTreeAccess_GetByRoleIdPageId]    Script Date: 07/21/2009 17:22:18 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageTreeAccess_GetByRoleIdPageId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_PageTreeAccess_GetByRoleIdPageId] 
	@RoleId NVARCHAR(256),
	@PageId INT
AS
 BEGIN
	SELECT [PageAccessId] as PageAccessId, [RoleId] as RoleId, [PageId] as PageId FROM [main_PageTreeAccess]
	WHERE [PageId] = @PageId and [RoleId] = @RoleId
 END' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_PageTreeAccess_Update]    Script Date: 07/21/2009 17:22:18 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageTreeAccess_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_PageTreeAccess_Update] 
	@PageAccessId INT,
	@RoleId NVARCHAR(256),
	@PageId INT
AS
 BEGIN
	UPDATE [main_PageTreeAccess] SET
		[RoleId] = @RoleId,
		[PageId] = @PageId
	WHERE [PageAccessId] = @PageAccessId
	
 END' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_PageVersionAdd]    Script Date: 07/21/2009 17:22:19 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageVersionAdd]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_PageVersionAdd] 
	@ApplicationId uniqueidentifier,
	@PageId int,
	@TemplateId int,
	@LangId int,
--	@StatusId int,
	@CreatorUID uniqueidentifier,
	@StateId int,
	@Comment nvarchar(1024),
	@retval int output
AS
 BEGIN
	DECLARE @WorkFlowId INT 
	DECLARE @WorkFlowStatus INT 
	SELECT @WorkFlowId = [WorkFlowId] FROM [WorkFlow] WHERE ApplicationId = @ApplicationId AND IsDefault = 1 
	SELECT @WorkFlowStatus = [StatusId] FROM [WorkFlowStatus] WHERE ([Weight] = 0) AND ([WorkFlowId] = @WorkFlowId)
	
	INSERT INTO [dbo].[main_PageVersion]
	([PageId], [TemplateId], [VersionNum], [LangId], [StatusId], [Created], [CreatorUID], [Edited], [EditorUID], [StateId], [Comment]) VALUES
	(@PageId, @TemplateId, 0, @LangId, @WorkFlowStatus, GETUTCDATE(), @CreatorUID, GETUTCDATE(), @CreatorUID, @StateId, @Comment)
	set @retval = SCOPE_IDENTITY()
 END' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_PageVersionAdd2]    Script Date: 07/21/2009 17:22:19 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageVersionAdd2]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_PageVersionAdd2] 
	@ApplicationId uniqueidentifier,
	@PageId int,
	@TemplateId int,
	@VersionNum int,
	@LangId int,
	@StatusId int,
	@Created datetime,
	@CreatorUID uniqueidentifier,
	@Edited datetime,
	@EditorUID uniqueidentifier,
	@StateId int,
	@Comment nvarchar(1024),
	@retval int output
AS
 BEGIN
	declare @statusToInsert int

	set @statusToInsert = @StatusId

	DECLARE @WorkFlowId INT
	SELECT @WorkFlowId = [WorkFlowId] FROM [WorkFlow] WHERE ApplicationId = @ApplicationId AND IsDefault = 1

	if(not exists(select null from [WorkflowStatus] where [StatusId]=@StatusId and [WorkflowId]=@WorkflowId)) 
	begin
		-- if status doesn''t exist, insert status with weight 0
		SELECT @statusToInsert = [Weight] FROM [WorkFlowStatus] WHERE ([Weight] = 0) AND ([WorkFlowId] = @WorkFlowId)
	end
	
	INSERT INTO [dbo].[main_PageVersion]
	([PageId], [TemplateId], [VersionNum], [LangId], [StatusId], [Created], [CreatorUID], [Edited], [EditorUID], [StateId], [Comment]) VALUES
	(@PageId, @TemplateId, @VersionNum, @LangId, @statusToInsert, @Created, @CreatorUID, @Edited, @EditorUID, @StateId, @Comment)
	set @retval = SCOPE_IDENTITY()
 END' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_PageVersionAddDraft]    Script Date: 07/21/2009 17:22:19 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageVersionAddDraft]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_PageVersionAddDraft] 
	@PageId int,
	@TemplateId int,
	@LangId int,
	@CreatorUID uniqueidentifier,
	@retval int output
AS
 BEGIN
	INSERT INTO [dbo].[main_PageVersion]
	([PageId], [TemplateId], [VersionNum], [LangId], [StatusId], [Created], [CreatorUID], [Edited], [EditorUID], [StateId], [Comment]) VALUES
	(@PageId, @TemplateId, 0, @LangId, -1, GETUTCDATE(), @CreatorUID, GETUTCDATE(), @CreatorUID, 1, N'''')
	set @retval = SCOPE_IDENTITY()
 END' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_PageVersionDelete]    Script Date: 07/21/2009 17:22:19 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageVersionDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_PageVersionDelete] 
	@PageVersionId int
AS
 BEGIN
	DELETE FROM [main_PageVersion] WHERE [VersionId] = @PageVersionId
 END' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_PageVersionGetById]    Script Date: 07/21/2009 17:22:20 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageVersionGetById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_PageVersionGetById] 
	@VersionId INT
AS
 BEGIN
	SELECT [PageId], [TemplateId], [VersionNum], [LangId], [StatusId], [Created], [CreatorUID],[Edited], [EditorUID], [StateId], [Comment]
	FROM [dbo].[main_PageVersion]
	WHERE [VersionId] = @VersionId
	ORDER BY StatusId DESC
 END' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_PageVersionGetByLangId]    Script Date: 07/21/2009 17:22:20 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageVersionGetByLangId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_PageVersionGetByLangId]
	@PageId INT,
	@LangId INT
AS
 BEGIN
	SELECT [VersionId], [TemplateId], [VersionNum], [LangId], [StatusId], [Created], [CreatorUID], [Edited], [EditorUID], [StateId], [Comment]
	FROM [dbo].[main_PageVersion]
	WHERE ([PageId] = @PageId) and ([LangId] = @LangId)
	ORDER BY StatusId DESC
 END' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_PageVersionGetByLangIdAndStatusId]    Script Date: 07/21/2009 17:22:20 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageVersionGetByLangIdAndStatusId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_PageVersionGetByLangIdAndStatusId]
	@PageId INT,
	@LangId INT,
	@StatusId INT
AS
 BEGIN
	SELECT [VersionId], [TemplateId], [VersionNum], [LangId], [StatusId], [Created], [CreatorUID], [Edited], [EditorUID], [StateId], [Comment]
	FROM [dbo].[main_PageVersion]
	WHERE ([PageId] = @PageId) and ([LangId] = @LangId)  and ([StatusId] = @StatusId)
 END' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_PageVersionGetByPageId]    Script Date: 07/21/2009 17:22:21 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageVersionGetByPageId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_PageVersionGetByPageId] 
	@PageId INT	
AS
 BEGIN
	SELECT [VersionId], [TemplateId], [VersionNum], [LangId], [StatusId], [Created], [CreatorUID], [Edited], [EditorUID], [StateId], [Comment]
	FROM [dbo].[main_PageVersion]
	WHERE [PageId] = @PageId
	ORDER BY StatusId DESC
 END' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_PageVersionGetByStateId]    Script Date: 07/21/2009 17:22:21 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageVersionGetByStateId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_PageVersionGetByStateId] 
	@PageId INT,
	@StateId INT
AS
 BEGIN
	SELECT [VersionId], [TemplateId], [VersionNum], [LangId], [StatusId], [Created], [CreatorUID], [Edited], [EditorUID], [StateId], [Comment]
	FROM [dbo].[main_PageVersion]
	WHERE [PageId] = @PageId and [StateId] = @StateId
	ORDER BY StatusId DESC
 END' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_PageVersionGetByStatusId]    Script Date: 07/21/2009 17:22:21 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageVersionGetByStatusId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_PageVersionGetByStatusId] 
	@PageId INT,
	@StatusId INT
AS
 BEGIN
	SELECT [VersionId], [TemplateId], [VersionNum], [LangId], [StatusId], [Created], [CreatorUID], [Edited], [EditorUID], [StateId], [Comment]
	FROM [dbo].[main_PageVersion]
	WHERE [PageId] = @PageId and [StatusId] = @StatusId
 END' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_PageVersionGetByUserId]    Script Date: 07/21/2009 17:22:21 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageVersionGetByUserId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_PageVersionGetByUserId] 
	@UserId uniqueidentifier

AS
 BEGIN
	SELECT [VersionId], [TemplateId], [VersionNum], [LangId],pv.[StatusId], [Created], [CreatorUID], [Edited], [EditorUID], [StateId], [Comment]
	FROM [dbo].[main_PageVersion] pv
	INNER JOIN WorkflowStatusAccess wsa ON pv.StatusId = wsa.StatusId
	INNER JOIN aspnet_Roles r ON wsa.RoleId = r.RoleName
	INNER JOIN aspnet_UsersInRoles uin ON r.RoleId = uin.RoleId
	INNER JOIN aspnet_Users u ON u.UserId = uin.UserId
	WHERE u.UserId = @UserId
 END' 
END
GO

/****** Object:  StoredProcedure [dbo].[main_PageVersionUpdate]    Script Date: 07/21/2009 17:22:22 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[main_PageVersionUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[main_PageVersionUpdate] 
	@VersionId INT,
	@TemplateId INT,
	@LangId INT,
	@OldStatusId INT,
	@NewStatusId INT,
	@EditorUID UNIQUEIDENTIFIER,
	@StateId INT,
	@Comment NVARCHAR(1024),
	@retval INT OUTPUT
AS
BEGIN
	DECLARE @PageId INT
	DECLARE @VersionNum INT
	DECLARE @Created DATETIME
	DECLARE @CreatorUID uniqueidentifier

	SELECT @PageId = [PageId], @VersionNum = [VersionNum], @Created = [Created], @CreatorUID = [CreatorUID]
		FROM [dbo].[main_PageVersion]
	WHERE [VersionId] = @VersionId

	-- update old page status
	UPDATE [dbo].[main_PageVersion] SET
		[VersionNum] = @VersionNum + 1,
		[TemplateId] = @TemplateId,
		[StatusId] = @NewStatusId,
		[LangId] = @LangId,
		[Edited] = GETUTCDATE(),
		[EditorUID] = @EditorUID,
		[StateId] = @StateId,
		[Comment] = @Comment
	WHERE [VersionId] = @VersionId
END' 
END
GO

/****** Object:  UserDefinedFunction [dbo].[cms_splitlist]    Script Date: 07/21/2009 17:22:22 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cms_splitlist]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[cms_splitlist]
(
	@List nvarchar(max)
)
RETURNS 
@ParsedList table
(
	Item nvarchar(100)
)
AS
BEGIN
	DECLARE @Item nvarchar(100), @Pos int

	SET @List = LTRIM(RTRIM(@List))+ '',''
	SET @Pos = CHARINDEX('','', @List, 1)

	IF REPLACE(@List, '','', '''') <> ''''
	BEGIN
		WHILE @Pos > 0
		BEGIN
			SET @Item = LTRIM(RTRIM(LEFT(@List, @Pos - 1)))
			IF @Item <> ''''
			BEGIN
				INSERT INTO @ParsedList (Item) 
				VALUES (CAST(@Item AS nvarchar(100))) --Use Appropriate conversion
			END
			SET @List = RIGHT(@List, LEN(@List) - @Pos)
			SET @Pos = CHARINDEX('','', @List, 1)

		END
	END	
	RETURN
END' 
END

GO

