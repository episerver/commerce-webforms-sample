/****** Object:  StoredProcedure [dbo].[mdpsp_sys_AddMetaAttribute]    Script Date: 07/21/2009 17:26:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_AddMetaAttribute]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_AddMetaAttribute]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_AddMetaDictionary]    Script Date: 07/21/2009 17:26:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_AddMetaDictionary]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_AddMetaDictionary]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_AddMetaStringDictionary]    Script Date: 07/21/2009 17:26:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_AddMetaStringDictionary]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_AddMetaStringDictionary]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_AddMultiValueDictionary]    Script Date: 07/21/2009 17:26:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_AddMultiValueDictionary]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_AddMultiValueDictionary]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_CheckReplaceUser]    Script Date: 07/21/2009 17:26:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_CheckReplaceUser]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_CheckReplaceUser]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_ClearMetaAttribute]    Script Date: 07/21/2009 17:26:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_ClearMetaAttribute]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_ClearMetaAttribute]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_ClearMultiValueDictionary]    Script Date: 07/21/2009 17:26:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_ClearMultiValueDictionary]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_ClearMultiValueDictionary]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_ClearStringDictionary]    Script Date: 07/21/2009 17:26:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_ClearStringDictionary]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_ClearStringDictionary]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_OpenSymmetricKey]    Script Date: 07/21/2009 17:26:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_OpenSymmetricKey]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_OpenSymmetricKey]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_CloseSymmetricKey]    Script Date: 07/21/2009 17:26:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_CloseSymmetricKey]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_CloseSymmetricKey]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_DeleteMetaKeyObjects]    Script Date: 07/21/2009 17:26:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_DeleteMetaKeyObjects]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_DeleteMetaKeyObjects]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_CreateMetaClassProcedure]    Script Date: 07/21/2009 17:26:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_CreateMetaClassProcedure]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_CreateMetaClassProcedure]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_CreateMetaClassProcedureAll]    Script Date: 07/21/2009 17:26:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_CreateMetaClassProcedureAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_CreateMetaClassProcedureAll]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_CreateMetaClass]    Script Date: 07/21/2009 17:26:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_CreateMetaClass]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_CreateMetaClass]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_DeleteDContrainByTableAndField]    Script Date: 07/21/2009 17:26:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_DeleteDContrainByTableAndField]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_DeleteDContrainByTableAndField]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_DeleteMetaAttribute]    Script Date: 07/21/2009 17:26:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_DeleteMetaAttribute]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_DeleteMetaAttribute]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_DeleteMetaClassProcedure]    Script Date: 07/21/2009 17:26:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_DeleteMetaClassProcedure]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_DeleteMetaClassProcedure]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_DeleteMetaClass]    Script Date: 07/21/2009 17:26:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_DeleteMetaClass]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_DeleteMetaClass]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_DeleteMetaDictionary]    Script Date: 07/21/2009 17:26:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_DeleteMetaDictionary]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_DeleteMetaDictionary]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_DeleteMetaField]    Script Date: 07/21/2009 17:26:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_DeleteMetaField]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_DeleteMetaField]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_DeleteMetaFile]    Script Date: 07/21/2009 17:26:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_DeleteMetaFile]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_DeleteMetaFile]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_DeleteMetaObjectValue]    Script Date: 07/21/2009 17:26:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_DeleteMetaObjectValue]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_DeleteMetaObjectValue]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_DeleteMetaRule]    Script Date: 07/21/2009 17:26:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_DeleteMetaRule]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_DeleteMetaRule]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_FullTextQueriesActivate] ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_FullTextQueriesActivate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_FullTextQueriesActivate]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_FullTextQueriesIndexUpdate] ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_FullTextQueriesIndexUpdate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_FullTextQueriesIndexUpdate]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_FullTextQueriesFieldUpdate] ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_FullTextQueriesFieldUpdate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_FullTextQueriesFieldUpdate]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_FullTextQueriesAddAllFields] ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_FullTextQueriesAddAllFields]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_FullTextQueriesAddAllFields]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_FullTextQueriesDeleteAllFields] ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_FullTextQueriesDeleteAllFields]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_FullTextQueriesDeleteAllFields]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_FullTextQueriesDeactivate] ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_FullTextQueriesDeactivate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_FullTextQueriesDeactivate]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_FullTextQueriesEnable] ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_FullTextQueriesEnable]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_FullTextQueriesEnable]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_FullTextQueriesRepopulateAll] ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_FullTextQueriesRepopulateAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_FullTextQueriesRepopulateAll]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_FullTextQueriesRepopulateCatalogScheduleDelete] ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_FullTextQueriesRepopulateCatalogScheduleDelete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_FullTextQueriesRepopulateCatalogScheduleDelete]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_FullTextQueriesRepopulateCatalogScheduleCreate] ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_FullTextQueriesRepopulateCatalogScheduleCreate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_FullTextQueriesRepopulateCatalogScheduleCreate]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_AddMetaField]    Script Date: 07/21/2009 17:26:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_AddMetaField]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_AddMetaField]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_AddMetaFieldToMetaClass]    Script Date: 07/21/2009 17:26:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_AddMetaFieldToMetaClass]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_AddMetaFieldToMetaClass]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_DeleteMetaFieldFromMetaClass]    Script Date: 07/21/2009 17:26:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_DeleteMetaFieldFromMetaClass]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_DeleteMetaFieldFromMetaClass]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_GetMetaKey]    Script Date: 07/21/2009 17:26:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_GetMetaKey]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_GetMetaKey]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_GetMetaKeyInfo]    Script Date: 07/21/2009 17:26:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_GetMetaKeyInfo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_GetMetaKeyInfo]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_GetUniqueFieldName]    Script Date: 07/21/2009 17:26:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_GetUniqueFieldName]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_GetUniqueFieldName]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadChildMetaClassList]    Script Date: 07/21/2009 17:26:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadChildMetaClassList]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_LoadChildMetaClassList]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaAttributes]    Script Date: 07/21/2009 17:26:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaAttributes]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_LoadMetaAttributes]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaClassById]    Script Date: 07/21/2009 17:26:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaClassById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_LoadMetaClassById]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaClassByName]    Script Date: 07/21/2009 17:26:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaClassByName]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_LoadMetaClassByName]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaClassByNamespace]    Script Date: 07/21/2009 17:26:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaClassByNamespace]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_LoadMetaClassByNamespace]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaClassList]    Script Date: 07/21/2009 17:26:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaClassList]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_LoadMetaClassList]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaClassListByMetaField]    Script Date: 07/21/2009 17:26:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaClassListByMetaField]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_LoadMetaClassListByMetaField]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaDictionary]    Script Date: 07/21/2009 17:26:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaDictionary]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_LoadMetaDictionary]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaField]    Script Date: 07/21/2009 17:26:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaField]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_LoadMetaField]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaFieldByName]    Script Date: 07/21/2009 17:26:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaFieldByName]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_LoadMetaFieldByName]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaFieldByNamespace]    Script Date: 07/21/2009 17:26:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaFieldByNamespace]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_LoadMetaFieldByNamespace]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaFieldList]    Script Date: 07/21/2009 17:26:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaFieldList]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_LoadMetaFieldList]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaFieldListByMetaClassId]    Script Date: 07/21/2009 17:26:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaFieldListByMetaClassId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_LoadMetaFieldListByMetaClassId]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaFieldWeight]    Script Date: 07/21/2009 17:26:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaFieldWeight]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_LoadMetaFieldWeight]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaFile]    Script Date: 07/21/2009 17:26:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaFile]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_LoadMetaFile]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaFileList]    Script Date: 07/21/2009 17:26:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaFileList]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_LoadMetaFileList]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaObjectValue]    Script Date: 07/21/2009 17:26:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaObjectValue]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_LoadMetaObjectValue]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaRuleById]    Script Date: 07/21/2009 17:26:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaRuleById]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_LoadMetaRuleById]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaRuleByMetaClassId]    Script Date: 07/21/2009 17:26:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaRuleByMetaClassId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_LoadMetaRuleByMetaClassId]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaStringDictionary]    Script Date: 07/21/2009 17:26:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaStringDictionary]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_LoadMetaStringDictionary]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaType]    Script Date: 07/21/2009 17:26:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaType]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_LoadMetaType]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaTypeList]    Script Date: 07/21/2009 17:26:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaTypeList]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_LoadMetaTypeList]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMultiValueDictionary]    Script Date: 07/21/2009 17:26:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMultiValueDictionary]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_LoadMultiValueDictionary]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_MetaFieldAllowSearch]    Script Date: 07/21/2009 17:26:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_MetaFieldAllowSearch]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_MetaFieldAllowSearch]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_MetaFieldAllowMultiLanguage]    Script Date: 07/21/2009 17:26:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_MetaFieldAllowMultiLanguage]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_MetaFieldAllowMultiLanguage]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_MetaFieldIsEncrypted]    Script Date: 07/21/2009 17:26:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_MetaFieldIsEncrypted]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_MetaFieldIsEncrypted]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_RefreshSystemMetaClassInfo]    Script Date: 07/21/2009 17:26:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_RefreshSystemMetaClassInfo]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_RefreshSystemMetaClassInfo]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_RefreshSystemMetaClassInfoAll]    Script Date: 07/21/2009 17:26:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_RefreshSystemMetaClassInfoAll]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_RefreshSystemMetaClassInfoAll]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_ReplaceUser]    Script Date: 07/21/2009 17:26:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_ReplaceUser]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_ReplaceUser]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_UpdateMetaClass]    Script Date: 07/21/2009 17:26:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_UpdateMetaClass]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_UpdateMetaClass]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_UpdateMetaDictionary]    Script Date: 07/21/2009 17:26:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_UpdateMetaDictionary]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_UpdateMetaDictionary]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_UpdateMetaField]    Script Date: 07/21/2009 17:26:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_UpdateMetaField]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_UpdateMetaField]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_UpdateMetaFieldEnabled]    Script Date: 07/21/2009 17:26:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_UpdateMetaFieldEnabled]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_UpdateMetaFieldEnabled]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_UpdateMetaFieldWeight]    Script Date: 07/21/2009 17:26:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_UpdateMetaFieldWeight]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_UpdateMetaFieldWeight]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_UpdateMetaFile]    Script Date: 07/21/2009 17:26:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_UpdateMetaFile]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_UpdateMetaFile]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_UpdateMetaObjectValue]    Script Date: 07/21/2009 17:26:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_UpdateMetaObjectValue]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_UpdateMetaObjectValue]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_UpdateMetaRule]    Script Date: 07/21/2009 17:26:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_UpdateMetaRule]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_UpdateMetaRule]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_UpdateMetaSqlScriptTemplate]    Script Date: 07/21/2009 17:26:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_UpdateMetaSqlScriptTemplate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_UpdateMetaSqlScriptTemplate]
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_RotateEncryptionKeys]    Script Date: 07/21/2009 17:26:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_RotateEncryptionKeys]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mdpsp_sys_RotateEncryptionKeys]
GO

/****** Object:  UserDefinedFunction [dbo].[mdpfn_sys_EncryptDecryptString]    Script Date: 07/21/2009 17:26:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpfn_sys_EncryptDecryptString]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[mdpfn_sys_EncryptDecryptString]
GO

if exists (select 1 from INFORMATION_SCHEMA.ROUTINES where ROUTINE_SCHEMA = 'dbo' and ROUTINE_NAME = 'mdpsp_sys_RegisterMetaFieldInSystemClass')
drop procedure [dbo].[mdpsp_sys_RegisterMetaFieldInSystemClass]
go

if exists ( select 1
            from sys.schemas s
            join sys.objects tabs on tabs.schema_id = s.schema_id
            join sys.triggers tr on tr.parent_id = tabs.object_id
            where s.name = 'dbo' and tabs.name = 'MetaClass' and tr.name = 'mdptr_sys_MetaClass_PrimaryKeyName')
drop trigger dbo.mdptr_sys_MetaClass_PrimaryKey
go

if exists ( select 1
            from sys.schemas s
            join sys.objects tabs on tabs.schema_id = s.schema_id
            join sys.triggers tr on tr.parent_id = tabs.object_id
            where s.name = 'dbo' and tabs.name = 'MetaField' and tr.name = 'mdptr_sys_MetaField_IsKeyField')
drop trigger dbo.mdptr_sys_MetaField_SystemMetaClassId
go

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_AddMetaAttribute]    Script Date: 07/21/2009 17:26:23 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_AddMetaAttribute]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_AddMetaAttribute]
	@AttrOwnerId		INT,
	@AttrOwnerType	INT,
	@Key			NVARCHAR(256),
	@Value			NTEXT
AS
	IF ( (SELECT COUNT(*) FROM MetaAttribute WHERE AttrOwnerId = @AttrOwnerId AND AttrOwnerType = @AttrOwnerType AND [Key] = @Key) = 0)
	BEGIN
		-- Insert
		INSERT INTO MetaAttribute (AttrOwnerId, AttrOwnerType, [Key], [Value] ) VALUES (@AttrOwnerId, @AttrOwnerType, @Key, @Value)
	END
	ELSE
	BEGIN
		-- Update
		UPDATE MetaAttribute SET [Value] = @Value  WHERE AttrOwnerId = @AttrOwnerId AND AttrOwnerType = @AttrOwnerType AND [Key] = @Key
	END'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_AddMetaDictionary]    Script Date: 07/21/2009 17:26:24 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_AddMetaDictionary]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_AddMetaDictionary]
	@MetaFieldId	INT,
	@Language	NVARCHAR(20)=NULL,
	@DefaultValue	NVARCHAR(2048),
	@DefaultTag	IMAGE=NULL,
	@Value		NVARCHAR(2048),
	@Tag		IMAGE=NULL,
	@Retval	INT OUT
AS
	SET NOCOUNT ON
	SET @Retval = -1

BEGIN TRAN
	DECLARE @MultiLanguageValue BIT
	SELECT @MultiLanguageValue = MultiLanguageValue FROM MetaField WHERE MetaFieldId = @MetaFieldId

	IF  @MultiLanguageValue = 1
	BEGIN
		INSERT INTO MetaDictionary (MetaFieldId, [Value], Tag) VALUES (@MetaFieldId, @DefaultValue, @DefaultTag)
		IF @@ERROR <> 0 GOTO ERR
		SET @Retval = @@IDENTITY

		IF @Language IS NOT NULL
		BEGIN
			IF EXISTS(SELECT * FROM MetaDictionaryLocalization WHERE MetaDictionaryId = @Retval AND Language = @Language)
				UPDATE MetaDictionaryLocalization SET Value = @Value, Tag = @Tag WHERE MetaDictionaryId = @Retval AND Language = @Language
			ELSE
				INSERT INTO MetaDictionaryLocalization (MetaDictionaryId, Language,  Value, Tag) VALUES (@Retval, @Language, @Value, @Tag)
			IF @@ERROR <> 0 GOTO ERR
		END
	END
	ELSE
	BEGIN
		INSERT INTO MetaDictionary (MetaFieldId, [Value], Tag) VALUES (@MetaFieldId, @Value, @Tag)
		IF @@ERROR <> 0 GOTO ERR
		SET @Retval = @@IDENTITY
	END

	COMMIT TRAN
RETURN

ERR:
	SET @Retval = -1
	ROLLBACK TRAN
RETURN
'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_AddMetaStringDictionary]    Script Date: 07/21/2009 17:26:24 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_AddMetaStringDictionary]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_AddMetaStringDictionary]
	@MetaKey	INT,
	@Key		NVARCHAR(512),
	@Value		NTEXT
AS
	-- Step 0. Prepare
	SET NOCOUNT ON

BEGIN TRAN

	INSERT INTO MetaStringDictionaryValue (MetaKey, [Key], [Value]) VALUES (@MetaKey, @Key, @Value)

COMMIT TRAN
RETURN

ERR:
ROLLBACK TRAN
RETURN'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_AddMultiValueDictionary]    Script Date: 07/21/2009 17:26:24 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_AddMultiValueDictionary]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_AddMultiValueDictionary]
	@MetaKey	INT,
	@MetaDictionaryId	INT
AS
	-- Step 0. Prepare
	SET NOCOUNT ON

BEGIN TRAN

	INSERT INTO MetaMultiValueDictionary (MetaKey, MetaDictionaryId) VALUES (@MetaKey, @MetaDictionaryId)

COMMIT TRAN
RETURN

ERR:
ROLLBACK TRAN
RETURN'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_CheckReplaceUser]    Script Date: 07/21/2009 17:26:24 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_CheckReplaceUser]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_CheckReplaceUser]
	@OldUserId AS nvarchar(100),
	@Retval AS INT OUTPUT
AS
	SET NOCOUNT ON

	SET @Retval = 0

	DECLARE classall_cursor CURSOR FOR
		SELECT MetaClassId, TableName FROM MetaClass WHERE IsSystem =0 AND IsAbstract = 0

	DECLARE @MetaClassId	INT
	DECLARE @TableName		NVARCHAR(255)

	OPEN classall_cursor
	FETCH NEXT FROM classall_cursor INTO @MetaClassId, @TableName

	DECLARE @SQLString NVARCHAR(500)

	WHILE(@@FETCH_STATUS = 0 AND @Retval = 0)
	BEGIN

		SET @SQLString  = N''IF EXISTS(SELECT TOP 1 * FROM '' + @TableName  + '' WHERE CreatorId = @OldUserId) SELECT 1''
		EXEC sp_executesql @SQLString, N''@OldUserId AS nvarchar(100)'', @OldUserId = @OldUserId
		IF @@ROWCOUNT <> 0
		BEGIN
			SET @Retval = 1
			BREAK
		END

		SET @SQLString  = N''IF EXISTS(SELECT TOP 1 * FROM '' + @TableName  + '' WHERE ModifierId = @OldUserId) SELECT 1''
		EXEC sp_executesql @SQLString, N''@OldUserId AS nvarchar(100)'', @OldUserId = @OldUserId
		IF @@ROWCOUNT <> 0
		BEGIN
			SET @Retval = 1
			BREAK
		END

		FETCH NEXT FROM classall_cursor INTO @MetaClassId, @TableName
	END

	CLOSE classall_cursor
	DEALLOCATE classall_cursor
RETURN'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_ClearMetaAttribute]    Script Date: 07/21/2009 17:26:25 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_ClearMetaAttribute]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_ClearMetaAttribute]
	@AttrOwnerId		INT,
	@AttrOwnerType	INT
AS
	DELETE FROM MetaAttribute WHERE AttrOwnerId = @AttrOwnerId AND AttrOwnerType = @AttrOwnerType
'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_ClearMultiValueDictionary]    Script Date: 07/21/2009 17:26:25 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_ClearMultiValueDictionary]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_ClearMultiValueDictionary]
	@MetaKey	INT
AS
	DELETE FROM MetaMultiValueDictionary WHERE MetaKey = @MetaKey'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_ClearStringDictionary]    Script Date: 07/21/2009 17:26:25 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_ClearStringDictionary]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_ClearStringDictionary]
	@MetaKey	INT
AS
	DELETE FROM MetaStringDictionaryValue WHERE MetaKey = @MetaKey'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_OpenSymmetricKey]    Script Date: 07/21/2009 17:26:26 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_OpenSymmetricKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_OpenSymmetricKey] AS
	OPEN SYMMETRIC KEY Mediachase_ECF50_MDP_Key DECRYPTION BY CERTIFICATE Mediachase_ECF50_MDP'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_CloseSymmetricKey]    Script Date: 07/21/2009 17:26:26 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_CloseSymmetricKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_CloseSymmetricKey] AS
	CLOSE SYMMETRIC KEY Mediachase_ECF50_MDP_Key'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_DeleteMetaKeyObjects]    Script Date: 07/21/2009 17:26:26 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_DeleteMetaKeyObjects]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_DeleteMetaKeyObjects]
	@MetaClassId	INT,
	@MetaFieldId	INT	=	-1,
	@MetaObjectId	INT	=	-1
AS
	-- Delete MetaObjectValue
	DELETE FROM MetaObjectValue  WHERE MetaKey IN
		(SELECT MK.MetaKey FROM MetaKey MK WHERE
			(@MetaObjectId = MK.MetaObjectId OR @MetaObjectId = -1)  AND
			(@MetaClassId = MK.MetaClassId OR @MetaClassId = -1) AND
			(@MetaFieldId = MK.MetaFieldId  OR @MetaFieldId = -1)
		)

	 IF @@ERROR <> 0 GOTO ERR

	-- Delete MetaStringDictionaryValue
	if(@MetaFieldId = -1 and @MetaObjectId != -1 and @MetaClassId != -1)
		DELETE FROM MetaStringDictionaryValue  WHERE MetaKey IN
			(SELECT MK.MetaKey FROM MetaKey MK WHERE
				(@MetaObjectId = MK.MetaObjectId)  AND
				(@MetaClassId = MK.MetaClassId)
			)
	else
		DELETE FROM MetaStringDictionaryValue  WHERE MetaKey IN
			(SELECT MK.MetaKey FROM MetaKey MK WHERE
				(@MetaObjectId = MK.MetaObjectId OR @MetaObjectId = -1)  AND
				(@MetaClassId = MK.MetaClassId OR @MetaClassId = -1) AND
				(@MetaFieldId = MK.MetaFieldId  OR @MetaFieldId = -1)
			)

	 IF @@ERROR <> 0 GOTO ERR

	-- Delete MetaMultiValueDictionary
	DELETE FROM MetaMultiValueDictionary  WHERE MetaKey IN
		(SELECT MK.MetaKey FROM MetaKey MK WHERE
			(@MetaObjectId = MK.MetaObjectId OR @MetaObjectId = -1)  AND
			(@MetaClassId = MK.MetaClassId OR @MetaClassId = -1) AND
			(@MetaFieldId = MK.MetaFieldId  OR @MetaFieldId = -1)
		)

	 IF @@ERROR <> 0 GOTO ERR

	-- Delete Meta File
	DELETE FROM MetaFileValue  WHERE MetaKey IN
		(SELECT MK.MetaKey FROM MetaKey MK WHERE
			(@MetaObjectId = MK.MetaObjectId OR @MetaObjectId = -1)  AND
			(@MetaClassId = MK.MetaClassId OR @MetaClassId = -1) AND
			(@MetaFieldId = MK.MetaFieldId  OR @MetaFieldId = -1)
		)

	 IF @@ERROR <> 0 GOTO ERR

	-- Clear Meta Key
	if(@MetaFieldId = -1 and @MetaObjectId != -1 and @MetaClassId != -1)
	begin
		DELETE FROM MetaKey WHERE
			(@MetaObjectId = MetaObjectId) AND
			(@MetaClassId = MetaClassId)
	end
	else
	begin
		DELETE FROM MetaKey  WHERE
			(@MetaObjectId = MetaObjectId OR @MetaObjectId = -1)  AND
			(@MetaClassId = MetaClassId OR @MetaClassId = -1) AND
			(@MetaFieldId = MetaFieldId OR @MetaFieldId = -1)
	end

ERR:
	RETURN'
END
GO

create procedure [dbo].[mdpsp_sys_CreateMetaClassProcedure]
    @MetaClassId int
as
begin
    set nocount on
    begin try
        declare @CRLF nchar(1) = CHAR(10)
        declare @MetaClassName nvarchar(256)
        declare @TableName sysname
        select @MetaClassName = Name, @TableName = TableName from MetaClass where MetaClassId = @MetaClassId
        if @MetaClassName is null raiserror('Metaclass not found.',16,1)

        -- get required info for each field
        declare @ParameterIndex int
        declare @ColumnName sysname
        declare @FieldIsMultilanguage bit
        declare @FieldIsEncrypted bit
        declare @FieldIsNullable bit
        declare @ColumnDataType sysname
        declare fields cursor local for
            select
                mfindex.ParameterIndex,
                mf.Name as ColumnName,
                mf.MultiLanguageValue as FieldIsMultilanguage,
                mf.IsEncrypted as FieldIsEncrypted,
                mf.AllowNulls,
                mdt.SqlName + case
                        when mdt.Variable = 1 then '(' + CAST(mf.Length as nvarchar) + ')'
                        when mf.DataTypeId in (5,24) and mfprecis.Value is not null and mfscale.Value is not null then '(' + cast(mfprecis.Value as nvarchar) + ',' + cast(mfscale.Value as nvarchar) + ')'
                        else '' end as ColumnDataType
            from (
                select ROW_NUMBER() over (order by innermf.Name) as ParameterIndex, innermf.MetaFieldId
                from MetaField innermf
                where innermf.SystemMetaClassId = 0
                  and exists (select 1 from MetaClassMetaFieldRelation cfr where cfr.MetaClassId = @MetaClassId and cfr.MetaFieldId = innermf.MetaFieldId)) mfindex
            join MetaField mf on mfindex.MetaFieldId = mf.MetaFieldId
            join MetaDataType mdt on mf.DataTypeId = mdt.DataTypeId
            left outer join MetaAttribute mfprecis on mf.MetaFieldId = mfprecis.AttrOwnerId and mfprecis.AttrOwnerType = 2 and mfprecis.[Key] = 'MdpPrecision'
            left outer join MetaAttribute mfscale on mf.MetaFieldId = mfscale.AttrOwnerId and mfscale.AttrOwnerType = 2 and mfscale.[Key] = 'MdpScale'

        -- aggregate field parts into lists for stored procedures
        declare @ParameterName nvarchar(max)
        declare @ColumnReadBase nvarchar(max)
        declare @ColumnReadLocal nvarchar(max)
        declare @WriteValue nvarchar(max)
        declare @ParameterDefinitions nvarchar(max) = ''
        declare @UnlocalizedSelectValues nvarchar(max) = ''
        declare @LocalizedSelectValues nvarchar(max) = ''
        declare @AllInsertColumns nvarchar(max) = ''
        declare @AllInsertValues nvarchar(max) = ''
        declare @BaseInsertColumns nvarchar(max) = ''
        declare @BaseInsertValues nvarchar(max) = ''
        declare @LocalInsertColumns nvarchar(max) = ''
        declare @LocalInsertValues nvarchar(max) = ''
        declare @AllUpdateActions nvarchar(max) = ''
        declare @BaseUpdateActions nvarchar(max) = ''
        declare @LocalUpdateActions nvarchar(max) = ''
        open fields
        while 1=1
        begin
            fetch next from fields into @ParameterIndex, @ColumnName, @FieldIsMultilanguage, @FieldIsEncrypted, @FieldIsNullable, @ColumnDataType
            if @@FETCH_STATUS != 0 break

            set @ParameterName = '@f' + cast(@ParameterIndex as nvarchar(10))
            set @ColumnReadBase = case when @FieldIsEncrypted = 1 then 'dbo.mdpfn_sys_EncryptDecryptString(T.[' + @ColumnName + '],0)' + ' as [' + @ColumnName + ']' else 'T.[' + @ColumnName + ']' end
            set @ColumnReadLocal = case when @FieldIsEncrypted = 1 then 'dbo.mdpfn_sys_EncryptDecryptString(L.[' + @ColumnName + '],0)' + ' as [' + @ColumnName + ']' else 'L.[' + @ColumnName + ']' end
            set @WriteValue = case when @FieldIsEncrypted = 1 then 'dbo.mdpfn_sys_EncryptDecryptString(' + @ParameterName + ',1)' else @ParameterName end

            set @ParameterDefinitions = @ParameterDefinitions + ',' + @ParameterName + ' ' + @ColumnDataType
            set @UnlocalizedSelectValues = @UnlocalizedSelectValues + ',' + @ColumnReadBase
            set @LocalizedSelectValues = @LocalizedSelectValues + ',' + case when @FieldIsMultilanguage = 1 then @ColumnReadLocal else @ColumnReadBase end
            set @AllInsertColumns = @AllInsertColumns + ',[' + @ColumnName + ']'
            set @AllInsertValues = @AllInsertValues + ',' + @WriteValue
            set @BaseInsertColumns = @BaseInsertColumns + case when @FieldIsMultilanguage = 0 then ',[' + @ColumnName + ']' else '' end
            set @BaseInsertValues = @BaseInsertValues + case when @FieldIsMultilanguage = 0 then ',' + @WriteValue else '' end
            set @LocalInsertColumns = @LocalInsertColumns + case when @FieldIsMultilanguage = 1 then ',[' + @ColumnName + ']' else '' end
            set @LocalInsertValues = @LocalInsertValues + case when @FieldIsMultilanguage = 1 then ',' + @WriteValue else '' end
            set @AllUpdateActions = @AllUpdateActions + ',[' + @ColumnName + ']=' + @WriteValue
            set @BaseUpdateActions = @BaseUpdateActions + ',[' + @ColumnName + ']=' + case when @FieldIsMultilanguage = 0 then @WriteValue when @FieldIsNullable = 1 then 'null' else 'default' end
            set @LocalUpdateActions = @LocalUpdateActions + ',[' + @ColumnName + ']=' + case when @FieldIsMultilanguage = 1 then @WriteValue when @FieldIsNullable = 1 then 'null' else 'default' end
        end
        close fields

        declare @OpenEncryptionKey nvarchar(max)
        declare @CloseEncryptionKey nvarchar(max)
        if exists(  select 1
                    from MetaField mf
                    join MetaClassMetaFieldRelation cfr on mf.MetaFieldId = cfr.MetaFieldId
                    where cfr.MetaClassId = @MetaClassId and mf.SystemMetaClassId = 0 and mf.IsEncrypted = 1)
        begin
            set @OpenEncryptionKey = 'exec dbo.mdpsp_sys_OpenSymmetricKey' + @CRLF
            set @CloseEncryptionKey = 'exec dbo.mdpsp_sys_CloseSymmetricKey' + @CRLF
        end
        else
        begin
            set @OpenEncryptionKey = ''
            set @CloseEncryptionKey = ''
        end

        -- create stored procedures
        declare @procedures table (name sysname, defn nvarchar(max), verb nvarchar(max))

        insert into @procedures (name, defn)
        values ('mdpsp_avto_' + @TableName + '_Get',
            'procedure dbo.[mdpsp_avto_' + @TableName + '_Get] @ObjectId int,@Language nvarchar(20)=null as ' + @CRLF +
            'begin' + @CRLF +
            @OpenEncryptionKey +
            'if @Language is null select T.ObjectId,T.CreatorId,T.Created,T.ModifierId,T.Modified' + @UnlocalizedSelectValues + @CRLF +
            'from [' + @TableName + '] T where ObjectId=@ObjectId' + @CRLF +
            'else select T.ObjectId,T.CreatorId,T.Created,T.ModifierId,T.Modified' + @LocalizedSelectValues + @CRLF +
            'from [' + @TableName + '] T' + @CRLF +
            'left join [' + @TableName + '_Localization] L on T.ObjectId=L.ObjectId and L.Language=@Language' + @CRLF +
            'where T.ObjectId= @ObjectId' + @CRLF +
            @CloseEncryptionKey +
            'end' + @CRLF)

        insert into @procedures (name, defn)
        values ('mdpsp_avto_' + @TableName + '_Update',
            'procedure dbo.[mdpsp_avto_' + @TableName + '_Update]' + @CRLF +
            '@ObjectId int,@Language nvarchar(20)=null,@CreatorId nvarchar(100),@Created datetime,@ModifierId nvarchar(100),@Modified datetime,@Retval int out' + @ParameterDefinitions + ' as' + @CRLF +
            'begin' + @CRLF +
            'set nocount on' + @CRLF +
            'declare @ins bit' + @CRLF +
            'begin try' + @CRLF +
            'begin transaction' + @CRLF +
            @OpenEncryptionKey +
            'if @ObjectId=-1 select @ObjectId=isnull(MAX(ObjectId),0)+1, @Retval=@ObjectId, @ins=0 from [' + @TableName + ']' + @CRLF +
            'else set @ins=case when exists(select 1 from [' + @TableName + '] where ObjectId=@ObjectId) then 0 else 1 end' + @CRLF +
            'if @Language is null' + @CRLF +
            'begin' + @CRLF +
            '  if @ins=1 insert [' + @TableName + '] (ObjectId,CreatorId,Created,ModifierId,Modified' + @AllInsertColumns + ')' + @CRLF +
            '  values (@ObjectId,@CreatorId,@Created,@ModifierId,@Modified' + @AllInsertValues + ')' + @CRLF +
            '  else update [' + @TableName + '] set CreatorId=@CreatorId,Created=@Created,ModifierId=@ModifierId,Modified=@Modified' + @AllUpdateActions + @CRLF +
            '  where ObjectId=@ObjectId' + @CRLF +
            'end' + @CRLF +
            'else' + @CRLF +
            'begin' + @CRLF +
            '  if @ins=1 insert [' + @TableName + '] (ObjectId,CreatorId,Created,ModifierId,Modified' + @BaseInsertColumns + ')' + @CRLF +
            '  values (@ObjectId,@CreatorId,@Created,@ModifierId,@Modified' + @BaseInsertValues + ')' + @CRLF +
            '  else update [' + @TableName + '] set CreatorId=@CreatorId,Created=@Created,ModifierId=@ModifierId,Modified=@Modified' + @BaseUpdateActions + @CRLF +
            '  where ObjectId=@ObjectId' + @CRLF +
            '  if not exists (select 1 from [' + @TableName + '_Localization] where ObjectId=@ObjectId and Language=@Language)' + @CRLF +
            '  insert [' + @TableName + '_Localization] (ObjectId,Language,ModifierId,Modified' + @LocalInsertColumns + ')' + @CRLF +
            '  values (@ObjectId,@Language,@ModifierId,@Modified' + @LocalInsertValues + ')' + @CRLF +
            '  else update [' + @TableName + '_Localization] set ModifierId=@ModifierId,Modified=@Modified' + @LocalUpdateActions + @CRLF +
            '  where ObjectId=@ObjectId and Language=@language' + @CRLF +
            'end' + @CRLF +
            @CloseEncryptionKey +
            'commit transaction' + @CRLF +
            'end try' + @CRLF +
            'begin catch' + @CRLF +
            '  declare @m nvarchar(4000),@v int,@t int' + @CRLF +
            '  select @m=ERROR_MESSAGE(),@v=ERROR_SEVERITY(),@t=ERROR_STATE()' + @CRLF +
            '  rollback transaction' + @CRLF +
            '  raiserror(@m, @v, @t)' + @CRLF +
            'end catch' + @CRLF +
            'end' + @CRLF)

        insert into @procedures (name, defn)
        values ('mdpsp_avto_' + @TableName + '_Delete',
            'procedure dbo.[mdpsp_avto_' + @TableName + '_Delete] @ObjectId int as' + @CRLF +
            'begin' + @CRLF +
            'delete [' + @TableName + '] where ObjectId=@ObjectId' + @CRLF +
            'delete [' + @TableName + '_Localization] where ObjectId=@ObjectId' + @CRLF +
            'exec dbo.mdpsp_sys_DeleteMetaKeyObjects ' + CAST(@MetaClassId as nvarchar(10)) + ',-1,@ObjectId' + @CRLF +
            'end' + @CRLF)

        insert into @procedures (name, defn)
        values ('mdpsp_avto_' + @TableName + '_List',
            'procedure dbo.[mdpsp_avto_' + @TableName + '_List] @Language nvarchar(20)=null,@select_list nvarchar(max)='''',@search_condition nvarchar(max)='''' as' + @CRLF +
            'begin' + @CRLF +
            @OpenEncryptionKey +
            'if @Language is null select T.ObjectId,T.CreatorId,T.Created,T.ModifierId,T.Modified' + @UnlocalizedSelectValues + ' from [' + @TableName + '] T' + @CRLF +
            'else select T.ObjectId,T.CreatorId,T.Created,T.ModifierId,T.Modified' + @LocalizedSelectValues + @CRLF +
            'from [' + @TableName + '] T' + @CRLF +
            'left join [' + @TableName + '_Localization] L on T.ObjectId=L.ObjectId and L.Language=@Language' + @CRLF +
            @CloseEncryptionKey +
            'end' + @CRLF)

        insert into @procedures (name, defn)
        values ('mdpsp_avto_' + @TableName + '_Search',
            'procedure dbo.[mdpsp_avto_' + @TableName + '_Search] @Language nvarchar(20)=null,@select_list nvarchar(max)='''',@search_condition nvarchar(max)='''' as' + @CRLF +
            'begin' + @CRLF +
            'if len(@select_list)>0 set @select_list='',''+@select_list' + @CRLF +
            @OpenEncryptionKey +
            'if @Language is null exec(''select T.ObjectId,T.CreatorId,T.Created,T.ModifierId,T.Modified' + @UnlocalizedSelectValues + '''+@select_list+'' from [' + @TableName + '] T ''+@search_condition)' + @CRLF +
            'else exec(''select T.ObjectId,T.CreatorId,T.Created,T.ModifierId,T.Modified' + @LocalizedSelectValues + '''+@select_list+'' from [' + @TableName + '] T left join [' + @TableName + '_Localization] L on T.ObjectId=L.ObjectId and L.Language=@Language ''+@search_condition)' + @CRLF +
            @CloseEncryptionKey +
            'end' + @CRLF)

        update tgt
        set verb = case when r.ROUTINE_NAME is null then 'create ' else 'alter ' end
        from @procedures tgt
        left outer join INFORMATION_SCHEMA.ROUTINES r on r.ROUTINE_SCHEMA = 'dbo' and r.ROUTINE_NAME = tgt.name

        -- install procedures
        declare @sqlstatement nvarchar(max)
        declare procedure_cursor cursor local for select verb + defn from @procedures
        open procedure_cursor
        while 1=1
        begin
            fetch next from procedure_cursor into @sqlstatement
            if @@FETCH_STATUS != 0 break
            exec(@sqlstatement)
        end
        close procedure_cursor
    end try
    begin catch
        declare @m nvarchar(4000), @v int, @t int
        select @m = ERROR_MESSAGE(), @v = ERROR_SEVERITY(), @t = ERROR_STATE()
        raiserror(@m,@v,@t)
    end catch
end
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_CreateMetaClassProcedureAll]    Script Date: 07/21/2009 17:26:27 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_CreateMetaClassProcedureAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_CreateMetaClassProcedureAll]
AS
SET NOCOUNT ON
BEGIN TRAN
	DECLARE classall_cursor CURSOR FOR
		SELECT MetaClassId FROM MetaClass WHERE IsSystem =0 AND IsAbstract = 0

	DECLARE @MetaClassId	INT

	OPEN classall_cursor
	FETCH NEXT FROM classall_cursor INTO @MetaClassId

	WHILE @@FETCH_STATUS = 0
	BEGIN
		--PRINT @MetaClassId
		EXEC  mdpsp_sys_CreateMetaClassProcedure @MetaClassId
		IF @@ERROR <> 0 GOTO ERR

	FETCH NEXT FROM classall_cursor INTO @MetaClassId
	END

	CLOSE classall_cursor
	DEALLOCATE classall_cursor

	COMMIT TRAN
RETURN

ERR:
	CLOSE classall_cursor
	DEALLOCATE classall_cursor

	ROLLBACK TRAN
RETURN'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_CreateMetaClass]    Script Date: 07/21/2009 17:26:27 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_CreateMetaClass]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_CreateMetaClass]
	@Namespace 		NVARCHAR(1024),
	@Name 		NVARCHAR(256),
	@FriendlyName		NVARCHAR(256),
	@TableName 		NVARCHAR(256),
	@ParentClassId 		INT,
	@IsSystem		BIT,
	@IsAbstract		BIT	=	0,
	@Description 		NTEXT,
	@Retval 		INT OUTPUT
AS
BEGIN
	-- Step 0. Prepare
	SET NOCOUNT ON
	SET @Retval = -1

BEGIN TRAN
	-- Step 1. Insert a new record in to the MetaClass table
	INSERT INTO [MetaClass] ([Namespace],[Name], [FriendlyName],[Description], [TableName], [ParentClassId], [PrimaryKeyName], [IsSystem], [IsAbstract])
		VALUES (@Namespace, @Name, @FriendlyName, @Description, @TableName, @ParentClassId, ''undefined'', @IsSystem, @IsAbstract)

	IF @@ERROR <> 0 GOTO ERR

	SET @Retval = @@IDENTITY

	IF @IsSystem = 1
	BEGIN
		IF NOT EXISTS(SELECT * FROM SYSOBJECTS WHERE [NAME] = @TableName AND [type] = ''U'')
		BEGIN
			RAISERROR (''Wrong System TableName.'', 16,1 )
			GOTO ERR
		END

		-- Step 3-2. Insert a new record in to the MetaField table
		INSERT INTO [MetaField]  ([Namespace], [Name], [FriendlyName], [SystemMetaClassId], [DataTypeId], [Length], [AllowNulls],  [MultiLanguageValue], [AllowSearch], [IsEncrypted])
			 SELECT @Namespace+ N''.'' + @Name, SC .[name] , SC .[name] , @Retval ,MDT .[DataTypeId], SC .[length], SC .[isnullable], 0, 0, 0  FROM SYSCOLUMNS AS SC
				INNER JOIN SYSOBJECTS SO ON SO.[ID] = SC.[ID]
				INNER JOIN SYSTYPES ST ON ST.[xtype] = SC.[xtype]
				INNER JOIN MetaDataType MDT ON MDT.[Name] = ST.[name]
			WHERE SO.[ID]  = object_id( @TableName) and OBJECTPROPERTY( SO.[ID], N''IsTable'') = 1 and ST.name<>''sysname''
			ORDER BY COLORDER /* Aug 29, 2006 */

		IF @@ERROR<> 0 GOTO ERR

		-- Step 3-2. Insert a new record in to the MetaClassMetaFieldRelation table
		INSERT INTO [MetaClassMetaFieldRelation]  (MetaClassId, MetaFieldId)
			SELECT @Retval, MetaFieldId FROM MetaField WHERE [SystemMetaClassId] = @Retval
	END
	ELSE
	BEGIN
		IF @IsAbstract = 0
		BEGIN
			-- Step 2. Create the @TableName table.
			EXEC(''CREATE TABLE [dbo].['' + @TableName  + ''] ([ObjectId] [int] NOT NULL , [CreatorId] [nvarchar](100), [Created] [datetime], [ModifierId] [nvarchar](100) , [Modified] [datetime] ) ON [PRIMARY]'')

			IF @@ERROR <> 0 GOTO ERR

			EXEC(''ALTER TABLE [dbo].['' + @TableName  + ''] WITH NOCHECK ADD CONSTRAINT [PK_'' + @TableName  + ''] PRIMARY KEY  CLUSTERED ([ObjectId])  ON [PRIMARY]'')

			IF @@ERROR <> 0 GOTO ERR

			IF EXISTS(SELECT * FROM MetaClass WHERE MetaClassId = @ParentClassId /* AND @IsSystem = 1 */ )
			BEGIN
				-- Step 3-2. Insert a new record in to the MetaClassMetaFieldRelation table
				INSERT INTO [MetaClassMetaFieldRelation]  (MetaClassId, MetaFieldId)
					SELECT @Retval, MetaFieldId FROM MetaField WHERE [SystemMetaClassId] = @ParentClassId
			END

			IF @@ERROR<> 0 GOTO ERR

			-- Step 2-2. Create the @TableName_Localization table
			EXEC(''CREATE TABLE [dbo].['' + @TableName + ''_Localization] ([Id] [int] IDENTITY (1, 1)  NOT NULL, [ObjectId] [int] NOT NULL , [ModifierId] [nvarchar](100), [Modified] [datetime], [Language] nvarchar(20) NOT NULL) ON [PRIMARY]'')

			IF @@ERROR<> 0 GOTO ERR

			EXEC(''ALTER TABLE [dbo].['' + @TableName  + ''_Localization] WITH NOCHECK ADD CONSTRAINT [PK_'' + @TableName  + ''_Localization] PRIMARY KEY  CLUSTERED ([Id])  ON [PRIMARY]'')

			IF @@ERROR<> 0 GOTO ERR

			EXEC (''CREATE NONCLUSTERED INDEX IX_'' + @TableName + ''_Localization_Language ON dbo.'' + @TableName + ''_Localization ([Language]) ON [PRIMARY]'')

			IF @@ERROR<> 0 GOTO ERR

			EXEC (''CREATE UNIQUE NONCLUSTERED INDEX IX_'' + @TableName + ''_Localization_ObjectId ON dbo.'' + @TableName + ''_Localization (ObjectId,[Language]) ON [PRIMARY]'')

			IF @@ERROR<> 0 GOTO ERR

			declare @system_root_class_id int
			;with cte as (
				select MetaClassId, ParentClassId, IsSystem
				from MetaClass
				where MetaClassId = @ParentClassId
				union all
				select mc.MetaClassId, mc.ParentClassId, mc.IsSystem
				from cte
				join MetaClass mc on cte.ParentClassId = mc.MetaClassId and cte.IsSystem = 0
			)
			select @system_root_class_id = MetaClassId
			from cte
			where IsSystem = 1

			if exists (select 1 from MetaClass where MetaClassId = @ParentClassId and IsSystem = 1)
			begin
				declare @parent_table sysname
				declare @parent_key_column sysname
				select @parent_table = mc.TableName, @parent_key_column = c.name
				from MetaClass mc
				join sys.key_constraints kc on kc.parent_object_id = OBJECT_ID(''[dbo].['' + mc.TableName + '']'', ''U'')
				join sys.index_columns ic on kc.parent_object_id = ic.object_id and kc.unique_index_id = ic.index_id
				join sys.columns c on ic.object_id = c.object_id and ic.column_id = c.column_id
				where mc.MetaClassId = @system_root_class_id
				  and kc.type = ''PK''
				  and ic.index_column_id = 1
				
				declare @child_table nvarchar(4000)
				declare child_tables cursor local for select @TableName as table_name union all select @TableName + ''_Localization''
				open child_tables
				while 1=1
				begin
					fetch next from child_tables into @child_table
					if @@FETCH_STATUS != 0 break
					
					declare @fk_name nvarchar(4000) = ''FK_'' + @child_table + ''_'' + @parent_table
					declare @fk_sql nvarchar(4000) =
						''alter table [dbo].['' + @child_table + ''] add '' +
						case when LEN(@fk_name) <= 128 then ''constraint ['' + @fk_name + ''] '' else '''' end +
						''foreign key (ObjectId) references [dbo].['' + @parent_table + ''] (['' + @parent_key_column + '']) on delete cascade on update cascade''
						
					execute dbo.sp_executesql @fk_sql
				end
				close child_tables
				
				if @@ERROR != 0 goto ERR
			end

			EXEC mdpsp_sys_CreateMetaClassProcedure @Retval
			IF @@ERROR <> 0 GOTO ERR
		END
	END

	-- Update PK Value
	DECLARE @PrimaryKeyName	NVARCHAR(256)
	SELECT @PrimaryKeyName = name FROM Sysobjects WHERE OBJECTPROPERTY(id, N''IsPrimaryKey'') = 1 and parent_obj = OBJECT_ID(@TableName) and OBJECTPROPERTY(parent_obj, N''IsUserTable'') = 1

	IF @PrimaryKeyName IS NOT NULL
		UPDATE [MetaClass] SET PrimaryKeyName = @PrimaryKeyName WHERE MetaClassId = @Retval

	COMMIT TRAN
RETURN

ERR:
	ROLLBACK TRAN
	SET @Retval = -1
RETURN
END'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_DeleteDContrainByTableAndField]    Script Date: 07/21/2009 17:26:28 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_DeleteDContrainByTableAndField]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_DeleteDContrainByTableAndField]
	@TableName	NVARCHAR(256),
	@FieldName	NVARCHAR(256)
AS
	SET NOCOUNT ON

	DECLARE @DConstrainName NVARCHAR(256)

	DECLARE DConstrainCursor CURSOR local FOR
	    select df_constraints.name
	    from sys.objects df_constraints
	    join sys.columns cols on df_constraints.object_id = cols.default_object_id
	    where cols.object_id = OBJECT_ID(@TableName, ''TABLE'')
	      and cols.name = @FieldName

	OPEN DConstrainCursor

	FETCH NEXT FROM DConstrainCursor  INTO @DConstrainName

	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC(''ALTER TABLE [dbo].['' + @TableName +''] DROP  CONSTRAINT ''+ @DConstrainName)
		--
		FETCH NEXT FROM DConstrainCursor  INTO @DConstrainName
	END

	CLOSE DConstrainCursor
	DEALLOCATE DConstrainCursor'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_DeleteMetaAttribute]    Script Date: 07/21/2009 17:26:28 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_DeleteMetaAttribute]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_DeleteMetaAttribute]
	@AttrOwnerId		INT,
	@AttrOwnerType	INT,
	@Key			NVARCHAR(512)
AS
	DELETE FROM MetaAttribute WHERE AttrOwnerId = @AttrOwnerId AND AttrOwnerType = @AttrOwnerType AND [Key] = @Key
'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_DeleteMetaClassProcedure]    Script Date: 07/21/2009 17:26:28 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_DeleteMetaClassProcedure]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_DeleteMetaClassProcedure]
	@MetaClassId	INT
AS
	SET NOCOUNT ON

BEGIN TRAN
	IF NOT EXISTS( SELECT * FROM MetaClass WHERE MetaClassId = @MetaClassId)
	BEGIN
		RAISERROR (''Wrong @MetaClassId. The class is system or not existed.'', 16,1)
		GOTO ERR
	END

	-- Step 1. Create SQL Code
	PRINT''Step 1. Create SQL Code''

	DECLARE	@MetaClassTable			NVARCHAR(256)
	DECLARE	@MetaClassGetSpName			NVARCHAR(256)
	DECLARE	@MetaClassUpdateSpName		NVARCHAR(256)
	DECLARE	@MetaClassDeleteSpName		NVARCHAR(256)
	DECLARE	@MetaClassListSpName		NVARCHAR(256)

	SELECT @MetaClassTable = TableName FROM MetaClass WHERE MetaClassId = @MetaClassId

	SET @MetaClassGetSpName 		= ''mdpsp_avto_'' +@MetaClassTable +''_Get''
	SET @MetaClassUpdateSpName 	= ''mdpsp_avto_'' +@MetaClassTable +''_Update''
	SET @MetaClassDeleteSpName 	= ''mdpsp_avto_'' +@MetaClassTable +''_Delete''
	SET @MetaClassListSpName 	= ''mdpsp_avto_'' +@MetaClassTable +''_List''

	-- Step 2. Drop operation
	PRINT''Step 2. Drop operation''

	if exists (select * from dbo.sysobjects where id = object_id(@MetaClassUpdateSpName) and OBJECTPROPERTY(id, N''IsProcedure'') = 1)
		EXEC(''drop procedure '' + @MetaClassUpdateSpName)
	IF @@ERROR <> 0 GOTO ERR

	if exists (select * from dbo.sysobjects where id = object_id(@MetaClassGetSpName) and OBJECTPROPERTY(id, N''IsProcedure'') = 1)
		EXEC(''drop procedure '' + @MetaClassGetSpName)
	IF @@ERROR <> 0 GOTO ERR

	if exists (select * from dbo.sysobjects where id = object_id(@MetaClassDeleteSpName) and OBJECTPROPERTY(id, N''IsProcedure'') = 1)
		EXEC(''drop procedure '' + @MetaClassDeleteSpName)
	IF @@ERROR <> 0 GOTO ERR

	if exists (select * from dbo.sysobjects where id = object_id(@MetaClassListSpName) and OBJECTPROPERTY(id, N''IsProcedure'') = 1)
		EXEC(''drop procedure '' + @MetaClassListSpName)
	IF @@ERROR <> 0 GOTO ERR

	COMMIT TRAN
	--PRINT(''COMMIT TRAN'')
RETURN

ERR:
	ROLLBACK TRAN
	--PRINT(''ROLLBACK TRAN'')
RETURN'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_DeleteMetaClass]    Script Date: 07/21/2009 17:26:29 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_DeleteMetaClass]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_DeleteMetaClass]
	@MetaClassId	INT
AS
BEGIN
	-- Step 0. Prepare
	SET NOCOUNT ON

	BEGIN TRAN

	DECLARE @MetaFieldOwnerTable	NVARCHAR(256)

	-- Check Childs Table
	IF EXISTS(SELECT *  FROM MetaClass MC WHERE ParentClassId = @MetaClassId)
	BEGIN
		RAISERROR (''The class have childs.'', 16, 1)
		GOTO ERR
	END

	-- Step 1. Find a TableName
	IF EXISTS(SELECT *  FROM MetaClass MC WHERE MetaClassId = @MetaClassId)
	BEGIN
		IF EXISTS(SELECT *  FROM MetaClass MC WHERE MetaClassId = @MetaClassId AND IsSystem = 0 AND IsAbstract = 0)
		BEGIN
			SELECT @MetaFieldOwnerTable = TableName  FROM MetaClass MC WHERE MetaClassId = @MetaClassId AND IsSystem = 0 AND IsAbstract = 0

			IF @@ERROR <> 0 GOTO ERR

			EXEC mdpsp_sys_DeleteMetaClassProcedure @MetaClassId

			IF @@ERROR <> 0 GOTO ERR

			-- Step 2. Delete Table
			EXEC(''DROP TABLE [dbo].['' + @MetaFieldOwnerTable + '']'')

			IF @@ERROR <> 0 GOTO ERR

			EXEC(''DROP TABLE [dbo].['' + @MetaFieldOwnerTable + ''_Localization]'')

				-- Delete Meta Dictionary Relations
			--DELETE FROM MetaMultiValueDictionary  WHERE MetaKey IN
			--	(SELECT MK.MetaKey FROM MetaKey MK WHERE MK.MetaClassId = @MetaClassId)

			-- IF @@ERROR <> 0 GOTO ERR

			-- Delete Meta File
			--DELETE FROM MetaFileValue  WHERE MetaKey IN
			--	(SELECT MK.MetaKey FROM MetaKey MK WHERE MK.MetaClassId = @MetaClassId)

			-- IF @@ERROR <> 0 GOTO ERR

			-- Delete Meta Key
			--DELETE FROM MetaKey WHERE MetaClassId = @MetaClassId

			EXEC mdpsp_sys_DeleteMetaKeyObjects @MetaClassId
			 IF @@ERROR <> 0 GOTO ERR

			-- Delete Meta Attribute
			EXEC mdpsp_sys_ClearMetaAttribute @MetaClassId, 1

			 IF @@ERROR <> 0 GOTO ERR

			-- Step 3. Delete MetaField Relations
			DELETE FROM MetaClassMetaFieldRelation WHERE MetaClassId = @MetaClassId

			IF @@ERROR <> 0 GOTO ERR

			-- Step 3. Delete MetaClass
			DELETE FROM MetaClass WHERE MetaClassId = @MetaClassId

			IF @@ERROR <> 0 GOTO ERR
		END
		ELSE
		BEGIN
			-- Delete Meta Attribute
			EXEC mdpsp_sys_ClearMetaAttribute @MetaClassId, 1

			 IF @@ERROR <> 0 GOTO ERR

			-- Step 3. Delete MetaField Relations
			DELETE FROM MetaClassMetaFieldRelation WHERE MetaClassId = @MetaClassId

			IF @@ERROR <> 0 GOTO ERR

			-- Step 3. Delete MetaField
			DELETE FROM MetaField WHERE SystemMetaClassId = @MetaClassId

			IF @@ERROR <> 0 GOTO ERR

			-- Step 3. Delete MetaClass
			DELETE FROM MetaClass WHERE MetaClassId = @MetaClassId

			IF @@ERROR <> 0 GOTO ERR

		END
	END
	ELSE
	BEGIN
		RAISERROR (''Wrong @MetaClassId.'', 16, 1)
		GOTO ERR
	END

	COMMIT TRAN
	RETURN

ERR:
	ROLLBACK TRAN
	RETURN
END'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_DeleteMetaDictionary]    Script Date: 07/21/2009 17:26:29 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_DeleteMetaDictionary]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_DeleteMetaDictionary]
	@MetaDictionaryId	INT
AS
BEGIN
	-- Step 0. Prepare
	SET NOCOUNT ON

	BEGIN TRAN

	IF NOT EXISTS(SELECT * FROM MetaDictionary WHERE MetaDictionaryId = @MetaDictionaryId)
	BEGIN
		RAISERROR (''Wrong @MetaDictionaryId.'', 16, 1)
		GOTO ERR
	END

	DELETE FROM MetaDictionary WHERE MetaDictionaryId = @MetaDictionaryId

	IF @@ERROR <> 0 GOTO ERR

	COMMIT TRAN
	RETURN
ERR:
	ROLLBACK TRAN
	RETURN @@Error
END'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_DeleteMetaField]    Script Date: 07/21/2009 17:26:29 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_DeleteMetaField]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_DeleteMetaField]
	@MetaFieldId	INT
AS
BEGIN
	-- Step 0. Prepare
	SET NOCOUNT ON

	BEGIN TRAN

	IF NOT EXISTS(SELECT * FROM MetaClassMetaFieldRelation WHERE MetaFieldId = @MetaFieldId)
	BEGIN
		-- Step 5. Delete Dictionary Record
		DELETE FROM MetaDictionary WHERE MetaFieldId = @MetaFieldId

		IF @@ERROR <> 0 GOTO ERR

		-- Step 5. Delete Field Info Record
		DELETE FROM MetaField WHERE MetaFieldId = @MetaFieldId

		IF @@ERROR <> 0 GOTO ERR

		EXEC mdpsp_sys_ClearMetaAttribute @MetaFieldId, 2

		IF @@ERROR <> 0 GOTO ERR
	END
	ELSE
	BEGIN
		RAISERROR (''The MetaClass have got a link to @MetaFieldId.'', 16, 1)
		GOTO ERR
	END

	COMMIT TRAN
	RETURN
ERR:
	ROLLBACK TRAN
	RETURN @@Error
END'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_DeleteMetaFile]    Script Date: 07/21/2009 17:26:30 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_DeleteMetaFile]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_DeleteMetaFile]
	@MetaKey	INT
AS
	SET NOCOUNT ON
	DELETE FROM MetaFileValue WHERE MetaKey = @MetaKey'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_DeleteMetaObjectValue]    Script Date: 07/21/2009 17:26:30 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_DeleteMetaObjectValue]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_DeleteMetaObjectValue]
	@MetaKey	INT
AS
	SET NOCOUNT ON
	DELETE FROM MetaObjectValue WHERE MetaKey = @MetaKey'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_DeleteMetaRule]    Script Date: 07/21/2009 17:26:30 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_DeleteMetaRule]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_DeleteMetaRule]
	@RuleId	INT
AS
	SET NOCOUNT ON

	DELETE FROM MetaRule WHERE RuleId=@RuleId

	SET NOCOUNT OFF'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_FullTextQueriesActivate] ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_FullTextQueriesActivate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_FullTextQueriesActivate]
AS
BEGIN
	declare @statement nvarchar(4000)
	declare @CatalogName sysname
	set @CatalogName = ''MetaDataFullTextQueriesCatalog'';

	if (not exists (select * from sys.fulltext_catalogs where name = @CatalogName))
	begin
		set @statement = ''create fulltext catalog '' + @CatalogName
		execute dbo.sp_executesql @statement
	end
END'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_FullTextQueriesIndexUpdate] ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_FullTextQueriesIndexUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[mdpsp_sys_FullTextQueriesIndexUpdate]
	@TableName sysname,
	@KeyName sysname,
	@ColumnName sysname,
	@Add bit
as
begin
	declare @statement nvarchar(4000)
	declare @CatalogName sysname
	set @CatalogName = ''MetaDataFullTextQueriesCatalog''

	declare @CatalogId int
	select @CatalogId = fulltext_catalog_id from sys.fulltext_catalogs where name = @CatalogName

	if @Add = 1
	begin
		-- Add the column to full text indexing.

		if (not exists(select * from sys.fulltext_indexes where object_id = OBJECT_ID(@TableName)))
		begin
			-- the table is not indexed. create the index.
			set @statement = ''create fulltext index on ['' + @TableName + ''] key index ['' + @KeyName + ''] on '' + @CatalogName
			execute dbo.sp_executesql @statement
		end

		if (not exists(
			select *
			from sys.fulltext_index_columns ftic
			join sys.columns c on ftic.object_id = c.object_id and ftic.column_id = c.column_id
			where c.object_id = OBJECT_ID(@TableName) and c.name = @ColumnName))
		begin
			-- the column is not indexed. add the column to the index.
			set @statement = ''alter fulltext index on ['' + @TableName + ''] add (['' + @ColumnName + ''])''
			execute dbo.sp_executesql @statement
		end

		if ((select is_enabled from sys.fulltext_indexes where object_id = OBJECT_ID(@TableName)) != 1)
		begin
			-- the index is not enabled.
			set @statement = ''alter fulltext index on ['' + @TableName + ''] enable''
			execute dbo.sp_executesql @statement
		end

		if ((select change_tracking_state from sys.fulltext_indexes where object_id = OBJECT_ID(@TableName)) != ''A'')
		begin
			-- the index is not in auto mode.
			set @statement = ''alter fulltext index on ['' + @TableName + ''] set change_tracking auto''
			execute dbo.sp_executesql @statement
		end
	end
	else
	begin
		-- Remove the column from full text indexing.

		if (exists(
			select *
			from sys.fulltext_index_columns ftic
			join sys.columns c on ftic.object_id = c.object_id and ftic.column_id = c.column_id
			where c.object_id = OBJECT_ID(@TableName) and c.name = @ColumnName))
		begin
			-- the column is indexed. remove the column from the index.
			set @statement = ''alter fulltext index on ['' + @TableName + ''] drop (['' + @ColumnName + ''])''
			execute dbo.sp_executesql @statement
		end

		if (exists(select * from sys.fulltext_indexes where object_id = OBJECT_ID(@TableName))
		    and not exists(select * from sys.fulltext_index_columns where object_id = OBJECT_ID(@TableName)))
		begin
			-- no columns are indexed on the table. remove the index.
			set @statement = ''drop fulltext index on ['' + @TableName + '']''
			execute dbo.sp_executesql @statement
		end
	end
end'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_FullTextQueriesFieldUpdate] ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_FullTextQueriesFieldUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[mdpsp_sys_FullTextQueriesFieldUpdate]
	@MetaClassId int,
	@MetaFieldId int,
	@Add bit
as
begin
	declare @statement nvarchar(4000)
	declare @CatalogName sysname
	set @CatalogName = ''MetaDataFullTextQueriesCatalog''

	declare @TableName nvarchar(256)
	declare @KeyName nvarchar(256)
	declare @ColumnName nvarchar(256)
	select
		@TableName = TableName,
		@KeyName = PrimaryKeyName
	from MetaClass
	where MetaClassId = @MetaClassId

	select @ColumnName = Name
	from MetaField
	where MetaFieldId = @MetaFieldId
	  and (@Add = 0 or DataTypeId in (select DataTypeId from MetaDataType where SqlName in (N''char'', N''nchar'', N''varchar'', N''nvarchar'', N''text'', N''ntext'')))


	if (@TableName is not null and @KeyName is not null and @ColumnName is not null)
	begin
		exec dbo.mdpsp_sys_FullTextQueriesIndexUpdate @TableName, @KeyName, @ColumnName, @Add

		set @TableName = @TableName + ''_Localization''
		set @KeyName = null
		select @KeyName = CONSTRAINT_NAME
		from INFORMATION_SCHEMA.TABLE_CONSTRAINTS
		where TABLE_NAME = @TableName
		  and CONSTRAINT_TYPE != ''FOREIGN KEY''
		if @KeyName is not null exec dbo.mdpsp_sys_FullTextQueriesIndexUpdate @TableName, @KeyName, @ColumnName, @Add
	end
end'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_FullTextQueriesAddAllFields] ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_FullTextQueriesAddAllFields]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[mdpsp_sys_FullTextQueriesAddAllFields]
as
begin
	declare @MetaClassId int
	declare @MetaFieldId int
	declare searchable_fields_cursor cursor local for
		select mcmfr.MetaClassId, mcmfr.MetaFieldId
		from MetaClassMetaFieldRelation mcmfr
		join MetaField mf on mcmfr.MetaFieldId = mf.MetaFieldId
		where (mf.SystemMetaClassId = 0 or mf.SystemMetaClassId = mcmfr.MetaClassId)
	   -- and mf.AllowSearch = 1  ** REMOVED: Adding a meta field always adds it to the index, ignoring AllowSearch.  Removing this check is incorrect, but is consistent with how the system behaved before the fulltext update.


	open searchable_fields_cursor
	fetch next from searchable_fields_cursor into @MetaClassId, @MetaFieldId
	while @@FETCH_STATUS = 0
	begin
		execute dbo.mdpsp_sys_FullTextQueriesFieldUpdate @MetaClassId, @MetaFieldId, 1
		fetch next from searchable_fields_cursor into @MetaClassId, @MetaFieldId
	end

	close searchable_fields_cursor
	deallocate searchable_fields_cursor
end'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_FullTextQueriesDeleteAllFields] ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_FullTextQueriesDeleteAllFields]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[mdpsp_sys_FullTextQueriesDeleteAllFields]
as
begin
	declare @CatalogName sysname
	set @CatalogName = ''MetaDataFullTextQueriesCatalog''

	declare @TableName sysname
	declare @ColumnName sysname
	declare indexed_column_cursor cursor local for
		select tabs.name, cols.name
		from sys.fulltext_catalogs ftc
		join sys.fulltext_indexes fti on fti.fulltext_catalog_id = ftc.fulltext_catalog_id
		join sys.fulltext_index_columns ftic on fti.object_id = ftic.object_id
		join sys.objects tabs on ftic.object_id = tabs.object_id
		join sys.columns cols on ftic.object_id = cols.object_id and ftic.column_id = cols.column_id
		where ftc.name = @CatalogName

	open indexed_column_cursor
	fetch next from indexed_column_cursor into @TableName, @ColumnName
	while (@@FETCH_STATUS = 0)
	begin
		exec dbo.mdpsp_sys_FullTextQueriesIndexUpdate @TableName, '''', @ColumnName, 0
		fetch next from indexed_column_cursor into @TableName, @ColumnName
	end

	close indexed_column_cursor
	deallocate indexed_column_cursor
end'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_FullTextQueriesDeactivate] ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_FullTextQueriesDeactivate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[mdpsp_sys_FullTextQueriesDeactivate]
as
begin
	declare @statement nvarchar(4000)
	declare @CatalogName sysname
	set @CatalogName = ''MetaDataFullTextQueriesCatalog''

	exec dbo.mdpsp_sys_FullTextQueriesDeleteAllFields
	if (exists(select * from sys.fulltext_catalogs where name = @CatalogName))
	begin
		set @statement = ''drop fulltext catalog '' + @CatalogName
		execute dbo.sp_executesql @statement
	end
end'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_FullTextQueriesEnable] ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_FullTextQueriesEnable]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[mdpsp_sys_FullTextQueriesEnable]
as
begin
	declare @IsFullTextInstalled int
	declare @IsFulltextEnabled int
	select @IsFullTextInstalled = FULLTEXTSERVICEPROPERTY(''IsFullTextInstalled'')
	if (@IsFullTextInstalled = 1) select @IsFulltextEnabled = DatabaseProperty (DB_NAME(DB_ID()), ''IsFulltextEnabled'')

	select case when @IsFullTextInstalled = 1 and @IsFulltextEnabled = 1 then 1 else 0 end
end'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_FullTextQueriesRepopulateAll] ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_FullTextQueriesRepopulateAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[mdpsp_sys_FullTextQueriesRepopulateAll]
as
begin
	declare @statement nvarchar(4000)
	declare @CatalogName sysname
	set @CatalogName = ''MetaDataFullTextQueriesCatalog''

	declare @TableName sysname
	declare fulltext_index_cursor cursor local for
		select o.[name] as TableName
		from sys.fulltext_catalogs c
		join sys.fulltext_indexes i on c.[fulltext_catalog_id] = i.[fulltext_catalog_id]
		join sys.all_objects o on i.[object_id] = o.[object_id]
		where c.[name] = @CatalogName

	alter fulltext catalog MetaDataFullTextQueriesCatalog rebuild

	open fulltext_index_cursor
	fetch next from fulltext_index_cursor into @TableName
	while (@@FETCH_STATUS = 0)
	begin
		set @statement = ''alter fulltext index on ['' + @TableName + ''] start full population''
		execute dbo.sp_executesql @statement

		fetch next from fulltext_index_cursor into @TableName
	end

	close fulltext_index_cursor
	deallocate fulltext_index_cursor
end'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_FullTextQueriesRepopulateCatalogScheduleDelete] ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_FullTextQueriesRepopulateCatalogScheduleDelete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[mdpsp_sys_FullTextQueriesRepopulateCatalogScheduleDelete]
AS
begin
	declare @ecf5_job_name nvarchar(100)
	set @ecf5_job_name = N''ECF50_''+db_name()

	if (exists(select job_id from msdb.dbo.sysjobs where name = @ecf5_job_name))
	begin
		exec msdb.dbo.sp_delete_job @job_name = @ecf5_job_name
	end
end'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_FullTextQueriesRepopulateCatalogScheduleCreate] ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_FullTextQueriesRepopulateCatalogScheduleCreate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[mdpsp_sys_FullTextQueriesRepopulateCatalogScheduleCreate]
AS
begin
    -- the scheduled task is no longer be needed.
	exec dbo.mdpsp_sys_FullTextQueriesRepopulateCatalogScheduleDelete
end'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_AddMetaField]    Script Date: 07/21/2009 17:26:33 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_AddMetaField]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_AddMetaField]
	@Namespace 		NVARCHAR(1024) = N''Mediachase.MetaDataPlus.User'',
	@Name		NVARCHAR(256),
	@FriendlyName	NVARCHAR(256),
	@Description	NTEXT,
	@DataTypeId	INT,
	@Length	INT,
	@AllowNulls	BIT,
	@MultiLanguageValue BIT,
	@AllowSearch	BIT,
	@IsEncrypted	BIT,
	@Retval 	INT OUTPUT
AS
BEGIN
	-- Step 0. Prepare
	SET NOCOUNT ON
	SET @Retval = -1

    BEGIN TRAN
	    DECLARE @DataTypeVariable	INT
	    DECLARE @DataTypeLength	INT

	    SELECT @DataTypeVariable = Variable, @DataTypeLength = Length FROM MetaDataType WHERE DataTypeId = @DataTypeId

	    IF (@Length <= 0 OR @Length > @DataTypeLength )
		    SET @Length = @DataTypeLength

	    -- Step 2. Insert a record in to MetaField table.
	    INSERT INTO [MetaField]  ([Namespace], [Name], [FriendlyName], [Description], [DataTypeId], [Length], [AllowNulls],  [MultiLanguageValue], [AllowSearch], [IsEncrypted])
		    VALUES(@Namespace, @Name,  @FriendlyName, @Description, @DataTypeId, @Length, @AllowNulls, @MultiLanguageValue, @AllowSearch, @IsEncrypted)

	    IF @@ERROR <> 0 GOTO ERR

	    SET @Retval = IDENT_CURRENT(''[MetaField]'')

	    COMMIT TRAN
    RETURN

ERR:
	SET @Retval = -1
	ROLLBACK TRAN
    RETURN
END'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_AddMetaFieldToMetaClass]    Script Date: 07/21/2009 17:26:33 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_AddMetaFieldToMetaClass]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_AddMetaFieldToMetaClass]
	@MetaClassId	INT,
	@MetaFieldId	INT,
	@Weight	INT
AS
BEGIN
	-- Step 0. Prepare
	SET NOCOUNT ON

	DECLARE @IsAbstractClass	BIT
	SELECT @IsAbstractClass = IsAbstract FROM MetaClass WHERE MetaClassId = @MetaClassId

    BEGIN TRAN
	IF NOT EXISTS( SELECT * FROM MetaClass WHERE MetaClassId = @MetaClassId AND IsSystem = 0)
	BEGIN
		RAISERROR (''Wrong @MetaClassId. The class is system or not exists.'', 16,1)
		GOTO ERR
	END

	IF NOT EXISTS( SELECT * FROM MetaField WHERE MetaFieldId = @MetaFieldId AND SystemMetaClassId = 0)
	BEGIN
		RAISERROR (''Wrong @MetaFieldId. The field is system or not exists.'', 16,1)
		GOTO ERR
	END

	IF @IsAbstractClass = 0
	BEGIN
		-- Step 1. Insert a new column.
		DECLARE @Name		NVARCHAR(256)
		DECLARE @DataTypeId	INT
		DECLARE @Length		INT
		DECLARE @AllowNulls		BIT
		DECLARE @MultiLanguageValue BIT
		DECLARE @AllowSearch	BIT
		DECLARE @IsEncrypted	BIT

		SELECT @Name = [Name], @DataTypeId = DataTypeId,  @Length = [Length], @AllowNulls = AllowNulls, @MultiLanguageValue = MultiLanguageValue, @AllowSearch = AllowSearch, @IsEncrypted = IsEncrypted
		FROM [MetaField]
        WHERE MetaFieldId = @MetaFieldId AND SystemMetaClassId = 0

		-- Step 1-1. Create a new column query.

		DECLARE @MetaClassTableName NVARCHAR(256)
		DECLARE @SqlDataTypeName NVARCHAR(256)
		DECLARE @IsVariableDataType BIT
		DECLARE @DefaultValue	NVARCHAR(50)

		SELECT @MetaClassTableName = TableName FROM MetaClass WHERE MetaClassId = @MetaClassId

		IF @@ERROR<> 0 GOTO ERR

		SELECT @SqlDataTypeName = SqlName,  @IsVariableDataType = Variable, @DefaultValue = DefaultValue FROM MetaDataType WHERE DataTypeId= @DataTypeId

		IF @@ERROR<> 0 GOTO ERR

		DECLARE @ExecLine 			NVARCHAR(1024)
		DECLARE @ExecLineLocalization 	NVARCHAR(1024)

		SET @ExecLine = ''ALTER TABLE [dbo].[''+@MetaClassTableName+''] ADD [''+@Name+''] '' + @SqlDataTypeName
		SET @ExecLineLocalization = ''ALTER TABLE [dbo].[''+@MetaClassTableName+''_Localization] ADD [''+@Name+''] '' + @SqlDataTypeName

		IF @IsVariableDataType = 1
		BEGIN
			SET @ExecLine = @ExecLine + '' ('' + STR(@Length) + '')''
			SET @ExecLineLocalization = @ExecLineLocalization + '' ('' + STR(@Length) + '')''
		END
		ELSE
		BEGIN
			IF @DataTypeId = 5 OR @DataTypeId = 24
			BEGIN
				DECLARE @MdpPrecision NVARCHAR(10)
				DECLARE @MdpScale NVARCHAR(10)

				SET @MdpPrecision = NULL
				SET @MdpScale = NULL

				SELECT @MdpPrecision = [Value] FROM MetaAttribute
				WHERE
					AttrOwnerId = @MetaFieldId AND
					AttrOwnerType = 2 AND
					[Key] = ''MdpPrecision''

				SELECT @MdpScale = [Value] FROM MetaAttribute
				WHERE
					AttrOwnerId = @MetaFieldId AND
					AttrOwnerType = 2 AND
					[Key] = ''MdpScale''

				IF @MdpPrecision IS NOT NULL AND @MdpScale IS NOT NULL
				BEGIN
					SET @ExecLine = @ExecLine + '' ('' + @MdpPrecision + '','' + @MdpScale + '')''
					SET @ExecLineLocalization = @ExecLineLocalization + '' ('' + @MdpPrecision + '','' + @MdpScale + '')''
				END
			END
		END

		SET @ExecLineLocalization = @ExecLineLocalization + '' NULL''

		IF @AllowNulls = 1
		BEGIN
			SET @ExecLine = @ExecLine + '' NULL''
		END
		ELSE
			BEGIN
				SET @ExecLine = @ExecLine + '' NOT NULL DEFAULT '' + @DefaultValue

				--IF @IsVariableDataType = 1
				--BEGIN
					--SET @ExecLine = @ExecLine + '' ('' + STR(@Length) + '')''
				--END

				SET @ExecLine = @ExecLine  +''  WITH VALUES''
			END

		--PRINT (@ExecLine)

		-- Step 1-2. Create a new column.
		EXEC (@ExecLine)

		IF @@ERROR<> 0 GOTO ERR

		-- Step 1-3. Create a new localization column.
		EXEC (@ExecLineLocalization)

		IF @@ERROR <> 0 GOTO ERR
	END

	-- Step 2. Insert a record in to MetaClassMetaFieldRelation table.
	INSERT INTO [MetaClassMetaFieldRelation] (MetaClassId, MetaFieldId, Weight) VALUES(@MetaClassId, @MetaFieldId, @Weight)

	IF @@ERROR <> 0 GOTO ERR

	IF @IsAbstractClass = 0
	BEGIN
		EXEC mdpsp_sys_CreateMetaClassProcedure @MetaClassId

		IF @@ERROR <> 0 GOTO ERR
	END

	--EXEC mdpsp_sys_FullTextQueriesFieldUpdate @MetaClassId, @MetaFieldId,1

	--IF @@ERROR <> 0 GOTO ERR

	COMMIT TRAN

	IF @IsAbstractClass = 0 AND @@TRANCOUNT = 0
	BEGIN
		-- execute outside transaction
		EXEC mdpsp_sys_FullTextQueriesFieldUpdate @MetaClassId, @MetaFieldId,1
	END
    RETURN

ERR:
	ROLLBACK TRAN
    RETURN
END'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_DeleteMetaFieldFromMetaClass]    Script Date: 01/15/2013 14:46:20 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_DeleteMetaFieldFromMetaClass]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_DeleteMetaFieldFromMetaClass]
	@MetaClassId	INT,
	@MetaFieldId	INT
AS
BEGIN
	IF NOT EXISTS(SELECT * FROM MetaClassMetaFieldRelation WHERE MetaFieldId = @MetaFieldId AND MetaClassId = @MetaClassId)
	BEGIN
		--RAISERROR (''Wrong @MetaFieldId and @MetaClassId.'', 16, 1)
		-- GOTO ERR
		RETURN
	END

	-- Step 0. Prepare
	SET NOCOUNT ON

	DECLARE @MetaFieldName NVARCHAR(256)
	DECLARE @MetaFieldOwnerTable NVARCHAR(256)
	DECLARE @BaseMetaFieldOwnerTable NVARCHAR(256)
	DECLARE @IsAbstractClass BIT

	-- Step 1. Find a Field Name
	-- Step 2. Find a TableName
	IF NOT EXISTS(SELECT * FROM MetaField MF WHERE MetaFieldId = @MetaFieldId AND SystemMetaClassId = 0 )
	BEGIN
		RAISERROR (''Wrong @MetaFieldId.'', 16, 1)
		GOTO ERR
	END

	SELECT @MetaFieldName = MF.[Name] FROM MetaField MF WHERE MetaFieldId = @MetaFieldId AND SystemMetaClassId = 0

	IF NOT EXISTS(SELECT * FROM MetaClass MC WHERE MetaClassId = @MetaClassId AND IsSystem = 0)
	BEGIN
		RAISERROR (''Wrong @MetaClassId.'', 16, 1)
		GOTO ERR
	END

	SELECT @BaseMetaFieldOwnerTable = MC.TableName, @IsAbstractClass = MC.IsAbstract FROM MetaClass MC
		WHERE MetaClassId = @MetaClassId AND IsSystem = 0

	SET @MetaFieldOwnerTable = @BaseMetaFieldOwnerTable

	 IF @@ERROR <> 0 GOTO ERR

	IF @IsAbstractClass = 0
	BEGIN
		-- need to remove full text indexes before removing item
		EXEC mdpsp_sys_FullTextQueriesFieldUpdate @MetaClassId, @MetaFieldId, 0
	END

	BEGIN TRAN

	IF @IsAbstractClass = 0
	BEGIN
		EXEC mdpsp_sys_DeleteMetaKeyObjects @MetaClassId, @MetaFieldId
		 IF @@ERROR <> 0 GOTO ERR

		-- Delete Meta Dictionary Relations
		--DELETE FROM MetaMultiValueDictionary  WHERE MetaKey IN
		--	(SELECT MK.MetaKey FROM MetaKey MK WHERE MK.MetaFieldId = @MetaFieldId AND MK.MetaClassId = @MetaClassId)

		-- IF @@ERROR <> 0 GOTO ERR

		-- Delete Meta File
		--DELETE FROM MetaFileValue  WHERE MetaKey IN
		--	(SELECT MK.MetaKey FROM MetaKey MK WHERE MK.MetaFieldId = @MetaFieldId AND MK.MetaClassId = @MetaClassId)

		-- IF @@ERROR <> 0 GOTO ERR

		--DELETE FROM MetaKey WHERE MetaFieldId = @MetaFieldId AND MetaClassId = @MetaClassId

		-- IF @@ERROR <> 0 GOTO ERR

		-- Step 3. Delete Constrains
		EXEC mdpsp_sys_DeleteDContrainByTableAndField @MetaFieldOwnerTable, @MetaFieldName

		IF @@ERROR <> 0 GOTO ERR

		-- Step 4. Delete Field
		EXEC (''ALTER TABLE [''+@MetaFieldOwnerTable+''] DROP COLUMN ['' + @MetaFieldName + '']'')

		IF @@ERROR <> 0 GOTO ERR

		-- Update 2007/10/05: Remove meta field from Localization table (if table exists)
		SET @MetaFieldOwnerTable = @BaseMetaFieldOwnerTable + ''_Localization''

		if exists (select * from dbo.sysobjects where id = object_id(@MetaFieldOwnerTable) and OBJECTPROPERTY(id, N''IsUserTable'') = 1)
		begin
			-- a). Delete constraints
			EXEC mdpsp_sys_DeleteDContrainByTableAndField @MetaFieldOwnerTable, @MetaFieldName
			-- a). Drop column
			EXEC (''ALTER TABLE [''+@MetaFieldOwnerTable+''] DROP COLUMN ['' + @MetaFieldName + '']'')
		end
	END

	-- Step 5. Delete Field Info Record
	DELETE FROM MetaClassMetaFieldRelation WHERE MetaFieldId = @MetaFieldId AND MetaClassId = @MetaClassId
	IF @@ERROR <> 0 GOTO ERR

	IF @IsAbstractClass = 0
	BEGIN
		EXEC mdpsp_sys_CreateMetaClassProcedure @MetaClassId

		IF @@ERROR <> 0 GOTO ERR

		--EXEC mdpsp_sys_FullTextQueriesFieldUpdate @MetaClassId, @MetaFieldId, 0

		--IF @@ERROR <> 0 GOTO ERR
	END

	COMMIT TRAN
	RETURN
ERR:
	ROLLBACK TRAN

	-- readd indexes if error occured
	IF @IsAbstractClass = 0
	BEGIN
		EXEC mdpsp_sys_FullTextQueriesFieldUpdate @MetaClassId, @MetaFieldId, 1
	END

	RETURN @@Error
END'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_GetMetaKey]    Script Date: 07/21/2009 17:26:33 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_GetMetaKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_GetMetaKey]
	@MetaObjectId	INT,
	@MetaClassId	INT,
	@MetaFieldId	INT,
	@Language NVARCHAR(20) = NULL,
	@Retval	INT	OUT
AS
	SET NOCOUNT ON

	IF @Language IS NULL
	BEGIN
		IF EXISTS(SELECT * FROM MetaKey WHERE MetaObjectId = @MetaObjectId AND MetaClassId = @MetaClassId AND MetaFieldId = @MetaFieldId AND Language IS NULL)
		BEGIN
			SELECT @RetVal = MetaKey FROM MetaKey WHERE MetaObjectId = @MetaObjectId AND MetaClassId = @MetaClassId AND MetaFieldId = @MetaFieldId
		END
		ELSE
		BEGIN
			INSERT INTO MetaKey (MetaObjectId, MetaClassId, MetaFieldId) VALUES (@MetaObjectId, @MetaClassId, @MetaFieldId)
			SET @Retval = SCOPE_IDENTITY()
		END
	END
	ELSE
	BEGIN
		IF EXISTS(SELECT * FROM MetaKey WHERE MetaObjectId = @MetaObjectId AND MetaClassId = @MetaClassId AND MetaFieldId = @MetaFieldId AND Language=@Language)
		BEGIN
			SELECT @RetVal = MetaKey FROM MetaKey WHERE MetaObjectId = @MetaObjectId AND MetaClassId = @MetaClassId AND MetaFieldId = @MetaFieldId AND Language=@Language
		END
		ELSE
		BEGIN
			INSERT INTO MetaKey (MetaObjectId, MetaClassId, MetaFieldId, Language) VALUES (@MetaObjectId, @MetaClassId, @MetaFieldId, @Language)
			SET @Retval = SCOPE_IDENTITY()
		END
	END'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_GetMetaKeyInfo]    Script Date: 07/21/2009 17:26:34 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_GetMetaKeyInfo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_GetMetaKeyInfo]
	@MetaKey	INT
AS
	SET NOCOUNT ON
	SELECT * FROM MetaKey WHERE MetaKey = @MetaKey'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_GetUniqueFieldName]    Script Date: 07/21/2009 17:26:34 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_GetUniqueFieldName]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_GetUniqueFieldName]
	@Name		NVARCHAR(256),
	@UniqueName 	NVARCHAR(256) OUT
AS
	SET NOCOUNT OFF

	DECLARE	@Index		INT

	SET @UniqueName	= @Name
	SET @Index = (SELECT COUNT(*) FROM MetaField WHERE SystemMetaClassId = 0 AND Name LIKE @Name + ''[0123456789]%'')

	WHILE (SELECT COUNT(*) FROM MetaField WHERE SystemMetaClassId = 0 AND Name=@UniqueName) <> 0
	BEGIN
		SET @UniqueName = @Name + CAST(@Index  AS NVARCHAR(32))
		SET @Index = @Index + 1
	END'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadChildMetaClassList]    Script Date: 07/21/2009 17:26:34 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadChildMetaClassList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_LoadChildMetaClassList]
	@MetaClassId	INT
AS
	SELECT MetaClassId, Namespace,Name, [FriendlyName], IsSystem, IsAbstract, ParentClassId, TableName, Description, FieldListChangedSqlScript, Tag
	FROM MetaClass WHERE ParentClassId = @MetaClassId'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaAttributes]    Script Date: 07/21/2009 17:26:35 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaAttributes]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_LoadMetaAttributes]
	@AttrOwnerId		INT,
	@AttrOwnerType	INT
AS
	SELECT [Key], [Value] FROM MetaAttribute WHERE AttrOwnerId = @AttrOwnerId AND AttrOwnerType = @AttrOwnerType'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaClassById]    Script Date: 07/21/2009 17:26:35 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaClassById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_LoadMetaClassById]
	@MetaClassId	INT
AS
	SELECT MetaClassId, Namespace, Name, FriendlyName, IsSystem, IsAbstract, ParentClassId, TableName, Description, FieldListChangedSqlScript, Tag
	FROM MetaClass WHERE MetaClassId = @MetaClassId'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaClassByName]    Script Date: 07/21/2009 17:26:35 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaClassByName]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_LoadMetaClassByName]
	@Name		NVARCHAR(256)
AS
	SELECT MetaClassId, Namespace, Name, FriendlyName, IsSystem, IsAbstract,ParentClassId, TableName, Description, FieldListChangedSqlScript, Tag
	FROM MetaClass WHERE Name = @Name'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaClassByNamespace]    Script Date: 07/21/2009 17:26:35 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaClassByNamespace]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_LoadMetaClassByNamespace]
	@Namespace		NVARCHAR(1024),
	@Deep			BIT
AS
	IF @Deep = 1
		SELECT MetaClassId, Namespace, Name, FriendlyName, IsSystem, IsAbstract, ParentClassId, TableName, Description, FieldListChangedSqlScript, Tag
		FROM MetaClass WHERE  Namespace = @Namespace OR Namespace LIKE (@Namespace + ''.%'')
	ELSE
		SELECT MetaClassId, Namespace, Name, FriendlyName, IsSystem, IsAbstract, ParentClassId, TableName, Description, FieldListChangedSqlScript, Tag
		FROM MetaClass WHERE Namespace = @Namespace'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaClassList]    Script Date: 07/21/2009 17:26:36 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaClassList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_LoadMetaClassList]
AS

SELECT C.MetaClassId, C.Namespace, C.[Name], C.FriendlyName, C.IsSystem, C.IsAbstract, C.ParentClassId, C.TableName, C.[Description], C.FieldListChangedSqlScript, C.Tag,
	P.[Name] AS ParentName, P.TableName AS ParentTableName, P.FriendlyName AS ParentFriendlyName
  FROM MetaClass C
	LEFT JOIN MetaClass P ON (C.ParentClassId = P.MetaClassId)'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaClassListByMetaField]    Script Date: 07/21/2009 17:26:36 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaClassListByMetaField]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_LoadMetaClassListByMetaField]
	@MetaFieldId	INT
AS
	SELECT MC.MetaClassId, MC.Namespace, MC.Name, MC.FriendlyName, MC.IsSystem,  MC.IsAbstract, MC.ParentClassId, MC.TableName, MC.Description, MC.FieldListChangedSqlScript, MC.Tag
	FROM MetaClass MC
	INNER JOIN MetaClassMetaFieldRelation MCFR ON MCFR.MetaClassId = MC.MetaClassId
	WHERE MCFR.MetaFieldId = @MetaFieldId'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaDictionary]    Script Date: 07/21/2009 17:26:36 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaDictionary]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_LoadMetaDictionary]
	@MetaFieldId	INT,
	@Language	NVARCHAR(20)=NULL
AS
	DECLARE @MultiLanguageValue BIT

	SELECT @MultiLanguageValue = MultiLanguageValue FROM MetaField
	WHERE MetaFieldId = @MetaFieldId

	IF @Language IS NOT NULL AND @MultiLanguageValue = 1
	BEGIN
		SELECT MD.MetaDictionaryId, MD.MetaFieldId, MD.[Value] as DefaultValue,  MDL.Value  as Value, MDL.Tag as Tag
		FROM MetaDictionary MD
			LEFT JOIN MetaDictionaryLocalization MDL ON MDL.MetaDictionaryId = MD.MetaDictionaryId
		WHERE MD.MetaFieldId = @MetaFieldId AND MDL.Language = @Language
	END
	ELSE
	BEGIN
		SELECT MetaDictionaryId, MetaFieldId, [Value] as DefaultValue, Tag as DefaultTag, [Value] as Value, Tag as Tag
		FROM MetaDictionary
		WHERE MetaFieldId = @MetaFieldId
	END'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaField]    Script Date: 07/21/2009 17:26:37 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaField]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_LoadMetaField]
	@MetaFieldId	INT
AS
BEGIN
	SELECT [MetaFieldId] , [Namespace], [Name], [FriendlyName], [Description], [SystemMetaClassId], [DataTypeId],[Length],[AllowNulls],[MultiLanguageValue], [AllowSearch], [Tag], [IsEncrypted]
	FROM MetaField WHERE MetaFieldId = @MetaFieldId
END'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaFieldByName]    Script Date: 07/21/2009 17:26:37 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaFieldByName]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_LoadMetaFieldByName]
	@Name		NVARCHAR(256)
AS
BEGIN
	SELECT [MetaFieldId] ,  [Namespace], [Name], [FriendlyName], [Description], [SystemMetaClassId], [DataTypeId],[Length],[AllowNulls],[MultiLanguageValue], [AllowSearch], [Tag], [IsEncrypted]
	FROM MetaField WHERE  [Name] = @Name	AND SystemMetaClassId = 0
END'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaFieldByNamespace]    Script Date: 07/21/2009 17:26:37 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaFieldByNamespace]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_LoadMetaFieldByNamespace]
	@Namespace		NVARCHAR(1024),
	@Deep			BIT
AS
BEGIN
	IF @Deep = 1
		SELECT [MetaFieldId], [Namespace], [Name], [FriendlyName], [Description], [SystemMetaClassId], [DataTypeId], [Length], [AllowNulls], [MultiLanguageValue], [AllowSearch], [Tag], [IsEncrypted]
		FROM MetaField WHERE Namespace = @Namespace OR Namespace LIKE (@Namespace + ''.%'')
	ELSE
		SELECT [MetaFieldId], [Namespace], [Name], [FriendlyName], [Description], [SystemMetaClassId], [DataTypeId], [Length], [AllowNulls], [MultiLanguageValue], [AllowSearch], [Tag], [IsEncrypted]
		FROM MetaField WHERE Namespace = @Namespace
END'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaFieldList]    Script Date: 07/21/2009 17:26:37 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaFieldList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_LoadMetaFieldList]
AS
BEGIN
	SELECT [MetaFieldId], [Namespace], [Name], [FriendlyName], [Description], [SystemMetaClassId], [DataTypeId], [Length], [AllowNulls], [MultiLanguageValue], [AllowSearch], [Tag], [IsEncrypted]
	FROM MetaField
END'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaFieldListByMetaClassId]    Script Date: 07/21/2009 17:26:38 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaFieldListByMetaClassId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create procedure [dbo].[mdpsp_sys_LoadMetaFieldListByMetaClassId]
    @MetaClassId int
as
begin
    select
        mf.[MetaFieldId],
        mf.[Namespace],
        mf.[Name],
        mf.[FriendlyName],
        mf.[Description],
        mf.[SystemMetaClassId],
        mf.[DataTypeId],
        mf.[Length],
        mf.[AllowNulls],
        mf.[MultiLanguageValue],
        mf.[AllowSearch],
        mf.[Tag],
        mf.[IsEncrypted],
        cfr.[Weight],
        cfr.[Enabled],
        cast(case when mf.SystemMetaClassId = 0 then ROW_NUMBER() over (partition by mf.SystemMetaClassId order by mf.Name)
            else null end as int) as ParameterIndex
    from MetaField mf
    join MetaClassMetaFieldRelation cfr ON cfr.MetaFieldId = mf.MetaFieldId
    where cfr.MetaClassId = @MetaClassId
    order by mf.IsKeyField desc, cfr.[Weight]
end'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaFieldWeight]    Script Date: 07/21/2009 17:26:38 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaFieldWeight]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_LoadMetaFieldWeight]
	@MetaClassId	INT,
	@MetaFieldId	INT
AS
	IF NOT EXISTS(	SELECT * FROM MetaClassMetaFieldRelation WHERE MetaClassId = @MetaClassId AND MetaFieldId = @MetaFieldId)
		RAISERROR (''Wrong @MetaClassId or @MetaFieldId.'', 16,1)

	SELECT Weight, Enabled FROM MetaClassMetaFieldRelation WHERE MetaClassId = @MetaClassId AND MetaFieldId = @MetaFieldId'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaFile]    Script Date: 07/21/2009 17:26:38 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaFile]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_LoadMetaFile]
	@MetaKey	INT
AS
	SELECT MetaKey, [FileName], ContentType, Data, CreationTime, LastWriteTime, LastReadTime FROM MetaFileValue WHERE MetaKey = @MetaKey'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaFileList]    Script Date: 07/21/2009 17:26:39 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaFileList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_LoadMetaFileList]
 AS
	SELECT MetaKey, [FileName], ContentType, Data, CreationTime, LastWriteTime, LastReadTime FROM MetaFileValue'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaObjectValue]    Script Date: 07/21/2009 17:26:39 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaObjectValue]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_LoadMetaObjectValue]
	@MetaKey	INT
AS
	SELECT MetaKey, MetaClassId, MetaObjectId  FROM MetaObjectValue WHERE MetaKey = @MetaKey'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaRuleById]    Script Date: 07/21/2009 17:26:39 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaRuleById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_LoadMetaRuleById]
	@RuleId	INT
AS
	SELECT RuleId, MetaClassId, Data FROM MetaRule
	WHERE RuleId = @RuleId'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaRuleByMetaClassId]    Script Date: 07/21/2009 17:26:39 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaRuleByMetaClassId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_LoadMetaRuleByMetaClassId]
	@MetaClassId	INT
AS
	SELECT RuleId, MetaClassId, Data FROM MetaRule
	WHERE MetaClassId = @MetaClassId'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaStringDictionary]    Script Date: 07/21/2009 17:26:40 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaStringDictionary]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_LoadMetaStringDictionary]
	@MetaKey	INT
AS
	SELECT MetaKey, [Key],[Value] FROM MetaStringDictionaryValue WHERE MetaKey = @MetaKey'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaType]    Script Date: 07/21/2009 17:26:40 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaType]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_LoadMetaType]
	@MetaTypeId	INT
AS
	SELECT DataTypeId, Name, FriendlyName, Description, Length, SqlName, AllowNulls, Variable, IsSQLCommonType FROM MetaDataType WHERE
		DataTypeId = @MetaTypeId'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMetaTypeList]    Script Date: 07/21/2009 17:26:40 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMetaTypeList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_LoadMetaTypeList]
AS
	SELECT DataTypeId, [Name], FriendlyName, [Description], Length, SqlName, AllowNulls, Variable, IsSQLCommonType FROM MetaDataType
'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_LoadMultiValueDictionary]    Script Date: 07/21/2009 17:26:41 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_LoadMultiValueDictionary]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_LoadMultiValueDictionary]
	@MetaKey	INT
AS

	SELECT MD.MetaDictionaryId, MD.MetaFieldId, MD.[Value] FROM MetaDictionary MD
		INNER JOIN MetaMultiValueDictionary  MVD ON MVD.MetaDictionaryId = MD.MetaDictionaryId
		WHERE MVD.MetaKey = @MetaKey'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_MetaFieldAllowSearch]    Script Date: 07/21/2009 17:26:41 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_MetaFieldAllowSearch]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE dbo.mdpsp_sys_MetaFieldAllowSearch
    @MetaFieldId int,
    @AllowSearch bit,
    @UpdateFullTextIndexes bit
as
begin
    set nocount on

    if not exists (select 1 from MetaField where MetaFieldId = @MetaFieldId)
    begin
        raiserror(''The specified meta field does not exists or is a system field.'', 16,1)
    end
    else
    begin
        update MetaField
        set AllowSearch = @AllowSearch
        where MetaFieldId = @MetaFieldId

        if @UpdateFullTextIndexes = 1
        begin
            declare @metaClassId int
            declare class_w_search cursor local for
                select mc.MetaClassId
                from MetaClass mc
                join MetaClassMetaFieldRelation mcmfr on mc.MetaClassId = mcmfr.MetaClassId
                join MetaField mf on mcmfr.MetaFieldId = mf.MetaFieldId
                where mf.MetaFieldId = @MetaFieldId and (mc.IsSystem = 1 or mf.SystemMetaClassId = 0)
            open class_w_search
            while 1=1
            begin
                fetch next from class_w_search into @metaClassId
                if @@FETCH_STATUS != 0 break

                exec dbo.mdpsp_sys_FullTextQueriesFieldUpdate @metaClassId, @MetaFieldId, @AllowSearch
            end
            close class_w_search
            deallocate class_w_search
        end
    end
end'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_MetaFieldAllowMultiLanguage]    Script Date: 07/21/2009 17:26:41 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_MetaFieldAllowMultiLanguage]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_MetaFieldAllowMultiLanguage]
	@MetaFieldId 	INT,
	@MultiLanguageValue	BIT
AS
	SET NOCOUNT ON

	BEGIN TRAN

	IF NOT EXISTS( SELECT * FROM MetaField WHERE MetaFieldId = @MetaFieldId)
	BEGIN
		RAISERROR (''Wrong @MetaFieldId. The field is system or not exists.'', 16,1)
		GOTO ERR
	END

	UPDATE MetaField SET MultiLanguageValue = @MultiLanguageValue WHERE MetaFieldId = @MetaFieldId

	DECLARE class_w_search CURSOR FOR
		SELECT MCMFR.MetaClassId FROM MetaClassMetaFieldRelation MCMFR
			INNER JOIN MetaField MF ON MF.MetaFieldId = MCMFR.MetaFieldId
			INNER JOIN MetaClass MC ON MC.MetaClassId = MCMFR.MetaClassId
		WHERE MCMFR.MetaFieldId = @MetaFieldId AND (MC.IsSystem = 1 OR MF.SystemMetaClassId = 0 )

	DECLARE @MetaClassId INT

	OPEN class_w_search
	FETCH NEXT FROM class_w_search INTO @MetaClassId

	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC mdpsp_sys_CreateMetaClassProcedure @MetaClassId

		IF @@ERROR <> 0
		BEGIN
			CLOSE class_w_search
			DEALLOCATE class_w_search

			GOTO ERR
		END

		FETCH NEXT FROM class_w_search INTO @MetaClassId
	END

	CLOSE class_w_search
	DEALLOCATE class_w_search

	COMMIT TRAN

RETURN

ERR:
	ROLLBACK TRAN
RETURN'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_MetaFieldIsEncrypted]    Script Date: 07/21/2009 17:26:41 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_MetaFieldIsEncrypted]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_MetaFieldIsEncrypted]
	@MetaFieldId 	INT,
	@IsEncrypted	BIT
AS
	SET NOCOUNT ON

	BEGIN TRAN

	IF NOT EXISTS( SELECT * FROM MetaField WHERE MetaFieldId = @MetaFieldId)
	BEGIN
		RAISERROR (''Wrong @MetaFieldId. The field is system or not exists.'', 16,1)
		GOTO ERR
	END

	UPDATE MetaField SET IsEncrypted = @IsEncrypted WHERE MetaFieldId = @MetaFieldId

	DECLARE class_w_search CURSOR FOR
		SELECT MCMFR.MetaClassId FROM MetaClassMetaFieldRelation MCMFR
			INNER JOIN MetaField MF ON MF.MetaFieldId = MCMFR.MetaFieldId
			INNER JOIN MetaClass MC ON MC.MetaClassId = MCMFR.MetaClassId
		WHERE MCMFR.MetaFieldId = @MetaFieldId AND (MC.IsSystem = 1 OR MF.SystemMetaClassId = 0 )

	DECLARE @MetaClassId INT

	OPEN class_w_search
	FETCH NEXT FROM class_w_search INTO @MetaClassId

	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC mdpsp_sys_CreateMetaClassProcedure @MetaClassId

		IF @@ERROR <> 0
		BEGIN
			CLOSE class_w_search
			DEALLOCATE class_w_search

			GOTO ERR
		END

		FETCH NEXT FROM class_w_search INTO @MetaClassId
	END

	CLOSE class_w_search
	DEALLOCATE class_w_search

	COMMIT TRAN

RETURN

ERR:
	ROLLBACK TRAN
RETURN'
END
GO
/****** Object:  StoredProcedure [dbo].[mdpsp_sys_RefreshSystemMetaClassInfo]    Script Date: 07/21/2009 17:26:42 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_RefreshSystemMetaClassInfo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_RefreshSystemMetaClassInfo]
	@MetaClassId	INT
AS
	SET NOCOUNT ON
BEGIN
    BEGIN TRAN
	DECLARE @TableName NVARCHAR(256)
	DECLARE @Namespace NVARCHAR(1024)
	DECLARE @Name NVARCHAR(256)

	IF NOT EXISTS( SELECT * FROM MetaClass WHERE MetaClassId = @MetaClassId AND IsSystem = 1)
	BEGIN
		RAISERROR (''Wrong @MetaClassId. The class is neither system nor existed.'', 16,1)
		GOTO ERR
	END

	SELECT @Name = [Name], @TableName = TableName, @Namespace = Namespace FROM MetaClass WHERE MetaClassId = @MetaClassId AND IsSystem = 1

	-- Step 1. Remove old fields
	DELETE FROM MetaClassMetaFieldRelation WHERE MetaClassId = @MetaClassId
	IF @@ERROR<> 0 GOTO ERR

	DELETE FROM MetaClassMetaFieldRelation WHERE MetaFieldId IN (SELECT MetaFieldId FROM MetaField WHERE SystemMetaClassId = @MetaClassId)
	IF @@ERROR<> 0 GOTO ERR

	DELETE FROM MetaField WHERE SystemMetaClassId = @MetaClassId
	IF @@ERROR<> 0 GOTO ERR

	-- Step 2. Create new fields
	INSERT INTO [MetaField]  ([Namespace], [Name], [FriendlyName], [SystemMetaClassId], [DataTypeId], [Length], [AllowNulls], [MultiLanguageValue], [AllowSearch], [IsEncrypted])
	SELECT @Namespace + N''.'' + @Name, SC.[name], SC.[name], @MetaClassId, MDT.[DataTypeId], SC.[length], SC.[isnullable], 0, 0, 0
    FROM SYSCOLUMNS AS SC
	INNER JOIN SYSOBJECTS SO ON SO.[ID] = SC.ID
	INNER JOIN SYSTYPES ST ON ST.[xtype] = SC .[xtype]
	INNER JOIN MetaDataType MDT ON MDT.[Name] = ST .[name]
    WHERE SO.[ID]  = object_id( @TableName) and OBJECTPROPERTY( SO.[ID], N''IsTable'') = 1 and ST.name<>''sysname''
	ORDER BY COLORDER /* Aug 29, 2006 */

	IF @@ERROR<> 0 GOTO ERR

	INSERT INTO [MetaClassMetaFieldRelation] (MetaClassId, MetaFieldId)
	SELECT @MetaClassId, MetaFieldId FROM MetaField WHERE [SystemMetaClassId] = @MetaClassId

	IF @@ERROR<> 0 GOTO ERR

	-- Step 3. Update child-field relations
	INSERT INTO [MetaClassMetaFieldRelation]  (MetaClassId, MetaFieldId)
	SELECT MC.MetaClassId, MF.MetaFieldId FROM MetaField MF, MetaClass MC
	WHERE MF.[SystemMetaClassId] = @MetaClassId AND MC.ParentClassId = @MetaClassId ORDER BY MC.MetaClassId

	IF @@ERROR<> 0 GOTO ERR

	COMMIT TRAN
	--PRINT(''COMMIT TRAN'')
    RETURN

ERR:
	ROLLBACK TRAN
	--PRINT(''ROLLBACK TRAN'')
    RETURN
END'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_RefreshSystemMetaClassInfoAll]    Script Date: 07/21/2009 17:26:42 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_RefreshSystemMetaClassInfoAll]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_RefreshSystemMetaClassInfoAll]
AS
SET NOCOUNT ON
BEGIN TRAN
	DECLARE classall_cursor CURSOR FOR
		SELECT MetaClassId FROM MetaClass WHERE IsSystem =1

	DECLARE @MetaClassId	INT

	OPEN classall_cursor
	FETCH NEXT FROM classall_cursor INTO @MetaClassId

	WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT @MetaClassId
		EXEC  mdpsp_sys_RefreshSystemMetaClassInfo @MetaClassId
		IF @@ERROR <> 0 GOTO ERR

	FETCH NEXT FROM classall_cursor INTO @MetaClassId
	END

	CLOSE classall_cursor
	DEALLOCATE classall_cursor

	COMMIT TRAN
RETURN

ERR:
	CLOSE classall_cursor
	DEALLOCATE classall_cursor

	ROLLBACK TRAN
RETURN'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_ReplaceUser]    Script Date: 07/21/2009 17:26:43 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_ReplaceUser]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_ReplaceUser]
	@OldUserId AS nvarchar(100),
	@NewUserId AS nvarchar(100)
AS
BEGIN
    SET NOCOUNT ON
    BEGIN TRAN
	DECLARE classall_cursor CURSOR FOR
		SELECT MetaClassId, TableName FROM MetaClass WHERE IsSystem =0 AND IsAbstract = 0

	DECLARE @MetaClassId	INT
	DECLARE @TableName		NVARCHAR(255)

	OPEN classall_cursor
	FETCH NEXT FROM classall_cursor INTO @MetaClassId, @TableName

	DECLARE @SQLString NVARCHAR(500)

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @SQLString  = N''UPDATE '' + @TableName  + '' SET CreatorId = @NewUserId WHERE CreatorId = @OldUserId''
		EXEC sp_executesql @SQLString, N''@OldUserId AS nvarchar(100), @NewUserId AS nvarchar(100)'', @OldUserId = @OldUserId, @NewUserId = @NewUserId
		IF @@ERROR <> 0 GOTO ERR

		SET @SQLString  = N''UPDATE '' + @TableName  + '' SET ModifierId = @NewUserId WHERE ModifierId = @OldUserId''
		EXEC sp_executesql @SQLString, N''@OldUserId AS nvarchar(100), @NewUserId AS nvarchar(100)'', @OldUserId = @OldUserId, @NewUserId = @NewUserId
		IF @@ERROR <> 0 GOTO ERR

	    FETCH NEXT FROM classall_cursor INTO @MetaClassId, @TableName
	END

	CLOSE classall_cursor
	DEALLOCATE classall_cursor

	COMMIT TRAN
    RETURN

ERR:
	CLOSE classall_cursor
	DEALLOCATE classall_cursor

	ROLLBACK TRAN
    RETURN
END'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_UpdateMetaClass]    Script Date: 07/21/2009 17:26:43 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_UpdateMetaClass]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_UpdateMetaClass]
	@MetaClassId 	INT,
	@Namespace		NVARCHAR(1024),
	@Name			NVARCHAR(256),
	@FriendlyName		NVARCHAR(256),
	@Description		NTEXT,
	@Tag			IMAGE
AS
	UPDATE MetaClass SET Namespace = @Namespace, Name = @Name, FriendlyName = @FriendlyName, Description = @Description, Tag = @Tag WHERE MetaClassId = @MetaClassId'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_UpdateMetaDictionary]    Script Date: 07/21/2009 17:26:43 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_UpdateMetaDictionary]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_UpdateMetaDictionary]
	@MetaDictionaryId	INT,
	@Language	NVARCHAR(20)=NULL,
	@DefaultValue	NVARCHAR(2048),
	@DefaultTag	IMAGE=NULL,
	@Value		NVARCHAR(2048),
	@Tag		IMAGE=NULL
AS
	SET NOCOUNT ON

BEGIN TRAN
	DECLARE @MultiLanguageValue BIT

	SELECT @MultiLanguageValue = MultiLanguageValue FROM MetaField MF
	INNER JOIN MetaDictionary MD ON MD.MetaFieldId = MF.MetaFieldId
	WHERE MD.MetaDictionaryId = @MetaDictionaryId

	IF NOT EXISTS(SELECT * FROM MetaDictionary WHERE MetaDictionaryId = @MetaDictionaryId )
	BEGIN
		RAISERROR(''Wrong @MetaDictionaryId.'',16,1)
		GOTO ERR
	END

	IF @MultiLanguageValue = 1
	BEGIN
		UPDATE MetaDictionary SET [Value] = @DefaultValue, [Tag] = @DefaultTag   WHERE MetaDictionaryId = @MetaDictionaryId
		IF @@ERROR <> 0 GOTO ERR

		IF @Language IS NOT NULL
		BEGIN
			IF EXISTS(SELECT * FROM MetaDictionaryLocalization WHERE MetaDictionaryId = @MetaDictionaryId AND Language = @Language)
				UPDATE MetaDictionaryLocalization SET Value = @Value, Tag = @Tag WHERE MetaDictionaryId = @MetaDictionaryId AND Language = @Language
			ELSE
				INSERT INTO MetaDictionaryLocalization (MetaDictionaryId, Language,  Value, Tag) VALUES (@MetaDictionaryId, @Language, @Value, @Tag)
			IF @@ERROR <> 0 GOTO ERR
		END
	END
	ELSE
	BEGIN
		UPDATE MetaDictionary SET [Value] = @Value, [Tag] = @Tag   WHERE MetaDictionaryId = @MetaDictionaryId
		IF @@ERROR <> 0 GOTO ERR
	END

	COMMIT TRAN
RETURN

ERR:
	ROLLBACK TRAN
RETURN
'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_UpdateMetaField]    Script Date: 07/21/2009 17:26:43 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_UpdateMetaField]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_UpdateMetaField]
	@MetaFieldId 	INT,
	@Namespace 	NVARCHAR(1024) = N''Mediachase.MetaDataPlus.User'',
	@FriendlyName	NVARCHAR(256),
	@Description	NTEXT,
	@Tag		IMAGE
AS
	UPDATE MetaField SET Namespace = @Namespace, FriendlyName = @FriendlyName, Description = @Description, Tag = @Tag WHERE MetaFieldId = @MetaFieldId'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_UpdateMetaFieldEnabled]    Script Date: 07/21/2009 17:26:44 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_UpdateMetaFieldEnabled]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE PROCEDURE [dbo].[mdpsp_sys_UpdateMetaFieldEnabled]
	@MetaClassId	INT,
	@MetaFieldId	INT,
	@Enabled	BIT
AS
	IF NOT EXISTS(	SELECT * FROM MetaClassMetaFieldRelation WHERE MetaClassId = @MetaClassId AND MetaFieldId = @MetaFieldId)
		RAISERROR (''Wrong @MetaClassId or @MetaFieldId.'', 16,1)
	ELSE
		UPDATE MetaClassMetaFieldRelation SET  Enabled = @Enabled WHERE MetaClassId = @MetaClassId AND MetaFieldId = @MetaFieldId



'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_UpdateMetaFieldWeight]    Script Date: 07/21/2009 17:26:44 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_UpdateMetaFieldWeight]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'




CREATE PROCEDURE [dbo].[mdpsp_sys_UpdateMetaFieldWeight]
	@MetaClassId	INT,
	@MetaFieldId	INT,
	@Weight	INT
AS
	IF NOT EXISTS(	SELECT * FROM MetaClassMetaFieldRelation WHERE MetaClassId = @MetaClassId AND MetaFieldId = @MetaFieldId)
		RAISERROR (''Wrong @MetaClassId or @MetaFieldId.'', 16,1)
	ELSE
		UPDATE MetaClassMetaFieldRelation SET  Weight = @Weight WHERE MetaClassId = @MetaClassId AND MetaFieldId = @MetaFieldId



'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_UpdateMetaFile]    Script Date: 07/21/2009 17:26:44 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_UpdateMetaFile]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_UpdateMetaFile]
	@MetaKey	INT,
	@FileName	NVARCHAR(256),
	@ContentType	NVARCHAR(256),
	@Data		image,
	@Size		INT,
	@CreationTime	DATETIME,
	@LastWriteTime 	DATETIME,
	@LastReadTime	DATETIME
AS
	SET NOCOUNT ON

	IF (EXISTS(SELECT * FROM MetaFileValue WHERE MetaKey = @MetaKey) )
		UPDATE MetaFileValue SET [FileName] = @FileName, ContentType = @ContentType, Data = @Data, [Size] = @Size,
			CreationTime = @CreationTime, LastWriteTime = @LastWriteTime, LastReadTime = @LastReadTime WHERE MetaKey = @MetaKey
	ELSE
		INSERT INTO MetaFileValue (MetaKey,FileName,ContentType,Data, Size,CreationTime, LastWriteTime, LastReadTime )
			VALUES (@MetaKey,@FileName,@ContentType,@Data, @Size,@CreationTime, @LastWriteTime, @LastReadTime)'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_UpdateMetaObjectValue]    Script Date: 07/21/2009 17:26:45 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_UpdateMetaObjectValue]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_UpdateMetaObjectValue]
	@MetaKey	INT,
	@MetaClassId	INT,
	@MetaObjectId	INT
AS
	SET NOCOUNT ON

	IF (EXISTS(SELECT * FROM MetaObjectValue WHERE MetaKey = @MetaKey) )
		UPDATE MetaObjectValue SET MetaClassId = @MetaClassId, MetaObjectId = @MetaObjectId WHERE MetaKey = @MetaKey
	ELSE
		INSERT INTO MetaObjectValue (MetaKey,MetaClassId,MetaObjectId)
			VALUES (@MetaKey,@MetaClassId,@MetaObjectId)'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_UpdateMetaRule]    Script Date: 07/21/2009 17:26:45 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_UpdateMetaRule]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_UpdateMetaRule]
	@RuleId	INT,
	@MetaClassId	INT,
	@Data		IMAGE,
	@RetVal	INT	OUTPUT
AS
	SET NOCOUNT ON

	IF ((SELECT COUNT(*) FROM MetaRule WHERE RuleId=@RuleId) = 0)
	BEGIN
		INSERT INTO MetaRule(MetaClassId, Data) VALUES (@MetaClassId, @Data)

		IF @@ERROR <> 0 SET @RetVal = -1
		ELSE SET @RetVal = @@IDENTITY
	END
	ELSE
	BEGIN
		UPDATE MetaRule SET Data=@Data WHERE RuleId=@RuleId
		SET @RetVal = @RuleId
	END

	SET NOCOUNT OFF'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_UpdateMetaSqlScriptTemplate]    Script Date: 07/21/2009 17:26:45 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_UpdateMetaSqlScriptTemplate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'




CREATE PROCEDURE [dbo].[mdpsp_sys_UpdateMetaSqlScriptTemplate]
	@MetaClassId 	INT,
	@FieldListChanged	NTEXT
AS
	UPDATE MetaClass SET FieldListChangedSqlScript = @FieldListChanged WHERE MetaClassId = @MetaClassId



'
END
GO

/****** Object:  StoredProcedure [dbo].[mdpsp_sys_RotateEncryptionKeys]    Script Date: 07/21/2009 17:26:45 ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpsp_sys_RotateEncryptionKeys]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mdpsp_sys_RotateEncryptionKeys] AS
DECLARE @Query_tmp  nvarchar(max)

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRANSACTION

DECLARE @MetaClassTable NVARCHAR(256), @MetaFieldName NVARCHAR(256), @MultiLanguageValue BIT
DECLARE classall_cursor CURSOR FOR
	SELECT MF.Name, MF.MultiLanguageValue, MC.TableName FROM MetaField MF
		INNER JOIN MetaClassMetaFieldRelation MCFR ON MCFR.MetaFieldId = MF.MetaFieldId
		INNER JOIN MetaClass MC ON MC.MetaClassId = MCFR.MetaClassId
		WHERE MF.IsEncrypted = 1 AND MC.IsSystem = 0

--Open symmetric key
exec mdpsp_sys_OpenSymmetricKey

OPEN classall_cursor
	FETCH NEXT FROM classall_cursor INTO @MetaFieldName, @MultiLanguageValue, @MetaClassTable

--Decrypt meta values
WHILE(@@FETCH_STATUS = 0)
BEGIN

	IF @MultiLanguageValue = 0
		SET @Query_tmp = ''
			UPDATE ''+@MetaClassTable+''
				SET [''+@MetaFieldName+''] = dbo.mdpfn_sys_EncryptDecryptString([''+@MetaFieldName+''], 0)
				WHERE NOT ['' + @MetaFieldName + ''] IS NULL''
	ELSE
		SET @Query_tmp = ''
			UPDATE ''+@MetaClassTable+''_Localization
				SET [''+@MetaFieldName+''] = dbo.mdpfn_sys_EncryptDecryptString([''+@MetaFieldName+''], 0)
				WHERE NOT ['' + @MetaFieldName + ''] IS NULL''

	EXEC(@Query_tmp)

	IF @@ERROR <> 0 GOTO ERR

	FETCH NEXT FROM classall_cursor INTO @MetaFieldName, @MultiLanguageValue, @MetaClassTable
END

CLOSE classall_cursor

--Close symmetric key
exec mdpsp_sys_CloseSymmetricKey

--Recreate symmetric key
DROP SYMMETRIC KEY Mediachase_ECF50_MDP_Key
CREATE SYMMETRIC KEY Mediachase_ECF50_MDP_Key
	WITH ALGORITHM = AES_128 ENCRYPTION BY CERTIFICATE Mediachase_ECF50_MDP

--Open new symmetric key
exec mdpsp_sys_OpenSymmetricKey

OPEN classall_cursor
	FETCH NEXT FROM classall_cursor INTO @MetaFieldName, @MultiLanguageValue, @MetaClassTable

--Encrypt meta values
WHILE(@@FETCH_STATUS = 0)
BEGIN

	IF @MultiLanguageValue = 0
		SET @Query_tmp = ''
			UPDATE ''+@MetaClassTable+''
				SET [''+@MetaFieldName+''] = dbo.mdpfn_sys_EncryptDecryptString([''+@MetaFieldName+''], 1)
				WHERE NOT ['' + @MetaFieldName + ''] IS NULL''
	ELSE
		SET @Query_tmp = ''
			UPDATE ''+@MetaClassTable+''_Localization
				SET [''+@MetaFieldName+''] = dbo.mdpfn_sys_EncryptDecryptString([''+@MetaFieldName+''], 1)
				WHERE NOT ['' + @MetaFieldName + ''] IS NULL''

	EXEC(@Query_tmp)

	FETCH NEXT FROM classall_cursor INTO @MetaFieldName, @MultiLanguageValue, @MetaClassTable
END

CLOSE classall_cursor
DEALLOCATE classall_cursor

--Close new symmetric key
exec mdpsp_sys_CloseSymmetricKey

COMMIT TRAN
RETURN

ERR:
	ROLLBACK TRAN
RETURN'
END
GO

/****** Object:  UserDefinedFunction [dbo].[mdpfn_sys_EncryptDecryptString]    Script Date: 07/21/2009 17:26:46 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mdpfn_sys_EncryptDecryptString]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[mdpfn_sys_EncryptDecryptString]
(
	@input nvarchar(4000),
	@encrypt bit
)
RETURNS nvarchar(4000)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @RetVal nvarchar(4000)

	IF(@input = '''' OR @input IS NULL)
		RETURN @input

	IF(@encrypt = 1)
		SELECT @RetVal = CONVERT(nvarchar(4000), EncryptByKey(Key_GUID(''Mediachase_ECF50_MDP_Key''), @input) )
	ELSE
		SELECT @RetVal = CONVERT(nvarchar(4000), DecryptByKey(@input))

	RETURN @RetVal;

END'
END

GO


create trigger dbo.mdptr_sys_MetaField_IsKeyField
on MetaField after insert, update
as
begin
    set nocount on
    if update(SystemMetaClassId)
    begin
        update dst
		set IsKeyField = cast(case when exists(
                select 1
	            from MetaClass mc
	            join INFORMATION_SCHEMA.KEY_COLUMN_USAGE kcu on kcu.CONSTRAINT_NAME = mc.PrimaryKeyName and kcu.CONSTRAINT_SCHEMA = 'dbo'
	            where mc.MetaClassId = dst.SystemMetaClassId
	              and kcu.COLUMN_NAME = dst.Name)
	        then 1 else 0 end as bit)
		from MetaField dst
        where dst.MetaFieldId in (select i.MetaFieldId from inserted i)
        -- do not check for actual value change. updates to MetaClass.PrimaryKeyName will fire this
		-- trigger with "update MetaField set SystemMetaClassId=SystemMetaClassId".
    end
end
go


create trigger dbo.mdptr_sys_MetaClass_PrimaryKeyName
on MetaClass after insert, update
as
begin
    if update(PrimaryKeyName)
    begin
        update MetaField
        set SystemMetaClassId = SystemMetaClassId -- cause mdptr_sys_MetaField_IsKeyField to fire.
        where SystemMetaClassId in (
            select i.MetaClassId
            from inserted i
            left outer join deleted d on i.MetaClassId = d.MetaClassId
            where (d.MetaClassId is null or i.PrimaryKeyName != d.PrimaryKeyName))
    end
end
go

CREATE PROCEDURE [dbo].[mdpsp_GetChildBySegment]
	@parentId int,
	@UriSegment nvarchar(255)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    SELECT
    S.CatalogNodeId as ChildId,
    S.LanguageCode,
    1 as ContentType
    FROM CatalogItemSeo S WITH (NOLOCK) WHERE CatalogNodeId IN

    (SELECT DISTINCT N.CatalogNodeId from [CatalogNode] N WITH (NOLOCK)
        LEFT OUTER JOIN CatalogNodeRelation NR ON N.CatalogNodeId = NR.ChildNodeId
        WHERE
            (N.ParentNodeId = @parentId OR NR.ParentNodeId = @parentId) AND UriSegment = @UriSegment AND N.IsActive = 1)

    UNION

    SELECT
    S.CatalogEntryId as ChildId,
    S.LanguageCode,
    0 as ContentType
    from CatalogItemSeo S WITH (NOLOCK)
    INNER JOIN CatalogEntry N ON N.CatalogEntryId = S.CatalogEntryId
    INNER JOIN NodeEntryRelation R ON R.CatalogEntryId = N.CatalogEntryId
    WHERE
        R.CatalogNodeId = @parentId AND UriSegment = @UriSegment AND N.IsActive = 1
END
GO

create procedure dbo.mdpsp_sys_FullTextQueriesUpdateAllFields
as
begin
    declare @metaClassId int, @metaFieldId int, @allowSearch bit
    declare all_fields cursor local for
        select mc.MetaClassId, mf.MetaFieldId, mf.AllowSearch
        from dbo.MetaClass mc
        join dbo.MetaClassMetaFieldRelation mcmfr on mc.MetaClassId = mcmfr.MetaClassId
        join dbo.MetaField mf on mcmfr.MetaFieldId = mf.MetaFieldId
        order by AllowSearch desc, MetaClassId, MetaFieldId
    open all_fields
    while 1=1
    begin
        fetch next from all_fields into @metaClassId, @metaFieldId, @allowSearch
        if @@FETCH_STATUS != 0 break

        exec dbo.mdpsp_sys_FullTextQueriesFieldUpdate @metaClassId, @metaFieldId, @allowSearch
    end
    close all_fields
end
go

CREATE PROCEDURE mdpsp_sys_RegisterMetaFieldInSystemClass
-- Add the parameters for the stored procedure here
	@ClassName nvarchar(255),
	@TableName nvarchar(255),
	@Namespace nvarchar(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @ClassId int
	DECLARE @FieldName nvarchar(255)
	DECLARE @FriendlyFieldName nvarchar(255)
	DECLARE @DataTypeId int
	DECLARE @Length int
	DECLARE @Nullable bit
	DECLARE @DUMMY int

    SELECT @ClassId = [MetaClassId] FROM [MetaClass] WHERE [Name] = @ClassName

	DECLARE fieldCursor CURSOR FOR
		SELECT @Namespace+ N'.' + @ClassName, SC .[name] as Name , SC .[name] , @ClassId ,MDT .[DataTypeId], SC .[length], SC .[isnullable], 0, 0, 0, 0  FROM SYSCOLUMNS AS SC
			INNER JOIN SYSOBJECTS SO ON SO.[ID] = SC.[ID]
			INNER JOIN SYSTYPES ST ON ST.[xtype] = SC.[xtype]
			INNER JOIN MetaDataType MDT ON MDT.[Name] = ST.[name]
		WHERE SO.[ID]  = object_id( @TableName) and OBJECTPROPERTY( SO.[ID], N'IsTable') = 1 and ST.name<>'sysname' and SC .[name] NOT IN (SELECT MF.Name FROM [MetaField] MF WHERE SystemMetaClassId = @ClassId)
		ORDER BY COLORDER

	OPEN fieldCursor
	FETCH NEXT FROM fieldCursor INTO @Namespace, @FieldName, @FriendlyFieldName, @ClassId, @DataTypeId, @Length, @Nullable, @DUMMY, @DUMMY, @DUMMY, @DUMMY
	WHILE @@FETCH_STATUS = 0
		BEGIN
			PRINT 'Registering new MetaField' + @FieldName

			INSERT INTO [MetaField] ([Namespace], [Name], [FriendlyName], [SystemMetaClassId], [DataTypeId], [Length], [AllowNulls], [MultiLanguageValue], [AllowSearch], [IsEncrypted])
            VALUES (@Namespace, @FieldName, @FriendlyFieldName, @ClassId, @DataTypeId, @Length, @Nullable,  0, 0, 0)

            INSERT INTO [MetaClassMetaFieldRelation]  (MetaClassId, MetaFieldId)
					SELECT MC.[MetaClassId], @@IDENTITY FROM (
						SELECT [MetaClassId] FROM MetaClass WHERE ParentClassId = @ClassId UNION
						SELECT @ClassId
					) MC

			FETCH NEXT FROM fieldCursor INTO @Namespace, @FieldName, @FriendlyFieldName, @ClassId, @DataTypeId, @Length, @Nullable, @DUMMY, @DUMMY, @DUMMY, @DUMMY
		END
	CLOSE fieldCursor
	DEALLOCATE fieldCursor
END
GO
