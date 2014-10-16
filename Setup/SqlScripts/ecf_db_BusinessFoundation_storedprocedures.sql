/****** Object:  StoredProcedure [dbo].[GetBusinessFoundationSchemaVersionNumber]    Script Date: 07/21/2009 17:22:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetBusinessFoundationSchemaVersionNumber]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetBusinessFoundationSchemaVersionNumber]
GO

/****** Object:  StoredProcedure [dbo].[mc_blob_BlobStorageRemoveExpired]    Script Date: 07/21/2009 17:22:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mc_blob_BlobStorageRemoveExpired]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[mc_blob_BlobStorageRemoveExpired]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaClassDataSourceInsert]    Script Date: 05/13/2009 09:56:10 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaClassDataSourceInsert]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaClassDataSourceInsert]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaClassDataSourceUpdate]    Script Date: 05/13/2009 09:56:11 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaClassDataSourceUpdate]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaClassDataSourceUpdate]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaClassDataSourceDelete]    Script Date: 05/13/2009 09:56:09 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaClassDataSourceDelete]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaClassDataSourceDelete]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaClassDataSourceSelect]    Script Date: 05/13/2009 09:56:10 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaClassDataSourceSelect]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaClassDataSourceSelect]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaEnumInsert]    Script Date: 05/13/2009 09:56:15 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaEnumInsert]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaEnumInsert]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaEnumUpdate]    Script Date: 05/13/2009 09:56:17 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaEnumUpdate]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaEnumUpdate]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaEnumDelete]    Script Date: 05/13/2009 09:56:14 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaEnumDelete]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaEnumDelete]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaEnumSelect]    Script Date: 05/13/2009 09:56:16 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaEnumSelect]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaEnumSelect]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_ModuleInsert]    Script Date: 05/13/2009 09:56:36 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_ModuleInsert]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_ModuleInsert]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaFieldMapInsert]    Script Date: 05/13/2009 09:56:20 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaFieldMapInsert]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaFieldMapInsert]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_ModuleUpdate]    Script Date: 05/13/2009 09:56:36 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_ModuleUpdate]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_ModuleUpdate]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaFieldMapUpdate]    Script Date: 05/13/2009 09:56:21 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaFieldMapUpdate]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaFieldMapUpdate]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_ModuleDelete]    Script Date: 05/13/2009 09:56:35 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_ModuleDelete]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_ModuleDelete]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaFieldMapDelete]    Script Date: 05/13/2009 09:56:19 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaFieldMapDelete]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaFieldMapDelete]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaEnumSelectMaxId]    Script Date: 05/13/2009 09:56:16 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaEnumSelectMaxId]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaEnumSelectMaxId]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_ModuleSelect]    Script Date: 05/13/2009 09:56:36 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_ModuleSelect]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_ModuleSelect]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaFieldMapSelect]    Script Date: 05/13/2009 09:56:20 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaFieldMapSelect]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaFieldMapSelect]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaFieldInsert]    Script Date: 05/13/2009 09:56:18 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaFieldInsert]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaFieldInsert]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaFieldUpdate]    Script Date: 05/13/2009 09:56:25 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaFieldUpdate]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaFieldUpdate]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaFieldDelete]    Script Date: 05/13/2009 09:56:17 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaFieldDelete]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaFieldDelete]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaFieldSelect]    Script Date: 05/13/2009 09:56:21 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaFieldSelect]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaFieldSelect]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaFieldTypeInsert]    Script Date: 05/13/2009 09:56:22 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaFieldTypeInsert]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaFieldTypeInsert]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaFieldTypeUpdate]    Script Date: 05/13/2009 09:56:24 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaFieldTypeUpdate]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaFieldTypeUpdate]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaFieldTypeDelete]    Script Date: 05/13/2009 09:56:21 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaFieldTypeDelete]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaFieldTypeDelete]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaFieldTypeSelect]    Script Date: 05/13/2009 09:56:23 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaFieldTypeSelect]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaFieldTypeSelect]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaViewInsert]    Script Date: 05/13/2009 09:56:33 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaViewInsert]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaViewInsert]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaFileDelete]    Script Date: 05/13/2009 09:56:26 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaFileDelete]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaFileDelete]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaViewUpdate]    Script Date: 05/13/2009 09:56:35 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaViewUpdate]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaViewUpdate]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaFileInsert]    Script Date: 05/13/2009 09:56:26 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaFileInsert]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaFileInsert]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaViewDelete]    Script Date: 05/13/2009 09:56:32 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaViewDelete]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaViewDelete]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaFileSelect]    Script Date: 05/13/2009 09:56:26 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaFileSelect]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaFileSelect]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaViewSelect]    Script Date: 05/13/2009 09:56:33 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaViewSelect]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaViewSelect]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaFileUpdate]    Script Date: 05/13/2009 09:56:27 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaFileUpdate]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaFileUpdate]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaIdentifierDelete]    Script Date: 05/13/2009 09:56:27 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaIdentifierDelete]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaIdentifierDelete]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaIdentifierInsert]    Script Date: 05/13/2009 09:56:28 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaIdentifierInsert]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaIdentifierInsert]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaClassInsert]    Script Date: 05/13/2009 09:56:12 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaClassInsert]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaClassInsert]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaIdentifierSelect]    Script Date: 05/13/2009 09:56:28 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaIdentifierSelect]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaIdentifierSelect]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaClassUpdate]    Script Date: 05/13/2009 09:56:14 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaClassUpdate]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaClassUpdate]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaIdentifierUpdate]    Script Date: 05/13/2009 09:56:29 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaIdentifierUpdate]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaIdentifierUpdate]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaClassDelete]    Script Date: 05/13/2009 09:56:11 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaClassDelete]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaClassDelete]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaLinkDelete]    Script Date: 05/13/2009 09:56:29 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaLinkDelete]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaLinkDelete]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaClassSelect]    Script Date: 05/13/2009 09:56:13 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaClassSelect]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaClassSelect]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaLinkInsert]    Script Date: 05/13/2009 09:56:30 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaLinkInsert]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaLinkInsert]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaLinkSelect]    Script Date: 05/13/2009 09:56:30 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaLinkSelect]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaLinkSelect]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaLinkUpdate]    Script Date: 05/13/2009 09:56:31 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaLinkUpdate]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaLinkUpdate]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaModelVersionIdSelect]    Script Date: 05/13/2009 09:56:31 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaModelVersionIdSelect]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaModelVersionIdSelect]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaModelVersionIdUpdate]    Script Date: 05/13/2009 09:56:31 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaModelVersionIdUpdate]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_MetaModelVersionIdUpdate]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_SelectedEnumValueDelete]    Script Date: 05/13/2009 09:56:37 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_SelectedEnumValueDelete]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_SelectedEnumValueDelete]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_SelectedEnumValueInsert]    Script Date: 05/13/2009 09:56:37 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_SelectedEnumValueInsert]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_SelectedEnumValueInsert]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_SelectedEnumValueSelect]    Script Date: 05/13/2009 09:56:38 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_SelectedEnumValueSelect]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_SelectedEnumValueSelect]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_SelectedEnumValueUpdate]    Script Date: 05/13/2009 09:56:38 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_SelectedEnumValueUpdate]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_SelectedEnumValueUpdate]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_TmpMetaFileCleanUp]    Script Date: 05/13/2009 09:56:39 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_TmpMetaFileCleanUp]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_TmpMetaFileCleanUp]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_TmpMetaFileDelete]    Script Date: 05/13/2009 09:56:39 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_TmpMetaFileDelete]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_TmpMetaFileDelete]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_TmpMetaFileInsert]    Script Date: 05/13/2009 09:56:40 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_TmpMetaFileInsert]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_TmpMetaFileInsert]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_TmpMetaFileMove]    Script Date: 05/13/2009 09:56:40 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_TmpMetaFileMove]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_TmpMetaFileMove]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_TmpMetaFileSelect]    Script Date: 05/13/2009 09:56:41 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_TmpMetaFileSelect]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_mcmd_TmpMetaFileSelect]
GO
/****** Object:  StoredProcedure [dbo].[mc_tempsp_List]    Script Date: 05/13/2009 09:56:41 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_tempsp_List]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_tempsp_List]
GO
/****** Object:  StoredProcedure [dbo].[mc_tempsp_RemoveAll]    Script Date: 05/13/2009 09:56:41 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_tempsp_RemoveAll]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_tempsp_RemoveAll]
GO
/****** Object:  StoredProcedure [dbo].[mc_tempsp_Remove]    Script Date: 05/13/2009 09:56:41 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_tempsp_Remove]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_tempsp_Remove]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcweb_ListViewProfileInsert]    ******/
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_mcweb_ListViewProfileInsert]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
DROP PROCEDURE [dbo].[mc_mcweb_ListViewProfileInsert]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcweb_ListViewProfileUpdate]    ******/
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_mcweb_ListViewProfileUpdate]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
DROP PROCEDURE [dbo].[mc_mcweb_ListViewProfileUpdate]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcweb_ListViewProfileDelete]    ******/
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_mcweb_ListViewProfileDelete]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
DROP PROCEDURE [dbo].[mc_mcweb_ListViewProfileDelete]
GO
/****** Object:  StoredProcedure [dbo].[mc_mcweb_ListViewProfileSelect]    ******/
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_mcweb_ListViewProfileSelect]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
DROP PROCEDURE [dbo].[mc_mcweb_ListViewProfileSelect]
GO
/****** Object:  StoredProcedure [dbo].[GetBusinessFoundationSchemaVersionNumber]    Script Date: 07/21/2009 17:22:57 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetBusinessFoundationSchemaVersionNumber]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetBusinessFoundationSchemaVersionNumber]
AS
	with PatchVersion (Major, Minor, Patch) as
		(SELECT max([Major]) as Major,
			max([Minor]) as Minor,
			max([Patch]) as Patch
			FROM [SchemaVersion_BusinessFoundation]),
	PatchDate (Major, Minor, Patch, InstallDate) as 
		(SELECT Major, Minor, Patch, InstallDate from [SchemaVersion_BusinessFoundation])
	SELECT PD.Major as Major, PD.Minor as Minor, PD.Patch as Patch, PD.InstallDate as InstallDate 
		FROM PatchDate PD, PatchVersion PV 
		WHERE PD.[Major]=PV.[Major] AND 
			PD.[Minor]=PV.[Minor] AND 
			PD.[Patch]=PV.[Patch]' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaEnumSelectMaxId]    Script Date: 05/13/2009 09:56:16 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaEnumSelectMaxId]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaEnumSelectMaxId]
(
@TypeName nvarchar(255)
)
AS
SELECT Max([Id])
FROM mcmd_MetaEnum
WHERE
[TypeName] = @TypeName' 
END
GO

/****** Object:  StoredProcedure [dbo].[mc_tempsp_List]    Script Date: 05/13/2009 09:56:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_tempsp_List]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[mc_tempsp_List]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT name, crdate FROM dbo.[sysobjects]
	WHERE 
	name like N''tempsp_%'' AND 
	OBJECTPROPERTY(id, N''IsProcedure'') = 1
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[mc_tempsp_RemoveAll]    Script Date: 05/13/2009 09:56:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_tempsp_RemoveAll]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[mc_tempsp_RemoveAll]
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @SpName NVARCHAR(255)
	DECLARE @DelQuery NVARCHAR(512)

	DECLARE TempSpList_Cursor CURSOR FOR
	SELECT name FROM dbo.sysobjects 
	WHERE 
		name like N''tempsp_%'' AND 
		OBJECTPROPERTY(id, N''sProcedure'') = 1

	OPEN TempSpList_Cursor

	FETCH NEXT FROM TempSpList_Cursor 
	INTO @SpName

	WHILE @@FETCH_STATUS = 0
	   BEGIN
			SET @DelQuery = N''DROP PROCEDURE [dbo].['' + @SpName +N'']''
			--PRINT @DelQuery
			EXECUTE sp_executesql @DelQuery

			FETCH NEXT FROM TempSpList_Cursor 
			INTO @SpName
	   END

	CLOSE TempSpList_Cursor;
	DEALLOCATE TempSpList_Cursor;
END

' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_tempsp_Remove]    Script Date: 05/13/2009 09:56:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_tempsp_Remove]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_tempsp_Remove]
	@ExpirationDate DateTime
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @SpName NVARCHAR(255)
	DECLARE @DelQuery NVARCHAR(512)

	DECLARE TempSpList_Cursor CURSOR FOR
	SELECT name FROM dbo.sysobjects 
	WHERE 
		crdate <= @ExpirationDate AND
		name like N''tempsp_%'' AND 
		OBJECTPROPERTY(id, N''IsProcedure'') = 1

	OPEN TempSpList_Cursor

	FETCH NEXT FROM TempSpList_Cursor 
	INTO @SpName

	WHILE @@FETCH_STATUS = 0
	   BEGIN
			SET @DelQuery = N''DROP PROCEDURE [dbo].['' + @SpName +N'']''
			--PRINT @DelQuery
			EXECUTE sp_executesql @DelQuery

			FETCH NEXT FROM TempSpList_Cursor 
			INTO @SpName
	   END

	CLOSE TempSpList_Cursor;
	DEALLOCATE TempSpList_Cursor;
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[mc_mcmd_TmpMetaFileMove]    Script Date: 05/13/2009 09:56:40 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_TmpMetaFileMove]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_TmpMetaFileMove] 
	@FileUid uniqueidentifier
AS
            SET NOCOUNT ON

	INSERT INTO mcmd_MetaFile (FileUID, [FileName], Body)
	SELECT FileUID, [FileName], Body FROM mcmd_TmpMetaFile WHERE FileUID=@FileUID

	DELETE FROM mcmd_TmpMetaFile WHERE FileUID=@FileUID' 
END
GO

/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaFileDelete]    Script Date: 05/13/2009 09:56:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaFileDelete]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaFileDelete]
(
@FileId int
)
AS
    SET NOCOUNT ON
DELETE FROM [mcmd_MetaFile]
WHERE
[FileId] = @FileId
RETURN @@Error' 
END
GO

/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaFileInsert]    Script Date: 05/13/2009 09:56:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaFileInsert]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaFileInsert]
(
@FileId int = NULL OUTPUT,
@FileUID uniqueidentifier,
@FileName nvarchar(510)
)
AS
    SET NOCOUNT ON
INSERT INTO [mcmd_MetaFile]
(
[FileUID],
[FileName])
VALUES(
@FileUID,
@FileName)
SELECT @FileId = SCOPE_IDENTITY();
RETURN @@Error' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaFileSelect]    Script Date: 05/13/2009 09:56:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaFileSelect]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaFileSelect]
(
@FileId int
)
AS
    SET NOCOUNT ON
SELECT [FileId],
[FileUID],
[FileName],
[Body],
DATALENGTH(Body) as Length FROM mcmd_MetaFile
WHERE
[FileId] = @FileId' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaFileUpdate]    Script Date: 05/13/2009 09:56:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaFileUpdate]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaFileUpdate]
(
@FileId int,
@FileUID uniqueidentifier,
@FileName nvarchar(510)
)
AS
    SET NOCOUNT ON
UPDATE [mcmd_MetaFile]
SET
[FileUID] = @FileUID,
[FileName] = @FileName
WHERE
[FileId] = @FileId
RETURN @@Error' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaIdentifierDelete]    Script Date: 05/13/2009 09:56:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaIdentifierDelete]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaIdentifierDelete]
(
@IdentifierId int
)
AS
    SET NOCOUNT ON
DELETE FROM [mcmd_MetaIdentifier]
WHERE
[IdentifierId] = @IdentifierId
RETURN @@Error' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaIdentifierInsert]    Script Date: 05/13/2009 09:56:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaIdentifierInsert]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaIdentifierInsert]
(
@IdentifierId int = NULL OUTPUT,
@Value nvarchar(510) OUTPUT,
@PeriodKey varchar(10),
@TypeName nvarchar(100),
@MetaClassName nvarchar(100),
@MetaFieldName nvarchar(100),
@MaskLength int
)
AS
    SET NOCOUNT ON

DECLARE @Number nvarchar(50)
DECLARE @Id int

SELECT @Id = Id FROM mcmd_MetaIdentifier WHERE PeriodKey=@PeriodKey AND TypeName=@TypeName AND MetaClassName=@MetaClassName AND MetaFieldName=@MetaFieldName

IF @Id IS NULL
	SET @Id = 1
ELSE
	SET @Id = @Id + 1

SET @Number = CAST(@Id As nvarchar(50))

IF LEN(@Number) < @MaskLength
	SET @Number = REPLICATE(''0'', @MaskLength - LEN(@Number)) + @Number

SET @Value = REPLACE(@Value, ''#'', @Number)

INSERT INTO [mcmd_MetaIdentifier]
(
[PeriodKey],
[TypeName],
[MetaClassName],
[MetaFieldName],
[Value],
[Id])
VALUES(
@PeriodKey,
@TypeName,
@MetaClassName,
@MetaFieldName,
@Value,
@Id)

SELECT @IdentifierId = SCOPE_IDENTITY();
RETURN @@Error' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaIdentifierSelect]    Script Date: 05/13/2009 09:56:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaIdentifierSelect]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaIdentifierSelect]
(
@IdentifierId int
)
AS
    SET NOCOUNT ON
SELECT [IdentifierId],
[PeriodKey],
[TypeName],
[MetaClassName],
[MetaFieldName],
[Id],
[Value] FROM mcmd_MetaIdentifier
WHERE
[IdentifierId] = @IdentifierId' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaIdentifierUpdate]    Script Date: 05/13/2009 09:56:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaIdentifierUpdate]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaIdentifierUpdate]
(
@IdentifierId int,
@Value nvarchar(510))
AS
    SET NOCOUNT ON
UPDATE [mcmd_MetaIdentifier]
SET
[Value] = @Value
WHERE
[IdentifierId] = @IdentifierId
RETURN @@Error' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaLinkDelete]    Script Date: 05/13/2009 09:56:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaLinkDelete]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaLinkDelete]
(
@LinkId int
)
AS
    SET NOCOUNT ON

DELETE FROM [mcmd_MetaLink]
WHERE
[LinkId] = @LinkId
RETURN @@Error' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaLinkInsert]    Script Date: 05/13/2009 09:56:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaLinkInsert]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'-- Create SP
CREATE PROCEDURE [dbo].[mc_mcmd_MetaLinkInsert]
(
@LinkId int = NULL OUTPUT
,
@MetaClassName nvarchar(50) = NULL
,
@MetaObjectId int = NULL
,
@UID ntext = NULL
)
AS
    SET NOCOUNT ON

INSERT INTO [mcmd_MetaLink]
(
[MetaClassName],
[MetaObjectId],
[UID])
VALUES(
@MetaClassName,
@MetaObjectId,
@UID)
SELECT @LinkId = SCOPE_IDENTITY();
RETURN @@Error' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaLinkSelect]    Script Date: 05/13/2009 09:56:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaLinkSelect]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaLinkSelect]
(
@LinkId int
)
AS
    SET NOCOUNT ON

SELECT [LinkId],
[MetaClassName],
[MetaObjectId],
[UID] FROM mcmd_MetaLink
WHERE
[LinkId] = @LinkId' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaLinkUpdate]    Script Date: 05/13/2009 09:56:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaLinkUpdate]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaLinkUpdate]
(
@LinkId int,
@MetaClassName nvarchar(50) = NULL
,
@MetaObjectId int = NULL
,
@UID ntext = NULL
)
AS
    SET NOCOUNT ON

UPDATE [mcmd_MetaLink]
SET
[MetaClassName] = @MetaClassName,
[MetaObjectId] = @MetaObjectId,
[UID] = @UID
WHERE
[LinkId] = @LinkId
RETURN @@Error' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaModelVersionIdSelect]    Script Date: 05/13/2009 09:56:31 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaModelVersionIdSelect]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[mc_mcmd_MetaModelVersionIdSelect] AS
	SELECT TOP 1 VersionId FROM mcmd_MetaModelVersionId' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaModelVersionIdUpdate]    Script Date: 05/13/2009 09:56:31 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaModelVersionIdUpdate]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaModelVersionIdUpdate] 
	@VersionId uniqueidentifier
AS
	IF NOT EXISTS (SELECT * FROM mcmd_MetaModelVersionId)
		INSERT INTO mcmd_MetaModelVersionId (VersionId) VALUES (@VersionId)
	ELSE
		UPDATE mcmd_MetaModelVersionId SET VersionId = @VersionId' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_SelectedEnumValueDelete]    Script Date: 05/13/2009 09:56:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_SelectedEnumValueDelete]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_SelectedEnumValueDelete]
(
@SelectedEnumValueId int
)
AS
    SET NOCOUNT ON
DELETE FROM [mcmd_SelectedEnumValue]
WHERE
[SelectedEnumValueId] = @SelectedEnumValueId
RETURN @@Error' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_SelectedEnumValueInsert]    Script Date: 05/13/2009 09:56:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_SelectedEnumValueInsert]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_SelectedEnumValueInsert]
(
@SelectedEnumValueId int = NULL OUTPUT
,
@Key uniqueidentifier,
@TypeName nvarchar(100),
@Id int)
AS
    SET NOCOUNT ON
INSERT INTO [mcmd_SelectedEnumValue]
(
[Key],
[TypeName],
[Id])
VALUES(
@Key,
@TypeName,
@Id)
SELECT @SelectedEnumValueId = SCOPE_IDENTITY();
RETURN @@Error' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_SelectedEnumValueSelect]    Script Date: 05/13/2009 09:56:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_SelectedEnumValueSelect]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_SelectedEnumValueSelect]
(
@SelectedEnumValueId int
)
AS
    SET NOCOUNT ON
SELECT [SelectedEnumValueId],
[Key],
[TypeName],
[Id] FROM mcmd_SelectedEnumValue
WHERE
[SelectedEnumValueId] = @SelectedEnumValueId' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_SelectedEnumValueUpdate]    Script Date: 05/13/2009 09:56:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_SelectedEnumValueUpdate]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_SelectedEnumValueUpdate]
(
@SelectedEnumValueId int,
@Key uniqueidentifier,
@TypeName nvarchar(100),
@Id int)
AS
    SET NOCOUNT ON
UPDATE [mcmd_SelectedEnumValue]
SET
[Key] = @Key,
[TypeName] = @TypeName,
[Id] = @Id
WHERE
[SelectedEnumValueId] = @SelectedEnumValueId
RETURN @@Error' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_TmpMetaFileCleanUp]    Script Date: 05/13/2009 09:56:39 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_TmpMetaFileCleanUp]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_TmpMetaFileCleanUp] 
	@ExpiredDate datetime
AS
	DELETE FROM mcmd_TmpMetaFile WHERE Created < @ExpiredDate' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_TmpMetaFileDelete]    Script Date: 05/13/2009 09:56:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_TmpMetaFileDelete]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_TmpMetaFileDelete]
(
@TmpFileId int
)
AS
    SET NOCOUNT ON
DELETE FROM [mcmd_TmpMetaFile]
WHERE
[TmpFileId] = @TmpFileId
RETURN @@Error' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_TmpMetaFileInsert]    Script Date: 05/13/2009 09:56:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_TmpMetaFileInsert]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_TmpMetaFileInsert]
(
@TmpFileId int = NULL OUTPUT,
@FileUID uniqueidentifier,
@FileName nvarchar(510)
)
AS
    SET NOCOUNT ON
INSERT INTO [mcmd_TmpMetaFile]
(
[FileUID],
[FileName])
VALUES(
@FileUID,
@FileName)
SELECT @TmpFileId = SCOPE_IDENTITY();
RETURN @@Error' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_TmpMetaFileSelect]    Script Date: 05/13/2009 09:56:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_TmpMetaFileSelect]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_TmpMetaFileSelect]
(
@TmpFileId int
)
AS
    SET NOCOUNT ON
SELECT [TmpFileId],
[Created],
[FileUID],
[FileName],
[Body] FROM mcmd_TmpMetaFile
WHERE
[TmpFileId] = @TmpFileId' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaClassSelect]    Script Date: 05/13/2009 09:56:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaClassSelect]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaClassSelect]
@MetaClassId AS Int
AS
BEGIN
SET NOCOUNT ON;

SELECT [t01].[MetaClassId] AS [MetaClassId], [t01].[Name] AS [Name], [t01].[FriendlyName] AS [FriendlyName], [t01].[PluralName] AS [PluralName], [t01].[TitleFieldName] AS [TitleFieldName], [t01].[XSValidators] AS [XSValidators], [t01].[XSAttributes] AS [XSAttributes], [t01].[XSExtensions] AS [XSExtensions], [t01].[Owner] AS [Owner], [t01].[AccessLevel] AS [AccessLevel], [t01].[XSModules] AS [XSModules]
FROM [mcmd_MetaClass] AS [t01]
WHERE ([t01].[MetaClassId]=@MetaClassId)

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaClassDelete]    Script Date: 05/13/2009 09:56:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaClassDelete]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaClassDelete]
@MetaClassId AS Int
AS
BEGIN
SET NOCOUNT ON;

DELETE FROM [mcmd_MetaClass]
WHERE
[MetaClassId] = @MetaClassId

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaClassUpdate]    Script Date: 05/13/2009 09:56:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaClassUpdate]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaClassUpdate]
@Name AS NVarChar(4000),
@FriendlyName AS NVarChar(4000),
@PluralName AS NVarChar(4000),
@TitleFieldName AS NVarChar(4000),
@XSValidators AS NText,
@XSAttributes AS NText,
@XSExtensions AS NText,
@Owner AS NVarChar(4000),
@AccessLevel AS Int,
@XSModules AS NText,
@MetaClassId AS Int
AS
BEGIN
SET NOCOUNT ON;

UPDATE [mcmd_MetaClass] SET
[Name] = @Name,
[FriendlyName] = @FriendlyName,
[PluralName] = @PluralName,
[TitleFieldName] = @TitleFieldName,
[XSValidators] = @XSValidators,
[XSAttributes] = @XSAttributes,
[XSExtensions] = @XSExtensions,
[Owner] = @Owner,
[AccessLevel] = @AccessLevel,
[XSModules] = @XSModules WHERE
[MetaClassId] = @MetaClassId

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaClassInsert]    Script Date: 05/13/2009 09:56:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaClassInsert]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaClassInsert]
@Name AS NVarChar(4000),
@FriendlyName AS NVarChar(4000),
@PluralName AS NVarChar(4000),
@TitleFieldName AS NVarChar(4000),
@XSValidators AS NText,
@XSAttributes AS NText,
@XSExtensions AS NText,
@Owner AS NVarChar(4000),
@AccessLevel AS Int,
@XSModules AS NText,
@MetaClassId AS Int = NULL OUTPUT
AS
BEGIN
SET NOCOUNT ON;

INSERT INTO [mcmd_MetaClass]
(
[Name],
[FriendlyName],
[PluralName],
[TitleFieldName],
[XSValidators],
[XSAttributes],
[XSExtensions],
[Owner],
[AccessLevel],
[XSModules])
VALUES(
@Name,
@FriendlyName,
@PluralName,
@TitleFieldName,
@XSValidators,
@XSAttributes,
@XSExtensions,
@Owner,
@AccessLevel,
@XSModules)
SELECT @MetaClassId = SCOPE_IDENTITY();

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaEnumInsert]    Script Date: 05/13/2009 09:56:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaEnumInsert]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaEnumInsert]
@Id AS Int,
@TypeName AS NVarChar(4000),
@FriendlyName AS NVarChar(4000),
@OrderId AS Int,
@Owner AS NVarChar(4000),
@AccessLevel AS Int,
@MetaEnumId AS Int = NULL OUTPUT
AS
BEGIN
SET NOCOUNT ON;

INSERT INTO [mcmd_MetaEnum]
(
[Id],
[TypeName],
[FriendlyName],
[OrderId],
[Owner],
[AccessLevel])
VALUES(
@Id,
@TypeName,
@FriendlyName,
@OrderId,
@Owner,
@AccessLevel)
SELECT @MetaEnumId = SCOPE_IDENTITY();

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaEnumUpdate]    Script Date: 05/13/2009 09:56:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaEnumUpdate]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaEnumUpdate]
@Id AS Int,
@TypeName AS NVarChar(4000),
@FriendlyName AS NVarChar(4000),
@OrderId AS Int,
@Owner AS NVarChar(4000),
@AccessLevel AS Int,
@MetaEnumId AS Int
AS
BEGIN
SET NOCOUNT ON;

UPDATE [mcmd_MetaEnum] SET
[Id] = @Id,
[TypeName] = @TypeName,
[FriendlyName] = @FriendlyName,
[OrderId] = @OrderId,
[Owner] = @Owner,
[AccessLevel] = @AccessLevel WHERE
[MetaEnumId] = @MetaEnumId

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaEnumDelete]    Script Date: 05/13/2009 09:56:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaEnumDelete]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaEnumDelete]
@MetaEnumId AS Int
AS
BEGIN
SET NOCOUNT ON;

DELETE FROM [mcmd_MetaEnum]
WHERE
[MetaEnumId] = @MetaEnumId

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaEnumSelect]    Script Date: 05/13/2009 09:56:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaEnumSelect]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaEnumSelect]
@MetaEnumId AS Int
AS
BEGIN
SET NOCOUNT ON;

SELECT [t01].[MetaEnumId] AS [MetaEnumId], [t01].[Id] AS [Id], [t01].[TypeName] AS [TypeName], [t01].[FriendlyName] AS [FriendlyName], [t01].[OrderId] AS [OrderId], [t01].[Owner] AS [Owner], [t01].[AccessLevel] AS [AccessLevel]
FROM [mcmd_MetaEnum] AS [t01]
WHERE ([t01].[MetaEnumId]=@MetaEnumId)

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaFieldInsert]    Script Date: 05/13/2009 09:56:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaFieldInsert]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaFieldInsert]
@MetaClassId AS Int,
@Name AS NVarChar(4000),
@FriendlyName AS NVarChar(4000),
@TypeName AS NVarChar(4000),
@Nullable AS Bit,
@DefaultValue AS NText,
@ReadOnly AS Bit,
@XSDataSource AS NText,
@XSAttributes AS NText,
@Owner AS NVarChar(4000),
@AccessLevel AS Int,
@MetaFieldId AS Int = NULL OUTPUT
AS
BEGIN
SET NOCOUNT ON;

INSERT INTO [mcmd_MetaField]
(
[MetaClassId],
[Name],
[FriendlyName],
[TypeName],
[Nullable],
[DefaultValue],
[ReadOnly],
[XSDataSource],
[XSAttributes],
[Owner],
[AccessLevel])
VALUES(
@MetaClassId,
@Name,
@FriendlyName,
@TypeName,
@Nullable,
@DefaultValue,
@ReadOnly,
@XSDataSource,
@XSAttributes,
@Owner,
@AccessLevel)
SELECT @MetaFieldId = SCOPE_IDENTITY();

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaFieldUpdate]    Script Date: 05/13/2009 09:56:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaFieldUpdate]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaFieldUpdate]
@MetaClassId AS Int,
@Name AS NVarChar(4000),
@FriendlyName AS NVarChar(4000),
@TypeName AS NVarChar(4000),
@Nullable AS Bit,
@DefaultValue AS NText,
@ReadOnly AS Bit,
@XSDataSource AS NText,
@XSAttributes AS NText,
@Owner AS NVarChar(4000),
@AccessLevel AS Int,
@MetaFieldId AS Int
AS
BEGIN
SET NOCOUNT ON;

UPDATE [mcmd_MetaField] SET
[MetaClassId] = @MetaClassId,
[Name] = @Name,
[FriendlyName] = @FriendlyName,
[TypeName] = @TypeName,
[Nullable] = @Nullable,
[DefaultValue] = @DefaultValue,
[ReadOnly] = @ReadOnly,
[XSDataSource] = @XSDataSource,
[XSAttributes] = @XSAttributes,
[Owner] = @Owner,
[AccessLevel] = @AccessLevel WHERE
[MetaFieldId] = @MetaFieldId

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaFieldDelete]    Script Date: 05/13/2009 09:56:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaFieldDelete]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaFieldDelete]
@MetaFieldId AS Int
AS
BEGIN
SET NOCOUNT ON;

DELETE FROM [mcmd_MetaField]
WHERE
[MetaFieldId] = @MetaFieldId

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaFieldSelect]    Script Date: 05/13/2009 09:56:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaFieldSelect]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaFieldSelect]
@MetaFieldId AS Int
AS
BEGIN
SET NOCOUNT ON;

SELECT [t01].[MetaFieldId] AS [MetaFieldId], [t01].[MetaClassId] AS [MetaClassId], [t01].[Name] AS [Name], [t01].[FriendlyName] AS [FriendlyName], [t01].[TypeName] AS [TypeName], [t01].[Nullable] AS [Nullable], [t01].[DefaultValue] AS [DefaultValue], [t01].[ReadOnly] AS [ReadOnly], [t01].[XSDataSource] AS [XSDataSource], [t01].[XSAttributes] AS [XSAttributes], [t01].[Owner] AS [Owner], [t01].[AccessLevel] AS [AccessLevel]
FROM [mcmd_MetaField] AS [t01]
WHERE ([t01].[MetaFieldId]=@MetaFieldId)

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaViewInsert]    Script Date: 05/13/2009 09:56:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaViewInsert]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaViewInsert]
@MetaClassId AS Int,
@Card AS NVarChar(4000),
@Name AS NVarChar(4000),
@FriendlyName AS NVarChar(4000),
@XSAttributes AS NText,
@XSFilters AS NText,
@XSSorts AS NText,
@XSGroups AS NText,
@XSAvailableFields AS NText,
@Owner AS NVarChar(4000),
@AccessLevel AS Int,
@MetaViewId AS Int = NULL OUTPUT
AS
BEGIN
SET NOCOUNT ON;

INSERT INTO [mcmd_MetaView]
(
[MetaClassId],
[Card],
[Name],
[FriendlyName],
[XSAttributes],
[XSFilters],
[XSSorts],
[XSGroups],
[XSAvailableFields],
[Owner],
[AccessLevel])
VALUES(
@MetaClassId,
@Card,
@Name,
@FriendlyName,
@XSAttributes,
@XSFilters,
@XSSorts,
@XSGroups,
@XSAvailableFields,
@Owner,
@AccessLevel)
SELECT @MetaViewId = SCOPE_IDENTITY();

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaViewSelect]    Script Date: 05/13/2009 09:56:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaViewSelect]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaViewSelect]
@MetaViewId AS Int
AS
BEGIN
SET NOCOUNT ON;

SELECT [t01].[MetaViewId] AS [MetaViewId], [t01].[MetaClassId] AS [MetaClassId], [t01].[Card] AS [Card], [t01].[Name] AS [Name], [t01].[FriendlyName] AS [FriendlyName], [t01].[XSAttributes] AS [XSAttributes], [t01].[XSFilters] AS [XSFilters], [t01].[XSSorts] AS [XSSorts], [t01].[XSGroups] AS [XSGroups], [t01].[XSAvailableFields] AS [XSAvailableFields], [t01].[Owner] AS [Owner], [t01].[AccessLevel] AS [AccessLevel]
FROM [mcmd_MetaView] AS [t01]
WHERE ([t01].[MetaViewId]=@MetaViewId)

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaViewDelete]    Script Date: 05/13/2009 09:56:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaViewDelete]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaViewDelete]
@MetaViewId AS Int
AS
BEGIN
SET NOCOUNT ON;

DELETE FROM [mcmd_MetaView]
WHERE
[MetaViewId] = @MetaViewId

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaViewUpdate]    Script Date: 05/13/2009 09:56:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaViewUpdate]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaViewUpdate]
@MetaClassId AS Int,
@Card AS NVarChar(4000),
@Name AS NVarChar(4000),
@FriendlyName AS NVarChar(4000),
@XSAttributes AS NText,
@XSFilters AS NText,
@XSSorts AS NText,
@XSGroups AS NText,
@XSAvailableFields AS NText,
@Owner AS NVarChar(4000),
@AccessLevel AS Int,
@MetaViewId AS Int
AS
BEGIN
SET NOCOUNT ON;

UPDATE [mcmd_MetaView] SET
[MetaClassId] = @MetaClassId,
[Card] = @Card,
[Name] = @Name,
[FriendlyName] = @FriendlyName,
[XSAttributes] = @XSAttributes,
[XSFilters] = @XSFilters,
[XSSorts] = @XSSorts,
[XSGroups] = @XSGroups,
[XSAvailableFields] = @XSAvailableFields,
[Owner] = @Owner,
[AccessLevel] = @AccessLevel WHERE
[MetaViewId] = @MetaViewId

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaFieldMapDelete]    Script Date: 05/13/2009 09:56:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaFieldMapDelete]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaFieldMapDelete]
@MetaFieldMapId AS Int
AS
BEGIN
SET NOCOUNT ON;

DELETE FROM [mcmd_MetaFieldMap]
WHERE
[MetaFieldMapId] = @MetaFieldMapId

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaFieldMapSelect]    Script Date: 05/13/2009 09:56:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaFieldMapSelect]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaFieldMapSelect]
@MetaFieldMapId AS Int
AS
BEGIN
SET NOCOUNT ON;

SELECT [t01].[MetaFieldMapId] AS [MetaFieldMapId], [t01].[Name] AS [Name], [t01].[SrcMetaClassId] AS [SrcMetaClassId], [t01].[DestMetaClassId] AS [DestMetaClassId], [t01].[XSReferences] AS [XSReferences], [t01].[XSElements] AS [XSElements]
FROM [mcmd_MetaFieldMap] AS [t01]
WHERE ([t01].[MetaFieldMapId]=@MetaFieldMapId)

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaFieldMapInsert]    Script Date: 05/13/2009 09:56:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaFieldMapInsert]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaFieldMapInsert]
@MetaFieldMapId AS Int,
@Name AS NVarChar(4000),
@SrcMetaClassId AS Int,
@DestMetaClassId AS Int,
@XSReferences AS NText,
@XSElements AS NText
AS
BEGIN
SET NOCOUNT ON;

INSERT INTO [mcmd_MetaFieldMap]
(
[MetaFieldMapId],
[Name],
[SrcMetaClassId],
[DestMetaClassId],
[XSReferences],
[XSElements])
VALUES(
@MetaFieldMapId,
@Name,
@SrcMetaClassId,
@DestMetaClassId,
@XSReferences,
@XSElements)

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaFieldMapUpdate]    Script Date: 05/13/2009 09:56:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaFieldMapUpdate]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaFieldMapUpdate]
@Name AS NVarChar(4000),
@SrcMetaClassId AS Int,
@DestMetaClassId AS Int,
@XSReferences AS NText,
@XSElements AS NText,
@MetaFieldMapId AS Int
AS
BEGIN
SET NOCOUNT ON;

UPDATE [mcmd_MetaFieldMap] SET
[Name] = @Name,
[SrcMetaClassId] = @SrcMetaClassId,
[DestMetaClassId] = @DestMetaClassId,
[XSReferences] = @XSReferences,
[XSElements] = @XSElements WHERE
[MetaFieldMapId] = @MetaFieldMapId

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_ModuleDelete]    Script Date: 05/13/2009 09:56:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_ModuleDelete]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_ModuleDelete]
@ModuleId AS Int
AS
BEGIN
SET NOCOUNT ON;

DELETE FROM [mcmd_Module]
WHERE
[ModuleId] = @ModuleId

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_ModuleUpdate]    Script Date: 05/13/2009 09:56:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_ModuleUpdate]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_ModuleUpdate]
@Name AS NVarChar(4000),
@XSAttributes AS NText,
@ModuleId AS Int
AS
BEGIN
SET NOCOUNT ON;

UPDATE [mcmd_Module] SET
[Name] = @Name,
[XSAttributes] = @XSAttributes WHERE
[ModuleId] = @ModuleId

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_ModuleSelect]    Script Date: 05/13/2009 09:56:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_ModuleSelect]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_ModuleSelect]
@ModuleId AS Int
AS
BEGIN
SET NOCOUNT ON;

SELECT [t01].[ModuleId] AS [ModuleId], [t01].[Name] AS [Name], [t01].[XSAttributes] AS [XSAttributes]
FROM [mcmd_Module] AS [t01]
WHERE ([t01].[ModuleId]=@ModuleId)

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_ModuleInsert]    Script Date: 05/13/2009 09:56:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_ModuleInsert]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_ModuleInsert]
@Name AS NVarChar(4000),
@XSAttributes AS NText,
@ModuleId AS Int = NULL OUTPUT
AS
BEGIN
SET NOCOUNT ON;

INSERT INTO [mcmd_Module]
(
[Name],
[XSAttributes])
VALUES(
@Name,
@XSAttributes)
SELECT @ModuleId = SCOPE_IDENTITY();

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaClassDataSourceInsert]    Script Date: 05/13/2009 09:56:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaClassDataSourceInsert]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaClassDataSourceInsert]
@MetaClassId AS Int,
@PrimaryTable AS NVarChar(4000),
@XSExtendedTables AS NText,
@XSConditions AS NText,
@MetaClassDataSourceId AS Int = NULL OUTPUT
AS
BEGIN
SET NOCOUNT ON;

INSERT INTO [mcmd_MetaClassDataSource]
(
[MetaClassId],
[PrimaryTable],
[XSExtendedTables],
[XSConditions])
VALUES(
@MetaClassId,
@PrimaryTable,
@XSExtendedTables,
@XSConditions)
SELECT @MetaClassDataSourceId = SCOPE_IDENTITY();

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaClassDataSourceUpdate]    Script Date: 05/13/2009 09:56:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaClassDataSourceUpdate]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaClassDataSourceUpdate]
@MetaClassId AS Int,
@PrimaryTable AS NVarChar(4000),
@XSExtendedTables AS NText,
@XSConditions AS NText,
@MetaClassDataSourceId AS Int
AS
BEGIN
SET NOCOUNT ON;

UPDATE [mcmd_MetaClassDataSource] SET
[MetaClassId] = @MetaClassId,
[PrimaryTable] = @PrimaryTable,
[XSExtendedTables] = @XSExtendedTables,
[XSConditions] = @XSConditions WHERE
[MetaClassDataSourceId] = @MetaClassDataSourceId

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaClassDataSourceDelete]    Script Date: 05/13/2009 09:56:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaClassDataSourceDelete]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaClassDataSourceDelete]
@MetaClassDataSourceId AS Int
AS
BEGIN
SET NOCOUNT ON;

DELETE FROM [mcmd_MetaClassDataSource]
WHERE
[MetaClassDataSourceId] = @MetaClassDataSourceId

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaClassDataSourceSelect]    Script Date: 05/13/2009 09:56:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaClassDataSourceSelect]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaClassDataSourceSelect]
@MetaClassDataSourceId AS Int
AS
BEGIN
SET NOCOUNT ON;

SELECT [t01].[MetaClassDataSourceId] AS [MetaClassDataSourceId], [t01].[MetaClassId] AS [MetaClassId], [t01].[PrimaryTable] AS [PrimaryTable], [t01].[XSExtendedTables] AS [XSExtendedTables], [t01].[XSConditions] AS [XSConditions]
FROM [mcmd_MetaClassDataSource] AS [t01]
WHERE ([t01].[MetaClassDataSourceId]=@MetaClassDataSourceId)

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaFieldTypeInsert]    Script Date: 05/13/2009 09:56:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaFieldTypeInsert]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaFieldTypeInsert]
@Name AS NVarChar(4000),
@FriendlyName AS NVarChar(4000),
@McDataType AS Int,
@XSViews AS NText,
@XSAttributes AS NText,
@Owner AS NVarChar(4000),
@AccessLevel AS Int,
@MetaFieldTypeId AS Int = NULL OUTPUT
AS
BEGIN
SET NOCOUNT ON;

INSERT INTO [mcmd_MetaFieldType]
(
[Name],
[FriendlyName],
[McDataType],
[XSViews],
[XSAttributes],
[Owner],
[AccessLevel])
VALUES(
@Name,
@FriendlyName,
@McDataType,
@XSViews,
@XSAttributes,
@Owner,
@AccessLevel)
SELECT @MetaFieldTypeId = SCOPE_IDENTITY();

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaFieldTypeUpdate]    Script Date: 05/13/2009 09:56:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaFieldTypeUpdate]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaFieldTypeUpdate]
@Name AS NVarChar(4000),
@FriendlyName AS NVarChar(4000),
@McDataType AS Int,
@XSViews AS NText,
@XSAttributes AS NText,
@Owner AS NVarChar(4000),
@AccessLevel AS Int,
@MetaFieldTypeId AS Int
AS
BEGIN
SET NOCOUNT ON;

UPDATE [mcmd_MetaFieldType] SET
[Name] = @Name,
[FriendlyName] = @FriendlyName,
[McDataType] = @McDataType,
[XSViews] = @XSViews,
[XSAttributes] = @XSAttributes,
[Owner] = @Owner,
[AccessLevel] = @AccessLevel WHERE
[MetaFieldTypeId] = @MetaFieldTypeId

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaFieldTypeDelete]    Script Date: 05/13/2009 09:56:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaFieldTypeDelete]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaFieldTypeDelete]
@MetaFieldTypeId AS Int
AS
BEGIN
SET NOCOUNT ON;

DELETE FROM [mcmd_MetaFieldType]
WHERE
[MetaFieldTypeId] = @MetaFieldTypeId

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcmd_MetaFieldTypeSelect]    Script Date: 05/13/2009 09:56:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[mc_mcmd_MetaFieldTypeSelect]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcmd_MetaFieldTypeSelect]
@MetaFieldTypeId AS Int
AS
BEGIN
SET NOCOUNT ON;

SELECT [t01].[MetaFieldTypeId] AS [MetaFieldTypeId], [t01].[Name] AS [Name], [t01].[FriendlyName] AS [FriendlyName], [t01].[McDataType] AS [McDataType], [t01].[XSViews] AS [XSViews], [t01].[XSAttributes] AS [XSAttributes], [t01].[Owner] AS [Owner], [t01].[AccessLevel] AS [AccessLevel]
FROM [mcmd_MetaFieldType] AS [t01]
WHERE ([t01].[MetaFieldTypeId]=@MetaFieldTypeId)

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[mc_mcweb_ListViewProfileInsert]   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_mcweb_ListViewProfileInsert]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcweb_ListViewProfileInsert]
@UserId AS Int,
@MetaClassName AS NVarChar(4000),
@ViewName AS NVarChar(4000),
@PlaceName AS NVarChar(4000),
@IsSystem AS Bit,
@IsPublic AS Bit,
@XSListViewProfile AS NText,
@UserUid AS UniqueIdentifier,
@ListViewProfileId AS Int = NULL OUTPUT
AS
BEGIN
SET NOCOUNT ON;

INSERT INTO [mcweb_ListViewProfile]
(
[UserId],
[MetaClassName],
[ViewName],
[PlaceName],
[IsSystem],
[IsPublic],
[XSListViewProfile],
[UserUid])
VALUES(
@UserId,
@MetaClassName,
@ViewName,
@PlaceName,
@IsSystem,
@IsPublic,
@XSListViewProfile,
@UserUid)
SELECT @ListViewProfileId = SCOPE_IDENTITY();

END'
END
GO

/****** Object:  StoredProcedure [dbo].[mc_mcweb_ListViewProfileUpdate]   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_mcweb_ListViewProfileUpdate]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcweb_ListViewProfileUpdate]
@UserId AS Int,
@MetaClassName AS NVarChar(4000),
@ViewName AS NVarChar(4000),
@PlaceName AS NVarChar(4000),
@IsSystem AS Bit,
@IsPublic AS Bit,
@XSListViewProfile AS NText,
@UserUid AS UniqueIdentifier,
@ListViewProfileId AS Int
AS
BEGIN
SET NOCOUNT ON;

UPDATE [mcweb_ListViewProfile] SET
[UserId] = @UserId,
[MetaClassName] = @MetaClassName,
[ViewName] = @ViewName,
[PlaceName] = @PlaceName,
[IsSystem] = @IsSystem,
[IsPublic] = @IsPublic,
[XSListViewProfile] = @XSListViewProfile,
[UserUid] = @UserUid WHERE
[ListViewProfileId] = @ListViewProfileId

END'
END
GO

/****** Object:  StoredProcedure [dbo].[mc_mcweb_ListViewProfileDelete]   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_mcweb_ListViewProfileDelete]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcweb_ListViewProfileDelete]
@ListViewProfileId AS Int
AS
BEGIN
SET NOCOUNT ON;

DELETE FROM [mcweb_ListViewProfile]
WHERE
[ListViewProfileId] = @ListViewProfileId
END'
END
GO

/****** Object:  StoredProcedure [dbo].[mc_mcweb_ListViewProfileSelect]   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_mcweb_ListViewProfileSelect]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcweb_ListViewProfileSelect]
@ListViewProfileId AS Int
AS
BEGIN
SET NOCOUNT ON;
SELECT [t01].[ListViewProfileId] AS [ListViewProfileId], [t01].[UserId] AS [UserId], [t01].[MetaClassName] AS [MetaClassName], [t01].[ViewName] AS [ViewName], [t01].[PlaceName] AS [PlaceName], [t01].[IsSystem] AS [IsSystem], [t01].[IsPublic] AS [IsPublic], [t01].[XSListViewProfile] AS [XSListViewProfile], [t01].[UserUid] AS [UserUid]
FROM [mcweb_ListViewProfile] AS [t01]
WHERE ([t01].[ListViewProfileId]=@ListViewProfileId)
END'
END
GO

/****** Object:  StoredProcedure [dbo].[mc_mcweb_FormDocumentInsert]   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_mcweb_FormDocumentInsert]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcweb_FormDocumentInsert]
(
@FormDocumentId int = NULL OUTPUT,
@MetaClassName nvarchar(50),
@FormDocumentName nvarchar(50),
@FormDocumentXml ntext,
@MetaUITypeId nvarchar(50))
AS
SET NOCOUNT ON
INSERT INTO [mcweb_FormDocument]
(
[MetaClassName],
[FormDocumentName],
[FormDocumentXml],
[MetaUITypeId])
VALUES(
@MetaClassName,
@FormDocumentName,
@FormDocumentXml,
@MetaUITypeId)
SELECT @FormDocumentId = SCOPE_IDENTITY();
RETURN @@Error'
END
GO

/****** Object:  StoredProcedure [dbo].[mc_mcweb_FormDocumentUpdate]   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_mcweb_FormDocumentUpdate]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcweb_FormDocumentUpdate]
@MetaClassName AS NVarChar(4000),
@FormDocumentName AS NVarChar(4000),
@FormDocumentXml AS NText,
@MetaUITypeId AS NVarChar(4000),
@FormDocumentId AS Int
AS
BEGIN
SET NOCOUNT ON;

UPDATE [mcweb_FormDocument] SET
[MetaClassName] = @MetaClassName,
[FormDocumentName] = @FormDocumentName,
[FormDocumentXml] = @FormDocumentXml,
[MetaUITypeId] = @MetaUITypeId WHERE
[FormDocumentId] = @FormDocumentId
END'
END
GO

/****** Object:  StoredProcedure [dbo].[mc_mcweb_FormDocumentDelete]   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_mcweb_FormDocumentDelete]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcweb_FormDocumentDelete]
@FormDocumentId AS Int
AS
BEGIN
SET NOCOUNT ON;
DELETE FROM [mcweb_FormDocument]
WHERE
[FormDocumentId] = @FormDocumentId
END'
END
GO

/****** Object:  StoredProcedure [dbo].[mc_mcweb_FormDocumentSelect]   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_mcweb_FormDocumentSelect]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_mcweb_FormDocumentSelect]
@FormDocumentId AS Int
AS
BEGIN
SET NOCOUNT ON;

SELECT [t01].[FormDocumentId] AS [FormDocumentId], [t01].[MetaClassName] AS [MetaClassName], [t01].[FormDocumentName] AS [FormDocumentName], [t01].[FormDocumentXml] AS [FormDocumentXml], [t01].[MetaUITypeId] AS [MetaUITypeId]
FROM [mcweb_FormDocument] AS [t01]
WHERE ([t01].[FormDocumentId]=@FormDocumentId)
END'
END
GO

/****** Object:  StoredProcedure [dbo].[mc_blob_BlobStorageRemoveExpired]    Script Date: 07/21/2009 17:22:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[mc_blob_BlobStorageRemoveExpired]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[mc_blob_BlobStorageRemoveExpired] 
	@PeriodInMin as int
AS
BEGIN
	SET NOCOUNT ON;

	DELETE FROM McBlobStorage 
    WHERE DateDiff(minute, [created], GETUTCDATE()) >= @PeriodInMin AND [isTemporary] = 1
END'
END
GO