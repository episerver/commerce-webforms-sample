create type [dbo].udttOrderGroupId as table (OrderGroupId int)
go



/****** Object:  StoredProcedure [dbo].[GetOrderSchemaVersionNumber]    Script Date: 07/21/2009 17:25:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetOrderSchemaVersionNumber]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetOrderSchemaVersionNumber]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Country]    Script Date: 07/21/2009 17:25:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Country]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Country]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Country_Code]    Script Date: 07/21/2009 17:25:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Country_Code]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Country_Code]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Country_CountryId]    Script Date: 07/21/2009 17:25:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Country_CountryId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Country_CountryId]
GO

/****** Object:  StoredProcedure [dbo].[ecf_GetMostRecentOrder]    Script Date: 09/20/2013 09:46:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Country_CountryId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_GetMostRecentOrder]
GO

/****** Object:  StoredProcedure [dbo].[ecf_LineItem_Delete]    Script Date: 07/21/2009 17:25:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_LineItem_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_LineItem_Delete]
GO

/****** Object:  StoredProcedure [dbo].[ecf_LineItem_Insert]    Script Date: 07/21/2009 17:25:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_LineItem_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_LineItem_Insert]
GO

/****** Object:  StoredProcedure [dbo].[ecf_LineItem_Update]    Script Date: 07/21/2009 17:25:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_LineItem_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_LineItem_Update]
GO

/****** Object:  StoredProcedure [dbo].[ecf_LineItemDiscount_Delete]    Script Date: 07/21/2009 17:25:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_LineItemDiscount_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_LineItemDiscount_Delete]
GO

/****** Object:  StoredProcedure [dbo].[ecf_LineItemDiscount_Insert]    Script Date: 07/21/2009 17:25:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_LineItemDiscount_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_LineItemDiscount_Insert]
GO

/****** Object:  StoredProcedure [dbo].[ecf_LineItemDiscount_Update]    Script Date: 07/21/2009 17:25:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_LineItemDiscount_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_LineItemDiscount_Update]
GO

/****** Object:  StoredProcedure [dbo].[ecf_ord_CreateFTSQuery]    Script Date: 07/21/2009 17:25:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_ord_CreateFTSQuery]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_ord_CreateFTSQuery]
GO

/****** Object:  StoredProcedure [dbo].[ecf_OrderForm_Delete]    Script Date: 07/21/2009 17:25:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_OrderForm_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_OrderForm_Delete]
GO

/****** Object:  StoredProcedure [dbo].[ecf_OrderForm_Insert]    Script Date: 07/21/2009 17:25:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_OrderForm_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_OrderForm_Insert]
GO

/****** Object:  StoredProcedure [dbo].[ecf_OrderForm_Update]    Script Date: 07/21/2009 17:25:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_OrderForm_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_OrderForm_Update]
GO

/****** Object:  StoredProcedure [dbo].[ecf_OrderFormDiscount_Delete]    Script Date: 07/21/2009 17:25:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_OrderFormDiscount_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_OrderFormDiscount_Delete]
GO

/****** Object:  StoredProcedure [dbo].[ecf_OrderFormDiscount_Insert]    Script Date: 07/21/2009 17:25:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_OrderFormDiscount_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_OrderFormDiscount_Insert]
GO

/****** Object:  StoredProcedure [dbo].[ecf_OrderFormDiscount_Update]    Script Date: 07/21/2009 17:25:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_OrderFormDiscount_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_OrderFormDiscount_Update]
GO

/****** Object:  StoredProcedure [dbo].[ecf_OrderFormPayment_Delete]    Script Date: 07/21/2009 17:25:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_OrderFormPayment_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_OrderFormPayment_Delete]
GO

/****** Object:  StoredProcedure [dbo].[ecf_OrderFormPayment_Insert]    Script Date: 07/21/2009 17:25:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_OrderFormPayment_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_OrderFormPayment_Insert]
GO

/****** Object:  StoredProcedure [dbo].[ecf_OrderFormPayment_Update]    Script Date: 07/21/2009 17:25:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_OrderFormPayment_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_OrderFormPayment_Update]
GO

/****** Object:  StoredProcedure [dbo].[ecf_OrderGroup_Delete]    Script Date: 07/21/2009 17:25:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_OrderGroup_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_OrderGroup_Delete]
GO

/****** Object:  StoredProcedure [dbo].[ecf_OrderGroup_Insert]    Script Date: 07/21/2009 17:25:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_OrderGroup_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_OrderGroup_Insert]
GO

/****** Object:  StoredProcedure [dbo].[ecf_OrderGroup_Update]    Script Date: 07/21/2009 17:25:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_OrderGroup_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_OrderGroup_Update]
GO

/****** Object:  StoredProcedure [dbo].[ecf_OrderGroupAddress_Delete]    Script Date: 07/21/2009 17:25:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_OrderGroupAddress_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_OrderGroupAddress_Delete]
GO

/****** Object:  StoredProcedure [dbo].[ecf_OrderGroupAddress_Insert]    Script Date: 07/21/2009 17:25:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_OrderGroupAddress_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_OrderGroupAddress_Insert]
GO

/****** Object:  StoredProcedure [dbo].[ecf_OrderGroupAddress_Update]    Script Date: 07/21/2009 17:25:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_OrderGroupAddress_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_OrderGroupAddress_Update]
GO

/****** Object:  StoredProcedure [dbo].[ecf_OrderSearch]    Script Date: 07/21/2009 17:25:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_OrderSearch]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_OrderSearch]
GO

/****** Object:  StoredProcedure [dbo].[ecf_PaymentMethod_Language]    Script Date: 07/21/2009 17:25:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_PaymentMethod_Language]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_PaymentMethod_Language]
GO

/****** Object:  StoredProcedure [dbo].[ecf_PaymentMethod_Market]    Script Date: 03/05/2013 17:25:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_PaymentMethod_Market]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_PaymentMethod_Market]
GO

/****** Object:  StoredProcedure [dbo].[ecf_PaymentMethod_PaymentMethodId]    Script Date: 07/21/2009 17:25:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_PaymentMethod_PaymentMethodId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_PaymentMethod_PaymentMethodId]
GO

/****** Object:  StoredProcedure [dbo].[ecf_PaymentMethod_SystemKeyword]    Script Date: 07/21/2009 17:25:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_PaymentMethod_SystemKeyword]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_PaymentMethod_SystemKeyword]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Search_OrderGroup]    Script Date: 07/21/2009 17:25:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Search_OrderGroup]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Search_OrderGroup]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Search_PaymentPlan]    Script Date: 07/21/2009 17:25:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Search_PaymentPlan]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Search_PaymentPlan]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Search_PaymentPlan_Customer]    Script Date: 07/21/2009 17:25:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Search_PaymentPlan_Customer]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Search_PaymentPlan_Customer]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Search_PaymentPlan_CustomerAndName]    Script Date: 07/21/2009 17:25:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Search_PaymentPlan_CustomerAndName]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Search_PaymentPlan_CustomerAndName]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Search_PaymentPlan_CustomerAndOrderGroupId]    Script Date: 07/21/2009 17:25:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Search_PaymentPlan_CustomerAndOrderGroupId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Search_PaymentPlan_CustomerAndOrderGroupId]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Search_PurchaseOrder]    Script Date: 07/21/2009 17:25:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Search_PurchaseOrder]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Search_PurchaseOrder]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Search_PurchaseOrder_Customer]    Script Date: 07/21/2009 17:25:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Search_PurchaseOrder_Customer]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Search_PurchaseOrder_Customer]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Search_PurchaseOrder_CustomerAndName]    Script Date: 07/21/2009 17:25:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Search_PurchaseOrder_CustomerAndName]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Search_PurchaseOrder_CustomerAndName]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Search_PurchaseOrder_CustomerAndOrderGroupId]    Script Date: 07/21/2009 17:25:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Search_PurchaseOrder_CustomerAndOrderGroupId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Search_PurchaseOrder_CustomerAndOrderGroupId]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Search_ShoppingCart]    Script Date: 07/21/2009 17:25:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Search_ShoppingCart]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Search_ShoppingCart]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Search_ShoppingCart_Customer]    Script Date: 07/21/2009 17:25:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Search_ShoppingCart_Customer]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Search_ShoppingCart_Customer]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Search_ShoppingCart_CustomerAndName]    Script Date: 07/21/2009 17:25:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Search_ShoppingCart_CustomerAndName]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Search_ShoppingCart_CustomerAndName]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Search_ShoppingCart_CustomerAndOrderGroupId]    Script Date: 07/21/2009 17:25:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Search_ShoppingCart_CustomerAndOrderGroupId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Search_ShoppingCart_CustomerAndOrderGroupId]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Shipment_Delete]    Script Date: 07/21/2009 17:25:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Shipment_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Shipment_Delete]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Shipment_Insert]    Script Date: 07/21/2009 17:25:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Shipment_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Shipment_Insert]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Shipment_Update]    Script Date: 07/21/2009 17:25:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Shipment_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Shipment_Update]
GO

/****** Object:  StoredProcedure [dbo].[ecf_ShipmentDiscount_Delete]    Script Date: 07/21/2009 17:25:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_ShipmentDiscount_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_ShipmentDiscount_Delete]
GO

/****** Object:  StoredProcedure [dbo].[ecf_ShipmentDiscount_Insert]    Script Date: 07/21/2009 17:25:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_ShipmentDiscount_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_ShipmentDiscount_Insert]
GO

/****** Object:  StoredProcedure [dbo].[ecf_ShipmentDiscount_Update]    Script Date: 07/21/2009 17:25:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_ShipmentDiscount_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_ShipmentDiscount_Update]
GO

/****** Object:  StoredProcedure [dbo].[ecf_ShippingMethod_Language]    Script Date: 07/21/2009 17:25:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_ShippingMethod_Language]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_ShippingMethod_Language]
GO

/****** Object:  StoredProcedure [dbo].[ecf_ShippingMethod_ShippingMethodId]    Script Date: 07/21/2009 17:25:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_ShippingMethod_ShippingMethodId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_ShippingMethod_ShippingMethodId]
GO

/****** Object:  StoredProcedure [dbo].[ecf_ShippingOption_ShippingOptionId]    Script Date: 07/21/2009 17:25:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_ShippingOption_ShippingOptionId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_ShippingOption_ShippingOptionId]
GO

/****** Object:  StoredProcedure [dbo].[ecf_ShippingPackage]    Script Date: 07/21/2009 17:25:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_ShippingPackage]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_ShippingPackage]
GO

/****** Object:  StoredProcedure [dbo].[ecf_ShippingPackage_Name]    Script Date: 07/21/2009 17:25:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_ShippingPackage_Name]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_ShippingPackage_Name]
GO

/****** Object:  StoredProcedure [dbo].[ecf_ShippingPackage_PackageId]    Script Date: 07/21/2009 17:25:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_ShippingPackage_PackageId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_ShippingPackage_PackageId]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Tax]    Script Date: 07/21/2009 17:25:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Tax]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Tax]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Tax_TaxId]    Script Date: 07/21/2009 17:25:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Tax_TaxId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Tax_TaxId]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Tax_TaxName]    Script Date: 07/21/2009 17:25:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Tax_TaxName]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Tax_TaxName]
GO

/****** Object:  StoredProcedure [dbo].[ecf_GetTaxes]    Script Date: 07/21/2009 17:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_GetTaxes]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_GetTaxes]
GO

/****** Object:  StoredProcedure [dbo].[ecf_ShippingMethod_GetCases]    Script Date: 07/21/2009 17:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_ShippingMethod_GetCases]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_ShippingMethod_GetCases]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Jurisdiction]    Script Date: 07/21/2009 17:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Jurisdiction]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Jurisdiction]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Jurisdiction_JurisdictionCode]    Script Date: 07/21/2009 17:25:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Jurisdiction_JurisdictionCode]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Jurisdiction_JurisdictionCode]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Jurisdiction_JurisdictionGroupCode]    Script Date: 07/21/2009 17:25:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Jurisdiction_JurisdictionGroupCode]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Jurisdiction_JurisdictionGroupCode]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Jurisdiction_JurisdictionGroups]    Script Date: 07/21/2009 17:25:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Jurisdiction_JurisdictionGroups]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Jurisdiction_JurisdictionGroups]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Jurisdiction_JurisdictionGroupId]    Script Date: 07/21/2009 17:25:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Jurisdiction_JurisdictionGroupId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Jurisdiction_JurisdictionGroupId]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Jurisdiction_JurisdictionId]    Script Date: 07/21/2009 17:25:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Jurisdiction_JurisdictionId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Jurisdiction_JurisdictionId]
GO

/****** Object:  UserDefinedFunction [dbo].[ecf_splitlist]    Script Date: 07/21/2009 17:25:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_splitlist]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[ecf_splitlist]
GO

/****** Object:  StoredProcedure [dbo].[ecf_PickList_PickListId]    Script Date: 10/20/2010 12:48:25 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_PickList_PickListId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_PickList_PickListId]
GO

/****** Object:  StoredProcedure [dbo].[ecf_PickList_WarehouseCode]    Script Date: 10/20/2010 12:48:25 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_PickList_WarehouseCode]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_PickList_WarehouseCode]
GO

/****** Object:  StoredProcedure [dbo].[ecf_PickList]    Script Date: 10/25/2010 17:24:00 ******/
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_PickList]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_PickList]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Order_ReturnReasonsDictionairy]    Script Date: 05/13/2011 23:37:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Order_ReturnReasonsDictionairy]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Order_ReturnReasonsDictionairy]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Order_ReturnReasonsDictionairyId]    Script Date: 05/13/2011 23:37:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Order_ReturnReasonsDictionairyId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Order_ReturnReasonsDictionairyId]
GO

/****** Object:  StoredProcedure [dbo].[ecf_Order_ReturnReasonsDictionairyName]    Script Date: 05/13/2011 23:37:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Order_ReturnReasonsDictionairyName]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ecf_Order_ReturnReasonsDictionairyName]
GO

-- Remove SP
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_OrderGroupLockInsert]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) DROP PROCEDURE [dbo].[mc_OrderGroupLockInsert]
GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_OrderGroupLockUpdate]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) DROP PROCEDURE [dbo].[mc_OrderGroupLockUpdate]
GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_OrderGroupLockDelete]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) DROP PROCEDURE [dbo].[mc_OrderGroupLockDelete]
GO 
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_OrderGroupLockSelect]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) DROP PROCEDURE [dbo].[mc_OrderGroupLockSelect]
GO


-- Remove SP
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_OrderGroupNoteInsert]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) DROP PROCEDURE [dbo].[mc_OrderGroupNoteInsert]
GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_OrderGroupNoteUpdate]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) DROP PROCEDURE [dbo].[mc_OrderGroupNoteUpdate]
GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_OrderGroupNoteDelete]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) DROP PROCEDURE [dbo].[mc_OrderGroupNoteDelete]
GO 
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_OrderGroupNoteSelect]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) DROP PROCEDURE [dbo].[mc_OrderGroupNoteSelect]
GO

-- Create SP
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_OrderGroupNoteInsert]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_OrderGroupNoteInsert]
GO
CREATE PROCEDURE [dbo].[mc_OrderGroupNoteInsert]
@OrderGroupId AS Int,
@CustomerId AS UniqueIdentifier,
@Title AS NVarChar(4000),
@Type AS NVarChar(4000),
@Detail AS NText,
@Created AS DateTime,
@LineItemId AS Int,
@OrderNoteId AS Int = NULL OUTPUT
AS
BEGIN
SET NOCOUNT ON;

INSERT INTO [OrderGroupNote]
(
[OrderGroupId],
[CustomerId],
[Title],
[Type],
[Detail],
[Created],
[LineItemId])
VALUES(
@OrderGroupId,
@CustomerId,
@Title,
@Type,
@Detail,
@Created,
@LineItemId)
SELECT @OrderNoteId = SCOPE_IDENTITY();

END

GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_OrderGroupNoteUpdate]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_OrderGroupNoteUpdate]
GO
CREATE PROCEDURE [dbo].[mc_OrderGroupNoteUpdate]
@OrderGroupId AS Int,
@CustomerId AS UniqueIdentifier,
@Title AS NVarChar(4000),
@Type AS NVarChar(4000),
@Detail AS NText,
@Created AS DateTime,
@LineItemId AS Int,
@OrderNoteId AS Int
AS
BEGIN
SET NOCOUNT ON;

UPDATE [OrderGroupNote] SET
[OrderGroupId] = @OrderGroupId,
[CustomerId] = @CustomerId,
[Title] = @Title,
[Type] = @Type,
[Detail] = @Detail,
[Created] = @Created,
[LineItemId] = @LineItemId WHERE
[OrderNoteId] = @OrderNoteId

END

GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_OrderGroupNoteDelete]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_OrderGroupNoteDelete]
GO
CREATE PROCEDURE [dbo].[mc_OrderGroupNoteDelete]
@OrderNoteId AS Int
AS
BEGIN
SET NOCOUNT ON;

DELETE FROM [OrderGroupNote]
WHERE
[OrderNoteId] = @OrderNoteId

END

GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_OrderGroupNoteSelect]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_OrderGroupNoteSelect]
GO
CREATE PROCEDURE [dbo].[mc_OrderGroupNoteSelect]
@OrderNoteId AS Int
AS
BEGIN
SET NOCOUNT ON;

SELECT [t01].[OrderNoteId] AS [OrderNoteId], [t01].[OrderGroupId] AS [OrderGroupId], [t01].[CustomerId] AS [CustomerId], [t01].[Title] AS [Title], [t01].[Type] AS [Type], [t01].[Detail] AS [Detail], [t01].[Created] AS [Created], [t01].[LineItemId] AS [LineItemId]
FROM [OrderGroupNote] AS [t01]
WHERE ([t01].[OrderNoteId]=@OrderNoteId)

END
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_OrderGroupLockInsert]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_OrderGroupLockInsert]
GO
CREATE PROCEDURE [dbo].[mc_OrderGroupLockInsert]
@CustomerId AS UniqueIdentifier,
@Created AS DateTime,
@OrderGroupId AS Int,
@OrderLockId AS Int = NULL OUTPUT
AS
BEGIN
SET NOCOUNT ON;

INSERT INTO [OrderGroupLock]
(
[CustomerId],
[Created],
[OrderGroupId])
VALUES(
@CustomerId,
@Created,
@OrderGroupId)
SELECT @OrderLockId = SCOPE_IDENTITY();

END

GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_OrderGroupLockUpdate]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_OrderGroupLockUpdate]
GO
CREATE PROCEDURE [dbo].[mc_OrderGroupLockUpdate]
@CustomerId AS UniqueIdentifier,
@Created AS DateTime,
@OrderGroupId AS Int,
@OrderLockId AS Int
AS
BEGIN
SET NOCOUNT ON;

UPDATE [OrderGroupLock] SET
[CustomerId] = @CustomerId,
[Created] = @Created,
[OrderGroupId] = @OrderGroupId WHERE
[OrderLockId] = @OrderLockId

END

GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_OrderGroupLockDelete]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_OrderGroupLockDelete]
GO
CREATE PROCEDURE [dbo].[mc_OrderGroupLockDelete]
@OrderLockId AS Int
AS
BEGIN
SET NOCOUNT ON;

DELETE FROM [OrderGroupLock]
WHERE
[OrderLockId] = @OrderLockId

END

GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[mc_OrderGroupLockSelect]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[mc_OrderGroupLockSelect]
GO
CREATE PROCEDURE [dbo].[mc_OrderGroupLockSelect]
@OrderLockId AS Int
AS
BEGIN
SET NOCOUNT ON;

SELECT [t01].[OrderLockId] AS [OrderLockId], [t01].[CustomerId] AS [CustomerId], [t01].[Created] AS [Created], [t01].[OrderGroupId] AS [OrderGroupId]
FROM [OrderGroupLock] AS [t01]
WHERE ([t01].[OrderLockId]=@OrderLockId)

END
GO

-- End
/****** Object:  StoredProcedure [dbo].[GetOrderSchemaVersionNumber]    Script Date: 07/21/2009 17:25:28 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetOrderSchemaVersionNumber]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetOrderSchemaVersionNumber]
AS
	with PatchVersion (Major, Minor, Patch) as
		(SELECT max([Major]) as Major,
			max([Minor]) as Minor,
			max([Patch]) as Patch
			FROM [SchemaVersion_OrderSystem]),
	PatchDate (Major, Minor, Patch, InstallDate) as 
		(SELECT Major, Minor, Patch, InstallDate from [SchemaVersion_OrderSystem])
	SELECT PD.Major as Major, PD.Minor as Minor, PD.Patch as Patch, PD.InstallDate as InstallDate 
		FROM PatchDate PD, PatchVersion PV 
		WHERE PD.[Major]=PV.[Major] AND 
			PD.[Minor]=PV.[Minor] AND 
			PD.[Patch]=PV.[Patch]' 
END
GO


/****** Object:  StoredProcedure [dbo].[ecf_Country]    Script Date: 07/21/2009 17:25:29 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Country]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Country]
	@ApplicationId uniqueidentifier,
	@ReturnInactive bit = 0
AS
BEGIN
	select * from [Country] C 
		where [ApplicationId] = @ApplicationId and 
			(([Visible] = 1) or @ReturnInactive = 1)
		order by C.[Ordering], C.[Name]

	select SP.* from [StateProvince] SP 
		inner join [Country] C on C.[CountryId] = SP.[CountryId]
		where C.[ApplicationId] = @ApplicationId and 
			((C.[Visible] = 1) or @ReturnInactive = 1) and 
			((SP.[Visible] = 1) or @ReturnInactive = 1)
		order by SP.[Ordering], SP.[Name]
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_Country_Code]    Script Date: 07/21/2009 17:25:29 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Country_Code]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Country_Code]
	@ApplicationId uniqueidentifier,
	@Code nvarchar(3),
	@ReturnInactive bit = 0
AS
BEGIN
	select * from [Country] C 
		where [ApplicationId] = @ApplicationId and [Code] = @Code and
			((C.[Visible] = 1) or @ReturnInactive = 1)

	select SP.* from [StateProvince] SP 
		inner join [Country] C on C.[CountryId] = SP.[CountryId]
		where C.[ApplicationId] = @ApplicationId and C.[Code] = @Code and
			((C.[Visible] = 1) or @ReturnInactive = 1) and 
			((SP.[Visible] = 1) or @ReturnInactive = 1)
		order by SP.[Ordering], SP.[Name]
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_Country_CountryId]    Script Date: 07/21/2009 17:25:29 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Country_CountryId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Country_CountryId]
	@ApplicationId uniqueidentifier,
	@CountryId int,
	@ReturnInactive bit = 0
AS
BEGIN
	select * from [Country] C 
		where [ApplicationId] = @ApplicationId and [CountryId] = @CountryId and 
			((C.[Visible] = 1) or @ReturnInactive = 1)

	select SP.* from [StateProvince] SP 
		inner join [Country] C on C.[CountryId] = SP.[CountryId]
		where C.[ApplicationId] = @ApplicationId and SP.[CountryId] = @CountryId and 
			((C.[Visible] = 1) or @ReturnInactive = 1) and 
			((SP.[Visible] = 1) or @ReturnInactive = 1)
		order by SP.[Ordering], SP.[Name]
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_GetMostRecentOrder]    Script Date: 07/21/2009 17:25:29 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_GetMostRecentOrder]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_GetMostRecentOrder]
(
	@CustomerId uniqueidentifier, 
	@ApplicationId uniqueidentifier
)
AS
BEGIN
    declare @results udttOrderGroupId
    
    insert into @results (OrderGroupId)
	select top 1 [OrderGroupId]
	from [OrderGroup_PurchaseOrder] PO
	join OrderGroup OG on PO.ObjectId = OG.OrderGroupId
	where ([CustomerId] = @CustomerId) and ApplicationId = @ApplicationId
	ORDER BY ObjectId DESC

	exec dbo.ecf_Search_OrderGroup @results

	-- Return Purchase Order Details
	DECLARE @search_condition nvarchar(max)
    select OrderGroupId into #OrderSearchResults from @results
	SET @search_condition = N''INNER JOIN OrderGroup OG ON OG.OrderGroupId = T.ObjectId WHERE [T].[ObjectId] IN (SELECT [OrderGroupId] FROM #OrderSearchResults)''
	exec mdpsp_avto_OrderGroup_PurchaseOrder_Search NULL, ''''''OrderGroup'''' TableName, [OG].*'', @search_condition
END'
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_LineItem_Delete]    Script Date: 07/21/2009 17:25:29 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_LineItem_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_LineItem_Delete]
(
	@LineItemId int
)
AS
	SET NOCOUNT ON
	DECLARE @TempObjectId int	

	EXEC [dbo].[mdpsp_avto_LineItemEx_Delete] @LineItemId
	DELETE FROM [LineItemDiscount] WHERE [LineItemId] = @LineItemId
	DELETE FROM [LineItem] WHERE [LineItemId] = @LineItemId

	RETURN @@Error' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_LineItem_Insert]    Script Date: 07/21/2009 17:25:30 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_LineItem_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[ecf_LineItem_Insert]
(
	@LineItemId int = NULL OUTPUT,
	@OrderFormId int,
	@OrderGroupId int,
	@Catalog nvarchar(255),
	@CatalogNode nvarchar(255),
	@ParentCatalogEntryId nvarchar(255),
	@CatalogEntryId nvarchar(255),
	@Quantity money,
	@PlacedPrice money,
	@ListPrice money,
	@LineItemDiscountAmount money,
	@OrderLevelDiscountAmount money,
	@ShippingAddressId nvarchar(50),
	@ShippingMethodName nvarchar(128) = NULL,
	@ShippingMethodId uniqueidentifier,
	@ExtendedPrice money,
	@Description nvarchar(255) = NULL,
	@Status nvarchar(64) = NULL,
	@DisplayName nvarchar(128) = NULL,
	@AllowBackordersAndPreorders bit,
	@InStockQuantity money,
	@PreorderQuantity money,
	@BackorderQuantity money,
	@InventoryStatus int,
	@LineItemOrdering datetime,
	@ConfigurationId nvarchar(255) = NULL,
	@MinQuantity money,
	@MaxQuantity money,
	@ProviderId nvarchar(255) = NULL,
	@ReturnReason nvarchar(255)= NULL,
	@OrigLineItemId int = NULL,
	@ReturnQuantity money,
	@WarehouseCode nvarchar(50) = NULL,
    @IsInventoryAllocated bit = NULL
)
AS
	SET NOCOUNT ON

	INSERT INTO [LineItem]
	(
		[OrderFormId],
		[OrderGroupId],
		[Catalog],
		[CatalogNode],
		[ParentCatalogEntryId],
		[CatalogEntryId],
		[Quantity],
		[PlacedPrice],
		[ListPrice],
		[LineItemDiscountAmount],
		[OrderLevelDiscountAmount],
		[ShippingAddressId],
		[ShippingMethodName],
		[ShippingMethodId],
		[ExtendedPrice],
		[Description],
		[Status],
		[DisplayName],
		[AllowBackordersAndPreorders],
		[InStockQuantity],
		[PreorderQuantity],
		[BackorderQuantity],
		[InventoryStatus],
		[LineItemOrdering],
		[ConfigurationId],
		[MinQuantity],
		[MaxQuantity],
		[ProviderId],
		[ReturnReason],
		[OrigLineItemId],
		[ReturnQuantity],
		[WarehouseCode],
        [IsInventoryAllocated]
	)
	VALUES
	(
		@OrderFormId,
		@OrderGroupId,
		@Catalog,
		@CatalogNode,
		@ParentCatalogEntryId,
		@CatalogEntryId,
		@Quantity,
		@PlacedPrice,
		@ListPrice,
		@LineItemDiscountAmount,
		@OrderLevelDiscountAmount,
		@ShippingAddressId,
		@ShippingMethodName,
		@ShippingMethodId,
		@ExtendedPrice,
		@Description,
		@Status,
		@DisplayName,
		@AllowBackordersAndPreorders,
		@InStockQuantity,
		@PreorderQuantity,
		@BackorderQuantity,
		@InventoryStatus,
		@LineItemOrdering,
		@ConfigurationId,
		@MinQuantity,
		@MaxQuantity,
		@ProviderId,
		@ReturnReason,
		@OrigLineItemId,
		@ReturnQuantity,
		@WarehouseCode,
        @IsInventoryAllocated
	)

	SELECT @LineItemId = SCOPE_IDENTITY()

	RETURN @@Error
'
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_LineItem_Update]    Script Date: 07/21/2009 17:25:30 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_LineItem_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[ecf_LineItem_Update]
(
	@LineItemId int,
	@OrderFormId int,
	@OrderGroupId int,
	@Catalog nvarchar(255),
	@CatalogNode nvarchar(255),
	@ParentCatalogEntryId nvarchar(255),
	@CatalogEntryId nvarchar(255),
	@Quantity money,
	@PlacedPrice money,
	@ListPrice money,
	@LineItemDiscountAmount money,
	@OrderLevelDiscountAmount money,
	@ShippingAddressId nvarchar(255),
	@ShippingMethodName nvarchar(128) = NULL,
	@ShippingMethodId uniqueidentifier,
	@ExtendedPrice money,
	@Description nvarchar(255) = NULL,
	@Status nvarchar(64) = NULL,
	@DisplayName nvarchar(128) = NULL,
	@AllowBackordersAndPreorders bit,
	@InStockQuantity money,
	@PreorderQuantity money,
	@BackorderQuantity money,
	@InventoryStatus int,
	@LineItemOrdering datetime,
	@ConfigurationId nvarchar(255) = NULL,
	@MinQuantity money,
	@MaxQuantity money,
	@ProviderId nvarchar(255) = NULL,
	@ReturnReason nvarchar(255)= NULL,
	@OrigLineItemId int = NULL,
	@ReturnQuantity money,
	@WarehouseCode nvarchar(50) = NULL,
    @IsInventoryAllocated bit = NULL
)
AS
	SET NOCOUNT ON
	
	UPDATE [LineItem]
	SET
		[OrderFormId] = @OrderFormId,
		[OrderGroupId] = @OrderGroupId,
		[Catalog] = @Catalog,
		[CatalogNode] = @CatalogNode,
		[ParentCatalogEntryId] = @ParentCatalogEntryId,
		[CatalogEntryId] = @CatalogEntryId,
		[Quantity] = @Quantity,
		[PlacedPrice] = @PlacedPrice,
		[ListPrice] = @ListPrice,
		[LineItemDiscountAmount] = @LineItemDiscountAmount,
		[OrderLevelDiscountAmount] = @OrderLevelDiscountAmount,
		[ShippingAddressId] = @ShippingAddressId,
		[ShippingMethodName] = @ShippingMethodName,
		[ShippingMethodId] = @ShippingMethodId,
		[ExtendedPrice] = @ExtendedPrice,
		[Description] = @Description,
		[Status] = @Status,
		[DisplayName] = @DisplayName,
		[AllowBackordersAndPreorders] = @AllowBackordersAndPreorders,
		[InStockQuantity] = @InStockQuantity,
		[PreorderQuantity] = @PreorderQuantity,
		[BackorderQuantity] = @BackorderQuantity,
		[InventoryStatus] = @InventoryStatus,
		[LineItemOrdering] = @LineItemOrdering,
		[ConfigurationId] = @ConfigurationId,
		[MinQuantity] = @MinQuantity,
		[MaxQuantity] = @MaxQuantity,
		[ProviderId] = @ProviderId,
		[ReturnReason] = @ReturnReason,
		[OrigLineItemId] = @OrigLineItemId,
		[ReturnQuantity] = @ReturnQuantity,
		[WarehouseCode] = @WarehouseCode,
        [IsInventoryAllocated] = @IsInventoryAllocated
	WHERE 
		[LineItemId] = @LineItemId

	IF @@ERROR > 0
	BEGIN
		RAISERROR(''Concurrency Error'',16,1)
	END

	RETURN @@Error
'
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_LineItemDiscount_Delete]    Script Date: 07/21/2009 17:25:30 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_LineItemDiscount_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_LineItemDiscount_Delete]
(
	@LineItemDiscountId int
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [LineItemDiscount]
	WHERE  
		[LineItemDiscountId] = @LineItemDiscountId

	RETURN @@Error' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_LineItemDiscount_Insert]    Script Date: 07/21/2009 17:25:31 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_LineItemDiscount_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_LineItemDiscount_Insert]
(
	@LineItemDiscountId int = NULL OUTPUT,
	@LineItemId int,
	@DiscountId int,
	@OrderGroupId int,
	@DiscountAmount money,
	@DiscountCode nvarchar(50) = NULL,
	@DiscountName nvarchar(50) = NULL,
	@DisplayMessage nvarchar(100) = NULL,
	@DiscountValue money
)
AS
	SET NOCOUNT ON

	INSERT INTO [LineItemDiscount]
	(
		[LineItemId],
		[DiscountId],
		[OrderGroupId],
		[DiscountAmount],
		[DiscountCode],
		[DiscountName],
		[DisplayMessage],
		[DiscountValue]
	)
	VALUES
	(
		@LineItemId,
		@DiscountId,
		@OrderGroupId,
		@DiscountAmount,
		@DiscountCode,
		@DiscountName,
		@DisplayMessage,
		@DiscountValue
	)

	SELECT @LineItemDiscountId = SCOPE_IDENTITY()

	RETURN @@Error' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_LineItemDiscount_Update]    Script Date: 07/21/2009 17:25:31 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_LineItemDiscount_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_LineItemDiscount_Update]
(
	@LineItemDiscountId int,
	@LineItemId int,
	@DiscountId int,
	@OrderGroupId int,
	@DiscountAmount money,
	@DiscountCode nvarchar(50) = NULL,
	@DiscountName nvarchar(50) = NULL,
	@DisplayMessage nvarchar(100) = NULL,
	@DiscountValue money
)
AS
	SET NOCOUNT ON
	
	UPDATE [LineItemDiscount]
	SET
		[LineItemId] = @LineItemId,
		[DiscountId] = @DiscountId,
		[OrderGroupId] = @OrderGroupId,
		[DiscountAmount] = @DiscountAmount,
		[DiscountCode] = @DiscountCode,
		[DiscountName] = @DiscountName,
		[DisplayMessage] = @DisplayMessage,
		[DiscountValue] = @DiscountValue
	WHERE 
		[LineItemDiscountId] = @LineItemDiscountId

	RETURN @@Error' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_ord_CreateFTSQuery]    Script Date: 07/21/2009 17:25:31 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_ord_CreateFTSQuery]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_ord_CreateFTSQuery]
(
	@Language 					nvarchar(50),
	@FTSPhrase 					nvarchar(max),
    @AdvancedFTSPhrase 			nvarchar(max),
	@TableName   				sysname,	
	@FTSQuery 					nvarchar(max) OUTPUT
)
AS
BEGIN
	DECLARE @FTSFunction nvarchar(50)
	
	-- If @AdvancedFTSPhrase is not specified then determine the Freetext function to use
	IF (@AdvancedFTSPhrase IS NULL OR LEN(@AdvancedFTSPhrase) = 0)
	BEGIN
		-- Replace the single quotes with two single quotes
		SET @FTSPhrase = REPLACE(@FTSPhrase,N'''''''',N'''''''''''')
		-- If The search clause contains and then used Contains table else use FreeTextTable
		IF (Charindex(N'' and '', @FTSPhrase) = 0 )
		BEGIN
			-- If the Freetextsearch phrase ends with * then use containstable to support wildcard searching
			-- Also Add " to the search phrase. This is needed to support wildcard searching
			IF (substring(@FTSPhrase,len(@FTSPhrase),1) = N''*'')
			BEGIN
				SET @FTSFunction = N''ContainsTable''
				SET @FTSPhrase = N''"''+@FTSPhrase+N''"''
			END
			ELSE
				SET @FTSFunction = N''FreeTextTable''
		END
		ELSE
		BEGIN
			SET @FTSFunction = N''ContainsTable''
			-- Replace the logic operators Or and And to separate the 
			-- searchphrase into sub phrases
			SET @FTSPhrase = REPLACE(@FTSPhrase, N'' or '', N''") or formsof(inflectional,"'') 
			SET @FTSPhrase = REPLACE(@FTSPhrase, N'' and '', N''") and formsof(inflectional,"'') + N''")''
			Set @FTSPhrase = N''formsof(inflectional, "''+@FTSPhrase 
		END	
	END
	ELSE
	BEGIN
		SET @FTSFunction = N''ContainsTable''
		SET @FTSPhrase = @AdvancedFTSPhrase
	END

	SET @FTSQuery = N''''

	/*
		Now build the follow query:
			SELECT FTS.[KEY], FTS.Rank, META.*, LOC.* FROM 
			(
				SELECT FTS.[KEY], FTS.Rank FROM 
				FreeTextTable(CatalogEntryEx, *, N''plasma'') FTS
				UNION
				SELECT     LOC.ObjectId [KEY], FTS.Rank
				FROM         FREETEXTTABLE(CatalogEntryEx_Localization, *, N''plasma'') FTS INNER JOIN CatalogEntryEx_Localization LOC ON FTS.[KEY] = LOC.[ID]

			) FTS 
			INNER JOIN CatalogEntryEx META ON FTS.[KEY] = META.ObjectId
			INNER JOIN CatalogEntryEx_Localization LOC ON FTS.[KEY] = LOC.ObjectId
	*/

	SET @FTSQuery = N''SELECT FTS.[KEY], FTS.Rank, META.* /*, LOC.**/ FROM '' +
			N''('' +
				N'' SELECT FTS.[KEY], FTS.Rank FROM '' +
				@FTSFunction + N''('' + @TableName + N'', *, N'''''' + @FTSPhrase + N'''''') FTS '' +
				N''UNION '' +
				N''SELECT LOC.ObjectId [KEY], FTS.Rank FROM '' +
				@FTSFunction + N''('' + @TableName + N''_Localization, *, N'''''' + @FTSPhrase + N'''''') FTS INNER JOIN '' + @TableName + N''_Localization LOC ON FTS.[KEY] = LOC.[ID]'' +
			N'') FTS '' +
			N''INNER JOIN '' + @TableName + '' META ON FTS.[KEY] = META.ObjectId '' +
			N''INNER JOIN '' + @TableName + ''_Localization LOC ON FTS.[KEY] = LOC.ObjectId '' +
			N'' WHERE LOC.Language = '''''' + @Language + N''''''''

	--SET @FTSQuery = N''SELECT FTS.[KEY], FTS.Rank, META.*'' +	N'' FROM '' + @FTSFunction + N''('' + @TableName + N'', *, N'''''' + @FTSPhrase + N'''''') FTS INNER JOIN '' + @TableName + '' META ON FTS.[KEY] = META.ObjectId''
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_OrderForm_Delete]    Script Date: 07/21/2009 17:25:32 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_OrderForm_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_OrderForm_Delete]
(
	@OrderFormId int
)
AS
	SET NOCOUNT ON
	DECLARE @TempObjectId int	

	-- Delete line items
	DECLARE _cursor CURSOR READ_ONLY FOR 
		SELECT LineItemId FROM [LineItem] where OrderFormId = @OrderFormId
	OPEN _cursor
	FETCH NEXT FROM _cursor INTO @TempObjectId
	WHILE (@@fetch_status = 0) BEGIN
		DELETE FROM [LineItemDiscount] where LineItemId = @TempObjectId
		EXEC [dbo].[mdpsp_avto_LineItemEx_Delete] @TempObjectId
		FETCH NEXT FROM _cursor INTO @TempObjectId
	END
	CLOSE _cursor
	DEALLOCATE _cursor
	DELETE FROM [LineItem] where OrderFormId = @OrderFormId

	-- Delete payments
	DECLARE _cursor CURSOR READ_ONLY FOR 
		SELECT PaymentId FROM [OrderFormPayment] where OrderFormId = @OrderFormId
	OPEN _cursor
	FETCH NEXT FROM _cursor INTO @TempObjectId
	WHILE (@@fetch_status = 0) BEGIN
		EXEC [dbo].[mdpsp_avto_OrderFormPayment_CashCard_Delete] @TempObjectId
		EXEC [dbo].[mdpsp_avto_OrderFormPayment_CreditCard_Delete] @TempObjectId
		EXEC [dbo].[mdpsp_avto_OrderFormPayment_GiftCard_Delete] @TempObjectId	
		EXEC [dbo].[mdpsp_avto_OrderFormPayment_Invoice_Delete] @TempObjectId
		EXEC [dbo].[mdpsp_avto_OrderFormPayment_Other_Delete] @TempObjectId
		FETCH NEXT FROM _cursor INTO @TempObjectId
	END
	CLOSE _cursor
	DEALLOCATE _cursor
	DELETE FROM [OrderFormPayment] where OrderFormId = @OrderFormId

	-- Delete OrderFormDiscount
	DELETE FROM [OrderFormDiscount] where OrderFormId = @OrderFormId

	-- Delete Shipment
	DECLARE _cursor CURSOR READ_ONLY FOR 
		SELECT ShipmentId FROM [Shipment] where OrderFormId = @OrderFormId
	OPEN _cursor
	FETCH NEXT FROM _cursor INTO @TempObjectId
	WHILE (@@fetch_status = 0) BEGIN
		DELETE FROM [ShipmentDiscount] where ShipmentId = @TempObjectId
		EXEC [dbo].[mdpsp_avto_ShipmentEx_Delete] @TempObjectId
		FETCH NEXT FROM _cursor INTO @TempObjectId
	END
	CLOSE _cursor
	DEALLOCATE _cursor
	DELETE FROM [Shipment] where OrderFormId = @OrderFormId

	-- Delete OrderForm
	select @TempObjectId = OrderFormId FROM [OrderForm] where OrderFormId = @OrderFormId
	EXEC [dbo].[mdpsp_avto_OrderFormEx_Delete] @TempObjectId
	DELETE FROM [OrderForm] where OrderFormId = @OrderFormId

	RETURN @@Error' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_OrderForm_Insert]    Script Date: 07/21/2009 17:25:32 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_OrderForm_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_OrderForm_Insert]
(
	@OrderFormId int = NULL OUTPUT,
	@OrderGroupId int,
	@Name nvarchar(64) = NULL,
	@BillingAddressId nvarchar(50) = NULL,
	@DiscountAmount money,
	@SubTotal money,
	@ShippingTotal money,
	@HandlingTotal money,
	@TaxTotal money,
	@Total money,
	@Status nvarchar(64) = NULL,
	@ProviderId nvarchar(255) = NULL,
	@ReturnComment nvarchar(1024) = NULL,
	@ReturnType nvarchar(50) = NULL,
	@ReturnAuthCode nvarchar(255) = NULL,
	@OrigOrderFormId int = NULL,
	@ExchangeOrderGroupId int  = NULL,
	@AuthorizedPaymentTotal money,
	@CapturedPaymentTotal money
)
AS
	SET NOCOUNT ON

	INSERT INTO [OrderForm]
	(
		[OrderGroupId],
		[Name],
		[BillingAddressId],
		[DiscountAmount],
		[SubTotal],
		[ShippingTotal],
		[HandlingTotal],
		[TaxTotal],
		[Total],
		[Status],
		[ProviderId],
		[ReturnComment],
		[ReturnType],
		[ReturnAuthCode],
		[OrigOrderFormId],
		[ExchangeOrderGroupId],
		[AuthorizedPaymentTotal],
		[CapturedPaymentTotal]
		
	)
	VALUES
	(
		@OrderGroupId,
		@Name,
		@BillingAddressId,
		@DiscountAmount,
		@SubTotal,
		@ShippingTotal,
		@HandlingTotal,
		@TaxTotal,
		@Total,
		@Status,
		@ProviderId,
		@ReturnComment,
		@ReturnType,
		@ReturnAuthCode,
		@OrigOrderFormId,
		@ExchangeOrderGroupId,
		@AuthorizedPaymentTotal,
		@CapturedPaymentTotal
	)

	SELECT @OrderFormId = SCOPE_IDENTITY()

	RETURN @@Error' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_OrderForm_Update]    Script Date: 07/21/2009 17:25:32 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_OrderForm_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_OrderForm_Update]
(
	@OrderFormId int,
	@OrderGroupId int,
	@Name nvarchar(64) = NULL,
	@BillingAddressId nvarchar(50) = NULL,
	@DiscountAmount money,
	@SubTotal money,
	@ShippingTotal money,
	@HandlingTotal money,
	@TaxTotal money,
	@Total money,
	@Status nvarchar(64) = NULL,
	@ProviderId nvarchar(255) = NULL,
	@ReturnComment nvarchar(1024) = NULL,
	@ReturnType nvarchar(50) = NULL,
	@ReturnAuthCode nvarchar(255) = NULL,
	@OrigOrderFormId int = NULL,
	@ExchangeOrderGroupId int = NULL,
	@AuthorizedPaymentTotal money,
	@CapturedPaymentTotal money
)
AS
	SET NOCOUNT ON
	
	UPDATE [OrderForm]
	SET
		[OrderGroupId] = @OrderGroupId,
		[Name] = @Name,
		[BillingAddressId] = @BillingAddressId,
		[DiscountAmount] = @DiscountAmount,
		[SubTotal] = @SubTotal,
		[ShippingTotal] = @ShippingTotal,
		[HandlingTotal] = @HandlingTotal,
		[TaxTotal] = @TaxTotal,
		[Total] = @Total,
		[Status] = @Status,
		[ProviderId] = @ProviderId,
		[ReturnComment] = @ReturnComment,
		[ReturnType] = @ReturnType,
		[ReturnAuthCode] = @ReturnAuthCode,
		[OrigOrderFormId] = @OrigOrderFormId,
		[ExchangeOrderGroupId] = @ExchangeOrderGroupId,
		[AuthorizedPaymentTotal] = @AuthorizedPaymentTotal,
		[CapturedPaymentTotal] = @CapturedPaymentTotal
	WHERE 
		[OrderFormId] = @OrderFormId

	RETURN @@Error' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_OrderFormDiscount_Delete]    Script Date: 07/21/2009 17:25:32 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_OrderFormDiscount_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_OrderFormDiscount_Delete]
(
	@OrderFormDiscountId int
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [OrderFormDiscount]
	WHERE  
		[OrderFormDiscountId] = @OrderFormDiscountId

	RETURN @@Error' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_OrderFormDiscount_Insert]    Script Date: 07/21/2009 17:25:33 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_OrderFormDiscount_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_OrderFormDiscount_Insert]
(
	@OrderFormDiscountId int = NULL OUTPUT,
	@OrderFormId int,
	@DiscountId int,
	@OrderGroupId int,
	@DiscountAmount money,
	@DiscountCode nvarchar(50) = NULL,
	@DiscountName nvarchar(50) = NULL,
	@DisplayMessage nvarchar(100) = NULL,
	@DiscountValue money
)
AS
	SET NOCOUNT ON

	INSERT INTO [OrderFormDiscount]
	(
		[OrderFormId],
		[DiscountId],
		[OrderGroupId],
		[DiscountAmount],
		[DiscountCode],
		[DiscountName],
		[DisplayMessage],
		[DiscountValue]
	)
	VALUES
	(
		@OrderFormId,
		@DiscountId,
		@OrderGroupId,
		@DiscountAmount,
		@DiscountCode,
		@DiscountName,
		@DisplayMessage,
		@DiscountValue
	)

	SELECT @OrderFormDiscountId = SCOPE_IDENTITY()

	RETURN @@Error' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_OrderFormDiscount_Update]    Script Date: 07/21/2009 17:25:33 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_OrderFormDiscount_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_OrderFormDiscount_Update]
(
	@OrderFormDiscountId int,
	@OrderFormId int,
	@DiscountId int,
	@OrderGroupId int,
	@DiscountAmount money,
	@DiscountCode nvarchar(50) = NULL,
	@DiscountName nvarchar(50) = NULL,
	@DisplayMessage nvarchar(100) = NULL,
	@DiscountValue money
)
AS
	SET NOCOUNT ON
	
	UPDATE [OrderFormDiscount]
	SET
		[OrderFormId] = @OrderFormId,
		[DiscountId] = @DiscountId,
		[OrderGroupId] = @OrderGroupId,
		[DiscountAmount] = @DiscountAmount,
		[DiscountCode] = @DiscountCode,
		[DiscountName] = @DiscountName,
		[DisplayMessage] = @DisplayMessage,
		[DiscountValue] = @DiscountValue
	WHERE 
		[OrderFormDiscountId] = @OrderFormDiscountId

	RETURN @@Error' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_OrderFormPayment_Delete]    Script Date: 07/21/2009 17:25:33 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_OrderFormPayment_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_OrderFormPayment_Delete]
(
	@PaymentId int
)
AS
	SET NOCOUNT ON

	EXEC [dbo].[mdpsp_avto_OrderFormPayment_CashCard_Delete] @PaymentId
	EXEC [dbo].[mdpsp_avto_OrderFormPayment_CreditCard_Delete] @PaymentId
	EXEC [dbo].[mdpsp_avto_OrderFormPayment_GiftCard_Delete] @PaymentId	
	EXEC [dbo].[mdpsp_avto_OrderFormPayment_Invoice_Delete] @PaymentId
	EXEC [dbo].[mdpsp_avto_OrderFormPayment_Other_Delete] @PaymentId
	DELETE FROM [OrderFormPayment] WHERE [PaymentId] = @PaymentId 

	RETURN @@Error' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_OrderFormPayment_Insert]    Script Date: 07/21/2009 17:25:33 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_OrderFormPayment_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_OrderFormPayment_Insert]
(
	@PaymentId int = NULL OUTPUT,
	@OrderFormId int,
	@OrderGroupId int,
	@BillingAddressId nvarchar(50) = NULL,
	@PaymentMethodId uniqueidentifier,
	@PaymentMethodName nvarchar(128) = NULL,
	@CustomerName nvarchar(64) = NULL,
	@Amount money,
	@PaymentType int,
	@ValidationCode nvarchar(64) = NULL,
	@AuthorizationCode nvarchar(255) = NULL,
	@TransactionType nvarchar(255) = NULL,
	@TransactionID nvarchar(255) = NULL,
	@Status nvarchar(64) = NULL,
	@ImplementationClass nvarchar(255)
)
AS
	SET NOCOUNT ON

	INSERT INTO [OrderFormPayment]
	(
		[OrderFormId],
		[OrderGroupId],
		[BillingAddressId],
		[PaymentMethodId],
		[PaymentMethodName],
		[CustomerName],
		[Amount],
		[PaymentType],
		[ValidationCode],
		[AuthorizationCode],
		[TransactionType],
		[TransactionID],
		[Status],
		[ImplementationClass]
	)
	VALUES
	(
		@OrderFormId,
		@OrderGroupId,
		@BillingAddressId,
		@PaymentMethodId,
		@PaymentMethodName,
		@CustomerName,
		@Amount,
		@PaymentType,
		@ValidationCode,
		@AuthorizationCode,
		@TransactionType,
		@TransactionID,
		@Status,
		@ImplementationClass
	)

	SELECT @PaymentId = SCOPE_IDENTITY()

	RETURN @@Error' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_OrderFormPayment_Update]    Script Date: 07/21/2009 17:25:34 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_OrderFormPayment_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_OrderFormPayment_Update]
(
	@PaymentId int,
	@OrderFormId int,
	@OrderGroupId int,
	@BillingAddressId nvarchar(50) = NULL,
	@PaymentMethodId uniqueidentifier,
	@PaymentMethodName nvarchar(128) = NULL,
	@CustomerName nvarchar(64) = NULL,
	@Amount money,
	@PaymentType int,
	@ValidationCode nvarchar(64) = NULL,
	@AuthorizationCode nvarchar(255) = NULL,
	@TransactionType nvarchar(255) = NULL,
	@TransactionID nvarchar(255) = NULL,
	@Status nvarchar(64) = NULL,
	@ImplementationClass nvarchar(255)
)
AS
	SET NOCOUNT ON
	
	UPDATE [OrderFormPayment]
	SET
		[OrderFormId] = @OrderFormId,
		[OrderGroupId] = @OrderGroupId,
		[BillingAddressId] = @BillingAddressId,
		[PaymentMethodId] = @PaymentMethodId,
		[PaymentMethodName] = @PaymentMethodName,
		[CustomerName] = @CustomerName,
		[Amount] = @Amount,
		[PaymentType] = @PaymentType,
		[ValidationCode] = @ValidationCode,
		[AuthorizationCode] = @AuthorizationCode,
		[TransactionType] = @TransactionType,
		[TransactionID] = @TransactionID,
		[Status] = @Status,
		[ImplementationClass] = @ImplementationClass
	WHERE 
		[PaymentId] = @PaymentId

	RETURN @@Error' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_OrderGroup_Delete]    Script Date: 07/21/2009 17:25:34 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_OrderGroup_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[ecf_OrderGroup_Delete]
(
	@OrderGroupId int
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @TempObjectId int

	-- Delete OrderForm
	DECLARE _cursorOrderForm CURSOR READ_ONLY FAST_FORWARD FOR 
		SELECT OrderFormId FROM [OrderForm] where OrderGroupId = @OrderGroupId
	OPEN _cursorOrderForm
	FETCH NEXT FROM _cursorOrderForm INTO @TempObjectId
	WHILE (@@fetch_status = 0) BEGIN
		EXEC [dbo].[ecf_OrderForm_Delete] @TempObjectId
		FETCH NEXT FROM _cursorOrderForm INTO @TempObjectId
	END
	CLOSE _cursorOrderForm
	DEALLOCATE _cursorOrderForm
	
	-- Delete OrderGroupAddress
	DECLARE _cursor CURSOR READ_ONLY FAST_FORWARD FOR 
		SELECT OrderGroupAddressId FROM [OrderGroupAddress] where OrderGroupId = @OrderGroupId
	OPEN _cursor
	FETCH NEXT FROM _cursor INTO @TempObjectId
	WHILE (@@fetch_status = 0) BEGIN
	EXEC [dbo].[mdpsp_avto_OrderGroupAddressEx_Delete] @TempObjectId
		FETCH NEXT FROM _cursor INTO @TempObjectId
	END
	CLOSE _cursor
	DEALLOCATE _cursor
	DELETE FROM [OrderGroupAddress] where OrderGroupId = @OrderGroupId

	EXEC [dbo].[mdpsp_avto_OrderGroup_PaymentPlan_Delete] @OrderGroupId
	EXEC [dbo].[mdpsp_avto_OrderGroup_PurchaseOrder_Delete] @OrderGroupId
	EXEC [dbo].[mdpsp_avto_OrderGroup_ShoppingCart_Delete] @OrderGroupId
	DELETE FROM [OrderGroup] where OrderGroupId = @OrderGroupId

	RETURN @@Error
END
'
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_OrderGroup_Insert]    Script Date: 07/21/2009 17:25:34 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_OrderGroup_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Jooeun Lee>
-- Modified date: <7/24/2012>
-- Description:	<Added Market ID to the parameters>
-- =============================================

CREATE PROCEDURE [dbo].[ecf_OrderGroup_Insert]
(
	@OrderGroupId int OUT,
	@InstanceId uniqueidentifier,
	@ApplicationId uniqueidentifier,
	@AffiliateId uniqueidentifier,
	@Name nvarchar(64) = NULL,
	@CustomerId uniqueidentifier,
	@CustomerName nvarchar(64) = NULL,
	@AddressId nvarchar(50) = NULL,
	@ShippingTotal money,
	@HandlingTotal money,
	@TaxTotal money,
	@SubTotal money,
	@Total money,
	@BillingCurrency nvarchar(64) = NULL,
	@Status nvarchar(64) = NULL,
	@ProviderId nvarchar(255) = NULL,
	@SiteId nvarchar(255) = NULL,
	@OwnerOrg nvarchar(255) = NULL,
	@Owner nvarchar(255) = NULL,
	@MarketId nvarchar(8)
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

	if(@OrderGroupId is null)
	begin
		INSERT
		INTO [OrderGroup]
		(
			[InstanceId],
			[ApplicationId],
			[AffiliateId],
			[Name],
			[CustomerId],
			[CustomerName],
			[AddressId],
			[ShippingTotal],
			[HandlingTotal],
			[TaxTotal],
			[SubTotal],
			[Total],
			[BillingCurrency],
			[Status],
			[ProviderId],
			[SiteId],
			[OwnerOrg],
			[Owner],
			[MarketId]
		)
		VALUES
		(
			@InstanceId,
			@ApplicationId,
			@AffiliateId,
			@Name,
			@CustomerId,
			@CustomerName,
			@AddressId,
			@ShippingTotal,
			@HandlingTotal,
			@TaxTotal,
			@SubTotal,
			@Total,
			@BillingCurrency,
			@Status,
			@ProviderId,
			@SiteId,
			@OwnerOrg,
			@Owner,
			@MarketId
		)
		SELECT @OrderGroupId = SCOPE_IDENTITY()
	end

	SET @Err = @@Error

	RETURN @Err
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_OrderGroup_Update]    Script Date: 07/21/2009 17:25:34 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_OrderGroup_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Jooeun Lee>
-- Modified date: <7/24/2012>
-- Description:	<Added Market ID to the parameters>
-- =============================================

CREATE PROCEDURE [dbo].[ecf_OrderGroup_Update]
(
	@OrderGroupId int OUT,
	@InstanceId uniqueidentifier,
	@ApplicationId uniqueidentifier,
	@AffiliateId uniqueidentifier,
	@Name nvarchar(64) = NULL,
	@CustomerId uniqueidentifier,
	@CustomerName nvarchar(64) = NULL,
	@AddressId nvarchar(50) = NULL,
	@ShippingTotal money,
	@HandlingTotal money,
	@TaxTotal money,
	@SubTotal money,
	@Total money,
	@BillingCurrency nvarchar(64) = NULL,
	@Status nvarchar(64) = NULL,
	@ProviderId nvarchar(255) = NULL,
	@SiteId nvarchar(255) = NULL,
	@OwnerOrg nvarchar(255) = NULL,
	@Owner nvarchar(255) = NULL,
	@MarketId nvarchar(8)
)
AS
BEGIN

	SET NOCOUNT OFF
	DECLARE @Err int

		UPDATE [OrderGroup]
		SET
			[InstanceId] = @InstanceId,
			[ApplicationId] = @ApplicationId,
			[AffiliateId] = @AffiliateId,
			[Name] = @Name,
			[CustomerId] = @CustomerId,
			[CustomerName] = @CustomerName,
			[AddressId] = @AddressId,
			[ShippingTotal] = @ShippingTotal,
			[HandlingTotal] = @HandlingTotal,
			[TaxTotal] = @TaxTotal,
			[SubTotal] = @SubTotal,
			[Total] = @Total,
			[BillingCurrency] = @BillingCurrency,
			[Status] = @Status,
			[ProviderId] = @ProviderId,
			[SiteId] = @SiteId,
			[OwnerOrg] = @OwnerOrg,
			[Owner] = @Owner,
			[MarketId] = @MarketId
		WHERE
			[OrderGroupId] = @OrderGroupId

	SET @Err = @@Error

	RETURN @Err
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_OrderGroupAddress_Delete]    Script Date: 07/21/2009 17:25:35 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_OrderGroupAddress_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_OrderGroupAddress_Delete]
(
	@OrderGroupAddressId int
)
AS
	SET NOCOUNT ON

	EXEC [dbo].[mdpsp_avto_OrderGroupAddressEx_Delete] @OrderGroupAddressId
	DELETE FROM [OrderGroupAddress] WHERE [OrderGroupAddressId] = @OrderGroupAddressId

	RETURN @@Error' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_OrderGroupAddress_Insert]    Script Date: 07/21/2009 17:25:35 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_OrderGroupAddress_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_OrderGroupAddress_Insert]
(
	@OrderGroupAddressId int = NULL OUTPUT,
	@OrderGroupId int,
	@Name nvarchar(64) = NULL,
	@FirstName nvarchar(64) = NULL,
	@LastName nvarchar(64) = NULL,
	@Organization nvarchar(64) = NULL,
	@Line1 nvarchar(80) = NULL,
	@Line2 nvarchar(80) = NULL,
	@City nvarchar(64) = NULL,
	@State nvarchar(64) = NULL,
	@CountryCode nvarchar(50) = NULL,
	@CountryName nvarchar(50) = NULL,
	@PostalCode nvarchar(20) = NULL,
	@RegionCode nvarchar(50) = NULL,
	@RegionName nvarchar(64) = NULL,
	@DaytimePhoneNumber nvarchar(32) = NULL,
	@EveningPhoneNumber nvarchar(32) = NULL,
	@FaxNumber nvarchar(32) = NULL,
	@Email nvarchar(64) = NULL
)
AS
	SET NOCOUNT ON

	INSERT INTO [OrderGroupAddress]
	(
		[OrderGroupId],
		[Name],
		[FirstName],
		[LastName],
		[Organization],
		[Line1],
		[Line2],
		[City],
		[State],
		[CountryCode],
		[CountryName],
		[PostalCode],
		[RegionCode],
		[RegionName],
		[DaytimePhoneNumber],
		[EveningPhoneNumber],
		[FaxNumber],
		[Email]
	)
	VALUES
	(
		@OrderGroupId,
		@Name,
		@FirstName,
		@LastName,
		@Organization,
		@Line1,
		@Line2,
		@City,
		@State,
		@CountryCode,
		@CountryName,
		@PostalCode,
		@RegionCode,
		@RegionName,
		@DaytimePhoneNumber,
		@EveningPhoneNumber,
		@FaxNumber,
		@Email
	)

	SELECT @OrderGroupAddressId = SCOPE_IDENTITY()

	RETURN @@Error' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_OrderGroupAddress_Update]    Script Date: 07/21/2009 17:25:35 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_OrderGroupAddress_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_OrderGroupAddress_Update]
(
	@OrderGroupAddressId int,
	@OrderGroupId int,
	@Name nvarchar(64) = NULL,
	@FirstName nvarchar(64) = NULL,
	@LastName nvarchar(64) = NULL,
	@Organization nvarchar(64) = NULL,
	@Line1 nvarchar(80) = NULL,
	@Line2 nvarchar(80) = NULL,
	@City nvarchar(64) = NULL,
	@State nvarchar(64) = NULL,
	@CountryCode nvarchar(50) = NULL,
	@CountryName nvarchar(50) = NULL,
	@PostalCode nvarchar(20) = NULL,
	@RegionCode nvarchar(50) = NULL,
	@RegionName nvarchar(64) = NULL,
	@DaytimePhoneNumber nvarchar(32) = NULL,
	@EveningPhoneNumber nvarchar(32) = NULL,
	@FaxNumber nvarchar(32) = NULL,
	@Email nvarchar(64) = NULL
)
AS
	SET NOCOUNT ON
	
	UPDATE [OrderGroupAddress]
	SET
		[OrderGroupId] = @OrderGroupId,
		[Name] = @Name,
		[FirstName] = @FirstName,
		[LastName] = @LastName,
		[Organization] = @Organization,
		[Line1] = @Line1,
		[Line2] = @Line2,
		[City] = @City,
		[State] = @State,
		[CountryCode] = @CountryCode,
		[CountryName] = @CountryName,
		[PostalCode] = @PostalCode,
		[RegionCode] = @RegionCode,
		[RegionName] = @RegionName,
		[DaytimePhoneNumber] = @DaytimePhoneNumber,
		[EveningPhoneNumber] = @EveningPhoneNumber,
		[FaxNumber] = @FaxNumber,
		[Email] = @Email
	WHERE 
		[OrderGroupAddressId] = @OrderGroupAddressId

	RETURN @@Error' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_OrderSearch]    Script Date: 07/21/2009 17:25:36 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_OrderSearch]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_OrderSearch]
(
	@ApplicationId				uniqueidentifier,
	@SQLClause 					nvarchar(max),
	@MetaSQLClause 				nvarchar(max),
	@FTSPhrase 					nvarchar(max),
    @AdvancedFTSPhrase 			nvarchar(max),
    @OrderBy 					nvarchar(max),
	@Namespace					nvarchar(1024) = N'''',
	@Classes					nvarchar(max) = N'''',
    @StartingRec 				int,
	@NumRecords   				int,
	@RecordCount                int OUTPUT
)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @query_tmp nvarchar(max)
	DECLARE @FilterQuery_tmp nvarchar(max)
	DECLARE @TableName_tmp sysname
	DECLARE @SelectMetaQuery_tmp nvarchar(max)
	DECLARE @FromQuery_tmp nvarchar(max)
	DECLARE @FullQuery nvarchar(max)

	-- 1. Cycle through all the available product meta classes
	print ''Iterating through meta classes''
	DECLARE MetaClassCursor CURSOR READ_ONLY
	FOR SELECT TableName FROM MetaClass 
		WHERE Namespace like @Namespace + ''%'' AND ([Name] in (select Item from ecf_splitlist(@Classes)) or @Classes = '''')
		and IsSystem = 0

	OPEN MetaClassCursor
	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	WHILE (@@fetch_status = 0)
	BEGIN 
		print ''Metaclass Table: '' + @TableName_tmp
		IF OBJECTPROPERTY(object_id(@TableName_tmp), ''TableHasActiveFulltextIndex'') = 1
		begin
			if(LEN(@FTSPhrase)>0 OR LEN(@AdvancedFTSPhrase)>0)
				EXEC [dbo].[ecf_ord_CreateFTSQuery] @FTSPhrase, @AdvancedFTSPhrase, @TableName_tmp, @Query_tmp OUT
			else
				set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''', * from '' + @TableName_tmp + '' META''
		end
		else
		begin 
			set @Query_tmp = ''select 100 as ''''Rank'''', META.ObjectId as ''''Key'''', * from '' + @TableName_tmp + '' META''
		end

		-- Add meta Where clause
		if(LEN(@MetaSQLClause)>0)
			set @query_tmp = @query_tmp + '' WHERE '' + @MetaSQLClause

		if(@SelectMetaQuery_tmp is null)
			set @SelectMetaQuery_tmp = @Query_tmp;
		else
			set @SelectMetaQuery_tmp = @SelectMetaQuery_tmp + N'' UNION ALL '' + @Query_tmp;

	FETCH NEXT FROM MetaClassCursor INTO @TableName_tmp
	END
	CLOSE MetaClassCursor
	DEALLOCATE MetaClassCursor

	-- Create from command
	SET @FromQuery_tmp = N''FROM [OrderGroup] OrderGroup'' + N'' INNER JOIN (select distinct U.[KEY], U.Rank from ('' + @SelectMetaQuery_tmp + N'') U) META ON OrderGroup.[OrderGroupId] = META.[KEY] ''

	set @FilterQuery_tmp = N'' WHERE ApplicationId = '''''' + CAST(@ApplicationId as nvarchar(36)) + ''''''''
	-- add sql clause statement here, if specified
	if(Len(@SQLClause) != 0)
		set @FilterQuery_tmp = @FilterQuery_tmp + N'' AND ('' + @SqlClause + '')''

	if(Len(@OrderBy) = 0)
	begin
		set @OrderBy = ''[OrderGroup].OrderGroupId''
	end

	set @FullQuery = N''SELECT count([OrderGroup].OrderGroupId) OVER() TotalRecords, [OrderGroup].OrderGroupId, Rank, ROW_NUMBER() OVER(ORDER BY '' + @OrderBy + N'') RowNumber '' + @FromQuery_tmp + @FilterQuery_tmp

	-- use temp table variable
	set @FullQuery = N''with OrderedResults as ('' + @FullQuery +'') INSERT INTO @Page_temp (TotalRecords, OrderGroupId) SELECT top('' + cast(@NumRecords as nvarchar(50)) + '') TotalRecords, OrderGroupId FROM OrderedResults WHERE RowNumber > '' + cast(@StartingRec as nvarchar(50)) + '';''
	set @FullQuery = ''declare @Page_temp table (TotalRecords int, OrderGroupId int);'' + @FullQuery + '';select @RecordCount = TotalRecords from @Page_temp;SELECT OrderGroupId from @Page_temp;''
	--print @FullQuery
	exec sp_executesql @FullQuery, N''@RecordCount int output'', @RecordCount = @RecordCount OUTPUT

	SET NOCOUNT OFF
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_PaymentMethod_Language]    Script Date: 07/21/2009 17:25:36 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_PaymentMethod_Language]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_PaymentMethod_Language]
	@ApplicationId uniqueidentifier,
	@LanguageId nvarchar(128),
	@ReturnInactive bit = 0
AS
BEGIN
	select * from [PaymentMethod] 
	where COALESCE(@LanguageId, [LanguageId]) = [LanguageId] and 
		(([IsActive] = 1) or @ReturnInactive = 1) and 
		[ApplicationId] = @ApplicationId order by [Ordering]

	select PMP.* from [PaymentMethodParameter] PMP 
	inner join [PaymentMethod] PM on PMP.[PaymentMethodId] = PM.[PaymentMethodId] 
		where COALESCE(@LanguageId, PM.[LanguageId]) = [LanguageId] and 
		((PM.[IsActive] = 1) or @ReturnInactive = 1) and 
		PM.[ApplicationId] = @ApplicationId

	select SPR.* from [ShippingPaymentRestriction] SPR  
	inner join [PaymentMethod] PM on SPR.[PaymentMethodId] = PM.[PaymentMethodId] 
		where COALESCE(@LanguageId, PM.[LanguageId]) = [LanguageId] and 
		((PM.[IsActive] = 1) or @ReturnInactive = 1) and 
		PM.[ApplicationId] = @ApplicationId and SPR.[RestrictShippingMethods]=0
			
	select MPM.* from [MarketPaymentMethods] MPM  
	inner join [PaymentMethod] PM on MPM.[PaymentMethodId] = PM.[PaymentMethodId] 
		where COALESCE(@LanguageId, PM.[LanguageId]) = [LanguageId] and 
		((PM.[IsActive] = 1) or @ReturnInactive = 1) and
		PM.[ApplicationId] = @ApplicationId
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_PaymentMethod_Market]    Script Date: 03/05/2013 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_PaymentMethod_Market]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_PaymentMethod_Market]
	@ApplicationId uniqueidentifier,
	@MarketId nvarchar(8),
	@LanguageId nvarchar(128),
	@ReturnInactive bit = 0
AS
BEGIN
	select PM.* from [PaymentMethod] PM
	inner join [MarketPaymentMethods] PMM on PMM.[PaymentMethodId] = PM.[PaymentMethodId]
		where COALESCE(@MarketId, PMM.[MarketId]) = PMM.[MarketId] and
		COALESCE(@LanguageId, PM.[LanguageId]) = PM.[LanguageId] and
		((PM.[IsActive] = 1) or @ReturnInactive = 1) and
		PM.[ApplicationId] = @ApplicationId

	select PMP.* from [PaymentMethodParameter] PMP
	inner join [PaymentMethod] PM on PMP.[PaymentMethodId] = PM.[PaymentMethodId] 
	inner join [MarketPaymentMethods] PMM on PMM.[PaymentMethodId] = PM.[PaymentMethodId] 
		where COALESCE(@MarketId, PMM.[MarketId]) = PMM.[MarketId] and 
		COALESCE(@LanguageId, PM.[LanguageId]) = PM.[LanguageId] and
		((PM.[IsActive] = 1) or @ReturnInactive = 1) and 
		PM.[ApplicationId] = @ApplicationId

	select SPR.* from [ShippingPaymentRestriction] SPR  
	inner join [PaymentMethod] PM on SPR.[PaymentMethodId] = PM.[PaymentMethodId] 
	inner join [MarketPaymentMethods] PMM on PMM.[PaymentMethodId] = PM.[PaymentMethodId]
		where COALESCE(@MarketId, PMM.[MarketId]) = PMM.[MarketId] and
		COALESCE(@LanguageId, PM.[LanguageId]) = PM.[LanguageId] and 
		((PM.[IsActive] = 1) or @ReturnInactive = 1) and 
		PM.[ApplicationId] = @ApplicationId and SPR.[RestrictShippingMethods]=0

	select MPM.* from [MarketPaymentMethods] MPM  
	inner join [PaymentMethod] PM on MPM.[PaymentMethodId] = PM.[PaymentMethodId] 
		where COALESCE(@LanguageId, PM.[LanguageId]) = [LanguageId] and 
		MPM.[MarketId] = @MarketId and
		((PM.[IsActive] = 1) or @ReturnInactive = 1) and 
		PM.[ApplicationId] = @ApplicationId

END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_PaymentMethod_PaymentMethodId]    Script Date: 07/21/2009 17:25:36 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_PaymentMethod_PaymentMethodId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_PaymentMethod_PaymentMethodId]
	@ApplicationId uniqueidentifier,
	@PaymentMethodId uniqueidentifier,
	@ReturnInactive bit = 0
AS
BEGIN
	select * from [PaymentMethod] 
		where [PaymentMethodId] = @PaymentMethodId and 
			[ApplicationId] = @ApplicationId and (([IsActive] = 1) or @ReturnInactive = 1)

	if @@rowcount > 0 begin
		select * from [PaymentMethodParameter] 
			where [PaymentMethodId] = @PaymentMethodId

		select * from [ShippingPaymentRestriction] 
			where [PaymentMethodId] = @PaymentMethodId and [RestrictShippingMethods] = 1
	end
	else begin
		-- select nothing
		select * from [PaymentMethodParameter] where 1=0
		select * from [ShippingPaymentRestriction] where 1=0
	end
		select MPM.* from [MarketPaymentMethods] MPM  
		inner join [PaymentMethod] PM on MPM.[PaymentMethodId] = PM.[PaymentMethodId] 
		where ((PM.[IsActive] = 1) or @ReturnInactive = 1) and 
		MPM.[PaymentMethodId] = @PaymentMethodId and
		PM.[ApplicationId] = @ApplicationId
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_PaymentMethod_SystemKeyword]    Script Date: 07/21/2009 17:25:36 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_PaymentMethod_SystemKeyword]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_PaymentMethod_SystemKeyword]
	@ApplicationId uniqueidentifier,
	@SystemKeyword nvarchar(30),
	@LanguageId nvarchar(128),
	@MarketId nvarchar(8),
	@ReturnInactive bit = 0
AS
BEGIN
	select * from [PaymentMethod] 
	where COALESCE(@LanguageId, [LanguageId]) = [LanguageId] and 
		(([IsActive] = 1) or @ReturnInactive = 1) and 
		COALESCE (@SystemKeyword, [SystemKeyword]) = [SystemKeyword] and 
		[ApplicationId] = @ApplicationId order by [Ordering]

	select PMP.* from [PaymentMethodParameter] PMP 
	inner join [PaymentMethod] PM on PMP.[PaymentMethodId] = PM.[PaymentMethodId] 
		where COALESCE(@LanguageId, PM.[LanguageId]) = [LanguageId] and 
		(PM.[SystemKeyword] = @SystemKeyword) and 
		((PM.[IsActive] = 1) or @ReturnInactive = 1) and 
		PM.[ApplicationId] = @ApplicationId

	select SPR.* from [ShippingPaymentRestriction] SPR  
	inner join [PaymentMethod] PM on SPR.[PaymentMethodId] = PM.[PaymentMethodId] 
		where COALESCE(@LanguageId, PM.[LanguageId]) = [LanguageId] and 
		(PM.[SystemKeyword] = @SystemKeyword) and 
		((PM.[IsActive] = 1) or @ReturnInactive = 1) and 
		PM.[ApplicationId] = @ApplicationId and SPR.[RestrictShippingMethods]=1
	
	select MPM.* from [MarketPaymentMethods] MPM  
	inner join [PaymentMethod] PM on MPM.[PaymentMethodId] = PM.[PaymentMethodId] 
		where COALESCE(@LanguageId, PM.[LanguageId]) = [LanguageId] and 
		COALESCE (@SystemKeyword, [SystemKeyword]) = [SystemKeyword] and
		COALESCE (@MarketId, [MarketId]) = [MarketId] and
		((PM.[IsActive] = 1) or @ReturnInactive = 1) and
		PM.[ApplicationId] = @ApplicationId
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_Search_OrderGroup]    Script Date: 07/21/2009 17:25:37 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Search_OrderGroup]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Search_OrderGroup]
    @results udttOrderGroupId readonly
AS
BEGIN

DECLARE @search_condition nvarchar(max)

-- Return GroupIds.
SELECT [OrderGroupId] FROM @results


-- Prevent any queries if order group doesn''t exist
IF NOT EXISTS(SELECT * from OrderGroup G INNER JOIN @results R ON G.OrderGroupId = R.OrderGroupId)
	RETURN;

-- Return Order Form Collection
SELECT ''OrderForm'' TableName, OE.*, O.*
	FROM [OrderFormEx] OE 
		INNER JOIN OrderForm O ON O.OrderFormId = OE.ObjectId 
		INNER JOIN @results R ON O.OrderGroupId = R.OrderGroupId 

if(@@ROWCOUNT = 0)
	RETURN;

-- Return Order Form Collection
SELECT ''OrderGroupAddress'' TableName, OE.*, O.*
	FROM [OrderGroupAddressEx] OE 
		INNER JOIN OrderGroupAddress O ON O.OrderGroupAddressId = OE.ObjectId  
		INNER JOIN @results R ON O.OrderGroupId = R.OrderGroupId 

-- Return Shipment Collection
SELECT ''Shipment'' TableName, SE.*, S.*
	FROM [ShipmentEx] SE 
		INNER JOIN Shipment S ON S.ShipmentId = SE.ObjectId 
		INNER JOIN @results R ON S.OrderGroupId = R.OrderGroupId 

-- Return Line Item Collection
SELECT ''LineItem'' TableName, LE.*, L.*
	FROM [LineItemEx] LE 
		INNER JOIN LineItem L ON L.LineItemId = LE.ObjectId 
		INNER JOIN @results R ON L.OrderGroupId = R.OrderGroupId 

-- Return Order Form Payment Collection

select OrderGroupId into #OrderSearchResults from @results
SET @search_condition = N''''''INNER JOIN OrderFormPayment O ON O.PaymentId = T.ObjectId INNER JOIN #OrderSearchResults R ON O.OrderGroupId = R.OrderGroupId ''''''

DECLARE @metaclassid int
DECLARE @parentclassid int
DECLARE @parentmetaclassid int
DECLARE @rowNum int
DECLARE @maxrows int
DECLARE @tablename nvarchar(120)
DECLARE @name nvarchar(120)
DECLARE @procedurefull nvarchar(max)

SET @parentmetaclassid = (SELECT MetaClassId from [Metaclass] WHERE Name = N''orderformpayment'' and TableName = N''orderformpayment'')

SELECT top 1 @metaclassid = MetaClassId, @tablename = TableName, @parentclassid = ParentClassId, @name = Name from [Metaclass]
	SELECT @maxRows = count(*) from [Metaclass]
	SET @rowNum = 0
	WHILE @rowNum < @maxRows
	BEGIN
		SET @rowNum = @rowNum + 1
		IF (@parentclassid = @parentmetaclassid)
		BEGIN
			SET @procedurefull = N''mdpsp_avto_'' + @tablename + N''_Search NULL, '' + N'''''''''''''''' + @tablename + N''''''''''''+  '' TableName, [O].*'''' ,''  + @search_condition
			EXEC (@procedurefull)
		END
		SELECT top 1 @metaclassid = MetaClassId, @tablename = TableName, @parentclassid = ParentClassId, @name = Name from [Metaclass] where MetaClassId > @metaclassid
	END

-- Return Order Form Discount Collection
SELECT ''OrderFormDiscount'' TableName, D.* 
	FROM [OrderFormDiscount] D 
		INNER JOIN @results R ON D.OrderGroupId = R.OrderGroupId 

-- Return Line Item Discount Collection
SELECT ''LineItemDiscount'' TableName, D.* 
	FROM [LineItemDiscount] D 
		INNER JOIN @results R ON D.OrderGroupId = R.OrderGroupId 

-- Return Shipment Discount Collection
SELECT ''ShipmentDiscount'' TableName, D.* 
	FROM [ShipmentDiscount] D 
		INNER JOIN @results R ON D.OrderGroupId = R.OrderGroupId 

-- assign random local variable to set @@rowcount attribute to 1
declare @temp as int
set @temp = 1

END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_Search_PaymentPlan]    Script Date: 07/21/2009 17:25:37 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Search_PaymentPlan]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Search_PaymentPlan]
    @ApplicationId				uniqueidentifier,
	@SQLClause 					nvarchar(max),
	@MetaSQLClause 				nvarchar(max),
	@FTSPhrase 					nvarchar(max),
    @AdvancedFTSPhrase 			nvarchar(max),
    @OrderBy 					nvarchar(max),
	@Namespace					nvarchar(1024) = N'''',
	@Classes					nvarchar(max) = N'''',
    @StartingRec 				int,
	@NumRecords   				int,
	@RecordCount                int OUTPUT
AS
BEGIN
    declare @results udttOrderGroupId
    insert into @results (OrderGroupId)    
    exec dbo.ecf_OrderSearch
        @ApplicationId, 
        @SQLClause, 
        @MetaSQLClause, 
        @FTSPhrase, 
        @AdvancedFTSPhrase, 
        @OrderBy, 
        @namespace, 
        @Classes, 
        @StartingRec, 
        @NumRecords, 
        @RecordCount output
	
	exec [dbo].[ecf_Search_OrderGroup] @results

    -- Return Purchase Order Details
	DECLARE @search_condition nvarchar(max)
	select OrderGroupId into #OrderSearchResults from @results
	SET @search_condition = N''INNER JOIN OrderGroup OG ON OG.OrderGroupId = T.ObjectId WHERE [T].[ObjectId] IN (SELECT [OrderGroupId] FROM #OrderSearchResults)''
	exec mdpsp_avto_OrderGroup_PaymentPlan_Search NULL, ''''''OrderGroup'''' TableName, [OG].*'', @search_condition
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_Search_PaymentPlan_Customer]    Script Date: 07/21/2009 17:25:37 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Search_PaymentPlan_Customer]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Search_PaymentPlan_Customer]
	@ApplicationId uniqueidentifier,
    @CustomerId uniqueidentifier
AS
BEGIN
	declare @results udttOrderGroupId
    
    insert into @results (OrderGroupId)    
    select OrderGroupId 
    from [OrderGroup_PaymentPlan] PO 
    join OrderGroup OG on PO.ObjectId = OG.OrderGroupId
    where ([CustomerId] = @CustomerId) and ApplicationId = @ApplicationId
        
    exec [dbo].[ecf_Search_OrderGroup] @results

    -- Return Purchase Order Details
	DECLARE @search_condition nvarchar(max)
	select OrderGroupId into #OrderSearchResults from @results
	SET @search_condition = N''INNER JOIN OrderGroup OG ON OG.OrderGroupId = T.ObjectId WHERE [T].[ObjectId] IN (SELECT [OrderGroupId] FROM #OrderSearchResults)''
	exec mdpsp_avto_OrderGroup_PaymentPlan_Search NULL, ''''''OrderGroup'''' TableName, [OG].*'', @search_condition
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_Search_PaymentPlan_CustomerAndName]    Script Date: 07/21/2009 17:25:37 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Search_PaymentPlan_CustomerAndName]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Search_PaymentPlan_CustomerAndName]
	@ApplicationId uniqueidentifier,
    @CustomerId uniqueidentifier,
	@Name nvarchar(64)
AS
BEGIN
	declare @results udttOrderGroupId
    
    insert into @results (OrderGroupId)    
    select OrderGroupId 
    from [OrderGroup_PaymentPlan] PO 
    join OrderGroup OG on PO.ObjectId = OG.OrderGroupId 
    where ([CustomerId] = @CustomerId) and [Name] = @Name and ApplicationId = @ApplicationId
    
    exec [dbo].[ecf_Search_OrderGroup] @results

    -- Return Purchase Order Details
	DECLARE @search_condition nvarchar(max)
	select OrderGroupId into #OrderSearchResults from @results
	SET @search_condition = N''INNER JOIN OrderGroup OG ON OG.OrderGroupId = T.ObjectId WHERE [T].[ObjectId] IN (SELECT [OrderGroupId] FROM #OrderSearchResults)''
	exec mdpsp_avto_OrderGroup_PaymentPlan_Search NULL, ''''''OrderGroup'''' TableName, [OG].*'', @search_condition
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_Search_PaymentPlan_CustomerAndOrderGroupId]    Script Date: 07/21/2009 17:25:38 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Search_PaymentPlan_CustomerAndOrderGroupId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Search_PaymentPlan_CustomerAndOrderGroupId]
	@ApplicationId uniqueidentifier,
    @CustomerId uniqueidentifier,
    @OrderGroupId int
AS
BEGIN
	declare @results udttOrderGroupId
    
    insert into @results (OrderGroupId)    
    select OrderGroupId 
    from [OrderGroup_PaymentPlan] PO 
    join OrderGroup OG on PO.ObjectId = OG.OrderGroupId 
    where (PO.ObjectId = @OrderGroupId) and CustomerId = @CustomerId and ApplicationId = @ApplicationId
            
    exec [dbo].[ecf_Search_OrderGroup] @results

    -- Return Purchase Order Details
	DECLARE @search_condition nvarchar(max)
	select OrderGroupId into #OrderSearchResults from @results
	SET @search_condition = N''INNER JOIN OrderGroup OG ON OG.OrderGroupId = T.ObjectId WHERE [T].[ObjectId] IN (SELECT [OrderGroupId] FROM #OrderSearchResults)''
	exec mdpsp_avto_OrderGroup_PaymentPlan_Search NULL, ''''''OrderGroup'''' TableName, [OG].*'', @search_condition
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_Search_PurchaseOrder]    Script Date: 07/21/2009 17:25:38 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Search_PurchaseOrder]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Search_PurchaseOrder]
    @ApplicationId				uniqueidentifier,
	@SQLClause 					nvarchar(max),
	@MetaSQLClause 				nvarchar(max),
	@FTSPhrase 					nvarchar(max),
    @AdvancedFTSPhrase 			nvarchar(max),
    @OrderBy 					nvarchar(max),
	@Namespace					nvarchar(1024) = N'''',
	@Classes					nvarchar(max) = N'''',
    @StartingRec 				int,
	@NumRecords   				int,
	@RecordCount                int OUTPUT
AS
BEGIN
    declare @results udttOrderGroupId
    insert into @results (OrderGroupId)    
    exec dbo.ecf_OrderSearch
        @ApplicationId, 
        @SQLClause, 
        @MetaSQLClause, 
        @FTSPhrase, 
        @AdvancedFTSPhrase, 
        @OrderBy, 
        @namespace, 
        @Classes, 
        @StartingRec, 
        @NumRecords, 
        @RecordCount output
	
	exec [dbo].[ecf_Search_OrderGroup] @results

    -- Return Purchase Order Details
	DECLARE @search_condition nvarchar(max)
    select OrderGroupId into #OrderSearchResults from @results
	SET @search_condition = N''INNER JOIN OrderGroup OG ON OG.OrderGroupId = T.ObjectId WHERE [T].[ObjectId] IN (SELECT [OrderGroupId] FROM #OrderSearchResults)''
	exec mdpsp_avto_OrderGroup_PurchaseOrder_Search NULL, ''''''OrderGroup'''' TableName, [OG].*'', @search_condition
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_Search_PurchaseOrder_Customer]    Script Date: 07/21/2009 17:25:38 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Search_PurchaseOrder_Customer]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Search_PurchaseOrder_Customer]
	@ApplicationId uniqueidentifier,
    @CustomerId uniqueidentifier
AS
BEGIN
    declare @results udttOrderGroupId
    
    insert into @results (OrderGroupId)
	select [OrderGroupId]
	from [OrderGroup_PurchaseOrder] PO
	join OrderGroup OG on PO.ObjectId = OG.OrderGroupId
	where ([CustomerId] = @CustomerId) and ApplicationId = @ApplicationId
	
	exec dbo.ecf_Search_OrderGroup @results
	
	-- Return Purchase Order Details
	DECLARE @search_condition nvarchar(max)
    select OrderGroupId into #OrderSearchResults from @results
	SET @search_condition = N''INNER JOIN OrderGroup OG ON OG.OrderGroupId = T.ObjectId WHERE [T].[ObjectId] IN (SELECT [OrderGroupId] FROM #OrderSearchResults)''
	exec mdpsp_avto_OrderGroup_PurchaseOrder_Search NULL, ''''''OrderGroup'''' TableName, [OG].*'', @search_condition
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_Search_PurchaseOrder_CustomerAndName]    Script Date: 07/21/2009 17:25:39 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Search_PurchaseOrder_CustomerAndName]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Search_PurchaseOrder_CustomerAndName]
	@ApplicationId uniqueidentifier,
    @CustomerId uniqueidentifier,
	@Name nvarchar(64)
AS
BEGIN
    declare @results udttOrderGroupId
    
    insert into @results (OrderGroupId)
	select [OrderGroupId] 
	from [OrderGroup_PurchaseOrder] PO 
	join OrderGroup OG on PO.ObjectId = OG.OrderGroupId 
	where ([CustomerId] = @CustomerId) and [Name] = @Name and ApplicationId = @ApplicationId
	
	exec dbo.ecf_Search_OrderGroup @results
	
	-- Return Purchase Order Details
	DECLARE @search_condition nvarchar(max)
    select OrderGroupId into #OrderSearchResults from @results
	SET @search_condition = N''INNER JOIN OrderGroup OG ON OG.OrderGroupId = T.ObjectId WHERE [T].[ObjectId] IN (SELECT [OrderGroupId] FROM #OrderSearchResults)''
	exec mdpsp_avto_OrderGroup_PurchaseOrder_Search NULL, ''''''OrderGroup'''' TableName, [OG].*'', @search_condition	
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_Search_PurchaseOrder_CustomerAndOrderGroupId]    Script Date: 07/21/2009 17:25:39 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Search_PurchaseOrder_CustomerAndOrderGroupId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Search_PurchaseOrder_CustomerAndOrderGroupId]
	@ApplicationId uniqueidentifier,
    @CustomerId uniqueidentifier,
    @OrderGroupId int
AS
BEGIN
    declare @results udttOrderGroupId
    
    insert into @results (OrderGroupId)
	select [OrderGroupId]
	from [OrderGroup_PurchaseOrder] PO
	join OrderGroup OG on PO.ObjectId = OG.OrderGroupId 
	where (PO.ObjectId = @OrderGroupId) and CustomerId = @CustomerId and ApplicationId = @ApplicationId
	
	exec dbo.ecf_Search_OrderGroup @results
	
	-- Return Purchase Order Details
	DECLARE @search_condition nvarchar(max)
    select OrderGroupId into #OrderSearchResults from @results
	SET @search_condition = N''INNER JOIN OrderGroup OG ON OG.OrderGroupId = T.ObjectId WHERE [T].[ObjectId] IN (SELECT [OrderGroupId] FROM #OrderSearchResults)''
	exec mdpsp_avto_OrderGroup_PurchaseOrder_Search NULL, ''''''OrderGroup'''' TableName, [OG].*'', @search_condition
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_Search_ShoppingCart]    Script Date: 07/21/2009 17:25:39 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Search_ShoppingCart]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Search_ShoppingCart]
    @ApplicationId				uniqueidentifier,
	@SQLClause 					nvarchar(max),
	@MetaSQLClause 				nvarchar(max),
	@FTSPhrase 					nvarchar(max),
    @AdvancedFTSPhrase 			nvarchar(max),
    @OrderBy 					nvarchar(max),
	@Namespace					nvarchar(1024) = N'''',
	@Classes					nvarchar(max) = N'''',
    @StartingRec 				int,
	@NumRecords   				int,
	@RecordCount                int OUTPUT
AS
BEGIN
    declare @results udttOrderGroupId
    insert into @results (OrderGroupId)    
    exec dbo.ecf_OrderSearch
        @ApplicationId, 
        @SQLClause, 
        @MetaSQLClause, 
        @FTSPhrase, 
        @AdvancedFTSPhrase, 
        @OrderBy, 
        @namespace, 
        @Classes, 
        @StartingRec, 
        @NumRecords, 
        @RecordCount output
    
    exec dbo.ecf_Search_OrderGroup @results
    
	IF(EXISTS(SELECT OrderGroupId from OrderGroup where OrderGroupId IN (SELECT [OrderGroupId] FROM @results)))
	begin
	    -- Return Purchase Order Details
		DECLARE @search_condition nvarchar(max)
		select OrderGroupId into #OrderSearchResults from @results
		SET @search_condition = N''INNER JOIN OrderGroup OG ON OG.OrderGroupId = T.ObjectId WHERE [T].[ObjectId] IN (SELECT [OrderGroupId] FROM #OrderSearchResults)''
		exec mdpsp_avto_OrderGroup_ShoppingCart_Search NULL, ''''''OrderGroup'''' TableName, [OG].*'', @search_condition
	end
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_Search_ShoppingCart_Customer]    Script Date: 07/21/2009 17:25:39 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Search_ShoppingCart_Customer]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Search_ShoppingCart_Customer]
	@ApplicationId uniqueidentifier,
	@CustomerId uniqueidentifier
AS
BEGIN
    declare @results udttOrderGroupId
    
    insert into @results (OrderGroupId)
	select [OrderGroupId]
	from [OrderGroup_ShoppingCart] PO 
	join OrderGroup OG on PO.ObjectId = OG.OrderGroupId 
	where ([CustomerId] = @CustomerId) and ApplicationId = @ApplicationId
	
	exec dbo.ecf_Search_OrderGroup @results
	
	IF(EXISTS(SELECT OrderGroupId from OrderGroup where OrderGroupId IN (SELECT [OrderGroupId] FROM @results)))
	begin
	    -- Return Purchase Order Details
		DECLARE @search_condition nvarchar(max)
		select OrderGroupId into #OrderSearchResults from @results
		SET @search_condition = N''INNER JOIN OrderGroup OG ON OG.OrderGroupId = T.ObjectId WHERE [T].[ObjectId] IN (SELECT [OrderGroupId] FROM #OrderSearchResults)''
		exec mdpsp_avto_OrderGroup_ShoppingCart_Search NULL, ''''''OrderGroup'''' TableName, [OG].*'', @search_condition
	end
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_Search_ShoppingCart_CustomerAndName]    Script Date: 07/21/2009 17:25:40 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Search_ShoppingCart_CustomerAndName]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Search_ShoppingCart_CustomerAndName]
	@ApplicationId uniqueidentifier,
    @CustomerId uniqueidentifier,
	@Name nvarchar(64) = null
AS
BEGIN
    declare @results udttOrderGroupId
    
    insert into @results (OrderGroupId)
	select [OrderGroupId]
	from [OrderGroup_ShoppingCart] PO
	join OrderGroup OG on PO.ObjectId = OG.OrderGroupId
	where ([CustomerId] = @CustomerId) and [Name] = @Name and ApplicationId = @ApplicationId

    exec dbo.ecf_Search_OrderGroup @results

	IF(EXISTS(SELECT OrderGroupId from OrderGroup where OrderGroupId IN (SELECT [OrderGroupId] FROM @results)))
	begin
	    -- Return Purchase Order Details
		DECLARE @search_condition nvarchar(max)
		select OrderGroupId into #OrderSearchResults from @results
		SET @search_condition = N''INNER JOIN OrderGroup OG ON OG.OrderGroupId = T.ObjectId WHERE [T].[ObjectId] IN (SELECT [OrderGroupId] FROM #OrderSearchResults)''
		exec mdpsp_avto_OrderGroup_ShoppingCart_Search NULL, ''''''OrderGroup'''' TableName, [OG].*'', @search_condition
	end
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_Search_ShoppingCart_CustomerAndOrderGroupId]    Script Date: 07/21/2009 17:25:40 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Search_ShoppingCart_CustomerAndOrderGroupId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Search_ShoppingCart_CustomerAndOrderGroupId]
	@ApplicationId uniqueidentifier,
    @CustomerId uniqueidentifier,
    @OrderGroupId int
AS
BEGIN
	declare @results udttOrderGroupId
    
    insert into @results (OrderGroupId)
	select [OrderGroupId]
	from [OrderGroup_ShoppingCart] C
	join OrderGroup OG on C.ObjectId = OG.OrderGroupId
	where (C.ObjectId = @OrderGroupId) and CustomerId = @CustomerId and ApplicationId = @ApplicationId
	
	exec dbo.ecf_Search_OrderGroup @results
	
	IF(EXISTS(SELECT OrderGroupId from OrderGroup where OrderGroupId IN (SELECT [OrderGroupId] FROM @results)))
	begin
	    -- Return Purchase Order Details
		DECLARE @search_condition nvarchar(max)
		select OrderGroupId into #OrderSearchResults from @results
		SET @search_condition = N''INNER JOIN OrderGroup OG ON OG.OrderGroupId = T.ObjectId WHERE [T].[ObjectId] IN (SELECT [OrderGroupId] FROM #OrderSearchResults)''
		exec mdpsp_avto_OrderGroup_ShoppingCart_Search NULL, ''''''OrderGroup'''' TableName, [OG].*'', @search_condition
	end
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_Shipment_Delete]    Script Date: 07/21/2009 17:25:40 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Shipment_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Shipment_Delete]
(
	@ShipmentId int
)
AS
	SET NOCOUNT ON

	EXEC [dbo].[mdpsp_avto_ShipmentEx_Delete] @ShipmentId
	DELETE FROM [ShipmentDiscount] where ShipmentId = @ShipmentId
	DELETE FROM [Shipment] WHERE  [ShipmentId] = @ShipmentId	

	RETURN @@Error' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_Shipment_Insert]    Script Date: 07/21/2009 17:25:40 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Shipment_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[ecf_Shipment_Insert]
(
	@ShipmentId int = NULL OUTPUT,
	@OrderFormId int,
	@OrderGroupId int,
	@ShippingMethodId uniqueidentifier,
	@ShippingAddressId nvarchar(50) = NULL,
	@ShipmentTrackingNumber nvarchar(128) = NULL,
	@ShipmentTotal money,
	@ShippingDiscountAmount money,
	@ShippingMethodName nvarchar(128) = NULL,
	@Status nvarchar(64) = NULL,
	@LineItemIds nvarchar(max) = NULL,
	@WarehouseCode nvarchar(50) = NULL,
	@PickListId int = NULL,
	@SubTotal money
)
AS
	SET NOCOUNT ON

	INSERT INTO [Shipment]
	(
		[OrderFormId],
		[OrderGroupId],
		[ShippingMethodId],
		[ShippingAddressId],
		[ShipmentTrackingNumber],
		[ShipmentTotal],
		[ShippingDiscountAmount],
		[ShippingMethodName],
		[Status],
		[LineItemIds],
		[WarehouseCode],
		[PickListId],
		[SubTotal]
	)
	VALUES
	(
		@OrderFormId,
		@OrderGroupId,
		@ShippingMethodId,
		@ShippingAddressId,
		@ShipmentTrackingNumber,
		@ShipmentTotal,
		@ShippingDiscountAmount,
		@ShippingMethodName,
		@Status,
		@LineItemIds,
		@WarehouseCode,
		@PickListId,
		@SubTotal
	)

	SELECT @ShipmentId = SCOPE_IDENTITY()

	RETURN @@Error
'
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_Shipment_Update]    Script Date: 07/21/2009 17:25:41 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Shipment_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[ecf_Shipment_Update]
(
	@ShipmentId int,
	@OrderFormId int,
	@OrderGroupId int,
	@ShippingMethodId uniqueidentifier,
	@ShippingAddressId nvarchar(50) = NULL,
	@ShipmentTrackingNumber nvarchar(128) = NULL,
	@ShipmentTotal money,
	@ShippingDiscountAmount money,
	@ShippingMethodName nvarchar(128) = NULL,
	@Status nvarchar(64) = NULL,
	@LineItemIds nvarchar(max) = NULL,
	@WarehouseCode nvarchar(50) = NULL,
	@PickListId int = NULL,
	@SubTotal money
)
AS
	SET NOCOUNT ON
	
	UPDATE [Shipment]
	SET
		[OrderFormId] = @OrderFormId,
		[OrderGroupId] = @OrderGroupId,
		[ShippingMethodId] = @ShippingMethodId,
		[ShippingAddressId] = @ShippingAddressId,
		[ShipmentTrackingNumber] = @ShipmentTrackingNumber,
		[ShipmentTotal] = @ShipmentTotal,
		[ShippingDiscountAmount] = @ShippingDiscountAmount,
		[ShippingMethodName] = @ShippingMethodName,
		[Status] = @Status,
		[LineItemIds] = @LineItemIds,
		[WarehouseCode] = @WarehouseCode,
		[PickListId] = @PickListId,
		[SubTotal] = @SubTotal
	WHERE 
		[ShipmentId] = @ShipmentId

	RETURN @@Error
'
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_ShipmentDiscount_Delete]    Script Date: 07/21/2009 17:25:41 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_ShipmentDiscount_Delete]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_ShipmentDiscount_Delete]
(
	@ShipmentDiscountId int
)
AS
	SET NOCOUNT ON

	DELETE 
	FROM   [ShipmentDiscount]
	WHERE  
		[ShipmentDiscountId] = @ShipmentDiscountId

	RETURN @@Error' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_ShipmentDiscount_Insert]    Script Date: 07/21/2009 17:25:41 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_ShipmentDiscount_Insert]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_ShipmentDiscount_Insert]
(
	@ShipmentDiscountId int = NULL OUTPUT,
	@ShipmentId int,
	@DiscountId int,
	@OrderGroupId int,
	@DiscountAmount money,
	@DiscountCode nvarchar(50) = NULL,
	@DiscountName nvarchar(50) = NULL,
	@DisplayMessage nvarchar(100) = NULL,
	@DiscountValue money
)
AS
	SET NOCOUNT ON

	INSERT INTO [ShipmentDiscount]
	(
		[ShipmentId],
		[DiscountId],
		[OrderGroupId],
		[DiscountAmount],
		[DiscountCode],
		[DiscountName],
		[DisplayMessage],
		[DiscountValue]
	)
	VALUES
	(
		@ShipmentId,
		@DiscountId,
		@OrderGroupId,
		@DiscountAmount,
		@DiscountCode,
		@DiscountName,
		@DisplayMessage,
		@DiscountValue
	)

	SELECT @ShipmentDiscountId = SCOPE_IDENTITY()

	RETURN @@Error' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_ShipmentDiscount_Update]    Script Date: 07/21/2009 17:25:41 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_ShipmentDiscount_Update]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_ShipmentDiscount_Update]
(
	@ShipmentDiscountId int,
	@ShipmentId int,
	@DiscountId int,
	@OrderGroupId int,
	@DiscountAmount money,
	@DiscountCode nvarchar(50) = NULL,
	@DiscountName nvarchar(50) = NULL,
	@DisplayMessage nvarchar(100) = NULL,
	@DiscountValue money
)
AS
	SET NOCOUNT ON
	
	UPDATE [ShipmentDiscount]
	SET
		[ShipmentId] = @ShipmentId,
		[DiscountId] = @DiscountId,
		[OrderGroupId] = @OrderGroupId,
		[DiscountAmount] = @DiscountAmount,
		[DiscountCode] = @DiscountCode,
		[DiscountName] = @DiscountName,
		[DisplayMessage] = @DisplayMessage,
		[DiscountValue] = @DiscountValue
	WHERE 
		[ShipmentDiscountId] = @ShipmentDiscountId

	RETURN @@Error' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_ShippingMethod_Language]    Script Date: 07/21/2009 17:25:42 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_ShippingMethod_Language]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_ShippingMethod_Language]
	@ApplicationId uniqueidentifier,
	@LanguageId nvarchar(10) = null,
	@ReturnInactive bit = 0
AS
BEGIN
	select * from [ShippingOption] where [ApplicationId] = @ApplicationId
	select SOP.* from [ShippingOptionParameter] SOP 
	inner join [ShippingOption] SO on SOP.[ShippingOptionId]=SO.[ShippingOptionId]
		where SO.[ApplicationId] = @ApplicationId
	select distinct SM.* from [ShippingMethod] SM 
	inner join [Warehouse] W on SM.ApplicationId = W.ApplicationId
		where COALESCE(@LanguageId, LanguageId) = LanguageId and ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.ApplicationId = @ApplicationId
			and (SM.Name <> ''In Store Pickup'' or W.IsPickupLocation = 1)
	select * from [ShippingMethodParameter] where ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId)
	select * from [ShippingMethodCase] where ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId)
	select * from [ShippingCountry] where ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId)
	select * from [ShippingRegion] where ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId)
	select * from [ShippingPaymentRestriction] 
		where 
			(ShippingMethodId in (select ShippingMethodId from ShippingMethod where COALESCE(@LanguageId, LanguageId) = LanguageId and (([IsActive] = 1) or @ReturnInactive = 1) and ApplicationId = @ApplicationId) )
				and
			[RestrictShippingMethods] = 0
	select * from [Package] where [ApplicationId] = @ApplicationId
	select SP.* from [ShippingPackage] SP 
	inner join [Package] P on SP.[PackageId]=P.[PackageId]
		where P.[ApplicationId] = @ApplicationId
END' 
END
GO


/****** Object:  StoredProcedure [dbo].[ecf_ShippingMethod_Market]    Script Date: 07/21/2009 17:25:42 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_ShippingMethod_Market]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_ShippingMethod_Market]
    @ApplicationId uniqueidentifier,
    @MarketId nvarchar(10) = null,
    @ReturnInactive bit = 0
AS
BEGIN
    declare @_shippingMethodIds as table (ShippingMethodId uniqueidentifier)
    insert into @_shippingMethodIds
    select SM.ShippingMethodId
        from [ShippingMethod] SM
        inner join [MarketLanguages] ML
          on SM.LanguageId = ML.LanguageCode
		inner join [Market] M
          on ML.MarketId = M.MarketId
        inner join [Warehouse] W
          on W.ApplicationId = SM.ApplicationId
        where COALESCE(@MarketId, M.MarketId) = M.MarketId
          and ((SM.[IsActive] = 1) or (@ReturnInactive = 1))
          and SM.ApplicationId = @ApplicationId
          and (SM.Name <> ''In Store Pickup'' or W.IsPickupLocation = 1)

    select * from [ShippingOption] where [ApplicationId] = @ApplicationId
    
    select SOP.* from [ShippingOptionParameter] SOP 
    inner join [ShippingOption] SO on SOP.[ShippingOptionId]=SO.[ShippingOptionId]
        where SO.[ApplicationId] = @ApplicationId
        
    select distinct SM.* from [ShippingMethod] SM where ShippingMethodId in (select ShippingMethodId from @_shippingMethodIds)
    select * from [ShippingMethodParameter] where ShippingMethodId in (select ShippingMethodId from @_shippingMethodIds)
    select * from [ShippingMethodCase] where ShippingMethodId in (select ShippingMethodId from @_shippingMethodIds)
    select * from [ShippingCountry] where ShippingMethodId in (select ShippingMethodId from @_shippingMethodIds)
    select * from [ShippingRegion] where ShippingMethodId in (select ShippingMethodId from @_shippingMethodIds)
    
    select * from [ShippingPaymentRestriction]
        where 
            ShippingMethodId in (select ShippingMethodId from @_shippingMethodIds)
            and
            [RestrictShippingMethods] = 0
    select * from [Package] where [ApplicationId] = @ApplicationId

    select SP.* from [ShippingPackage] SP 
    inner join [Package] P on SP.[PackageId]=P.[PackageId]
        where P.[ApplicationId] = @ApplicationId
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_ShippingMethod_ShippingMethodId]    Script Date: 07/21/2009 17:25:42 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_ShippingMethod_ShippingMethodId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_ShippingMethod_ShippingMethodId]
	@ApplicationId uniqueidentifier,
	@ShippingMethodId uniqueidentifier,
	@ReturnInactive bit = 0
AS
BEGIN
	select SO.* from [ShippingOption] SO
		inner join [ShippingMethod] SM on SO.[ShippingOptionId]=SM.[ShippingOptionId]
	where SM.[ShippingMethodId] = @ShippingMethodId and SM.[ApplicationId] = @ApplicationId

	select SOP.* from [ShippingOptionParameter] SOP 
		inner join [ShippingMethod] SM on SOP.[ShippingOptionId]=SM.[ShippingOptionId]
	where SM.[ShippingMethodId] = @ShippingMethodId and SM.[ApplicationId] = @ApplicationId

	select SM.* from [ShippingMethod] SM
		where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId

	select SMP.* from [ShippingMethodParameter] SMP
		inner join [ShippingMethod] SM on SMP.[ShippingMethodId]=SM.[ShippingMethodId]
			where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId

	select SMC.* from [ShippingMethodCase] SMC
		inner join [ShippingMethod] SM on SMC.[ShippingMethodId]=SM.[ShippingMethodId]
			where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId

	select SC.* from [ShippingCountry] SC
		inner join [ShippingMethod] SM on SC.[ShippingMethodId]=SM.[ShippingMethodId]
			where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId

	select SR.* from [ShippingRegion] SR
		inner join [ShippingMethod] SM on SR.[ShippingMethodId]=SM.[ShippingMethodId]
			where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId

	select SPR.* from [ShippingPaymentRestriction] SPR
		inner join [ShippingMethod] SM on SPR.[ShippingMethodId]=SM.[ShippingMethodId]
			where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId and SPR.[RestrictShippingMethods] = 0

	select P.* from [Package] P
		inner join [ShippingPackage] SP on SP.[PackageId]=P.[PackageId]
		inner join [ShippingMethod] SM on SP.[ShippingOptionId]=SM.[ShippingOptionId]
			where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId

	select SP.* from [ShippingPackage] SP
		inner join [ShippingMethod] SM on SP.[ShippingOptionId]=SM.[ShippingOptionId]
			where ((SM.[IsActive] = 1) or @ReturnInactive = 1) and SM.[ApplicationId] = @ApplicationId and SM.[ShippingMethodId] = @ShippingMethodId
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_ShippingOption_ShippingOptionId]    Script Date: 07/21/2009 17:25:42 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_ShippingOption_ShippingOptionId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_ShippingOption_ShippingOptionId]
	@ApplicationId uniqueidentifier,
	@ShippingOptionId uniqueidentifier,
	@ReturnInactive bit = 0
AS
BEGIN
	select * from [ShippingOption] 
		where [ShippingOptionId] = @ShippingOptionId and [ApplicationId]=@ApplicationId
	select SOP.* from [ShippingOptionParameter] SOP 
	inner join [ShippingOption] SO on SO.[ShippingOptionId]=SOP.[ShippingOptionId]
		where SO.[ShippingOptionId] = @ShippingOptionId and SO.[ApplicationId]=@ApplicationId
	select * from [Package] P
		inner join [ShippingPackage] SP on P.[PackageId]=SP.[PackageId]
			where SP.[ShippingOptionId] = @ShippingOptionId and P.[ApplicationId]=@ApplicationId
	select * from [ShippingPackage] where [ShippingOptionId] = @ShippingOptionId
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_ShippingPackage]    Script Date: 07/21/2009 17:25:42 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_ShippingPackage]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_ShippingPackage]
	@ApplicationId uniqueidentifier
AS
	select * from [Package] P where P.[ApplicationId] = @ApplicationId' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_ShippingPackage_Name]    Script Date: 07/21/2009 17:25:43 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_ShippingPackage_Name]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_ShippingPackage_Name]
	@ApplicationId uniqueidentifier,
	@Name nvarchar(100)
AS
	select * from [Package] P 
		where P.[ApplicationId] = @ApplicationId and P.[Name] = @Name' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_ShippingPackage_PackageId]    Script Date: 07/21/2009 17:25:43 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_ShippingPackage_PackageId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_ShippingPackage_PackageId]
	@ApplicationId uniqueidentifier,
	@PackageId int
AS
	select * from [Package] P 
		where P.[ApplicationId] = @ApplicationId and P.[PackageId] = @PackageId' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_Tax]    Script Date: 07/21/2009 17:25:43 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Tax]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Tax]
	@ApplicationId uniqueidentifier,
	@TaxType int = null
AS
BEGIN
	select T.* from [Tax] T 
		where T.[ApplicationId] = @ApplicationId and
			 (COALESCE(@TaxType, T.[TaxType]) = T.[TaxType] OR T.[TaxType] is null)

	select TL.* from [TaxLanguage] TL
		inner join [Tax] T on TL.[TaxId]=T.[TaxId]
		where T.[ApplicationId] = @ApplicationId and 
			(COALESCE(@TaxType, T.[TaxType]) = T.[TaxType] OR T.[TaxType] is null)

	select TV.* from [TaxValue] TV
		inner join [Tax] T on TV.[TaxId]=T.[TaxId]
		where T.[ApplicationId] = @ApplicationId and 
			(COALESCE(@TaxType, T.[TaxType]) = T.[TaxType] OR T.[TaxType] is null)
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_Tax_TaxId]    Script Date: 07/21/2009 17:25:44 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Tax_TaxId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Tax_TaxId]
	@ApplicationId uniqueidentifier,
	@TaxId int	
AS
BEGIN
	select T.* from [Tax] T 
		where T.[TaxId] = @TaxId and T.[ApplicationId] = @ApplicationId

	select TL.* from [TaxLanguage] TL
		inner join [Tax] T on T.[TaxId] = TL.[TaxId]
			where TL.[TaxId] = @TaxId and T.[ApplicationId] = @ApplicationId

	select TV.* from [TaxValue] TV
		inner join [Tax] T on T.[TaxId] = TV.[TaxId]
			where TV.[TaxId] = @TaxId and T.[ApplicationId] = @ApplicationId
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_Tax_TaxName]    Script Date: 07/21/2009 17:25:44 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Tax_TaxName]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Tax_TaxName]
	@ApplicationId uniqueidentifier,
	@Name nvarchar(50)
AS
BEGIN
	select T.* from [Tax] T 
		where T.[Name] = @Name and T.[ApplicationId] = @ApplicationId

	select TL.* from [TaxLanguage] TL
		inner join [Tax] T on T.[TaxId] = TL.[TaxId]
			where T.[Name] = @Name and T.[ApplicationId] = @ApplicationId

	select TV.* from [TaxValue] TV
		inner join [Tax] T on T.[TaxId] = TV.[TaxId]
			where T.[Name] = @Name and T.[ApplicationId] = @ApplicationId
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_GetTaxes]    Script Date: 07/21/2009 17:25:44 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_GetTaxes]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE ecf_GetTaxes
	@ApplicationId uniqueidentifier,
	@SiteId uniqueidentifier,
	@TaxCategory nvarchar(50),
	@LanguageCode nvarchar(50),
	@CountryCode nvarchar(50),
	@StateProvinceCode nvarchar(50) = null,
	@ZipPostalCode nvarchar(50) = null,
	@District nvarchar(50) = null,
	@County nvarchar(50) = null,
	@City nvarchar(50) = null
AS
	SELECT V.Percentage, T.TaxType, T.Name, (select L.DisplayName from TaxLanguage L where L.TaxId = V.TaxId and LanguageCode = @LanguageCode) DisplayName from TaxValue V 
		inner join Tax T ON T.TaxId = V.TaxId
		inner join JurisdictionGroup JG ON JG.JurisdictionGroupId = V.JurisdictionGroupId
		inner join JurisdictionRelation JR ON JG.JurisdictionGroupId = JR.JurisdictionGroupId
		inner join Jurisdiction J ON JR.JurisdictionId = J.JurisdictionId
	WHERE 
		V.AffectiveDate < getutcdate() AND 
		V.TaxCategory = @TaxCategory AND
		(COALESCE(V.SiteId, @SiteId) = @SiteId or SiteId is null) AND
		T.ApplicationId = @ApplicationId AND
		JG.ApplicationId = @ApplicationId AND
		J.CountryCode = @CountryCode AND 
		JG.JurisdictionType = 1 /*tax*/ AND
		(COALESCE(@StateProvinceCode, J.StateProvinceCode) = J.StateProvinceCode OR J.StateProvinceCode is null) AND
		((@ZipPostalCode between J.ZipPostalCodeStart and J.ZipPostalCodeEnd or @ZipPostalCode is null) OR J.ZipPostalCodeStart is null) AND
		(COALESCE(@District, J.District) = J.District OR J.District is null) AND
		(COALESCE(@County, J.County) = J.County OR J.County is null) AND
		(COALESCE(@City, J.City) = J.City OR J.City is null)

' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_ShippingMethod_GetCases]    Script Date: 07/21/2009 17:25:44 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_ShippingMethod_GetCases]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_ShippingMethod_GetCases]
	@ShippingMethodId uniqueidentifier,
	@CountryCode nvarchar(50) = null,
	@Total money = null,
	@StateProvinceCode nvarchar(50) = null,
	@ZipPostalCode nvarchar(50) = null,
	@District nvarchar(50) = null,
	@County nvarchar(50) = null,
	@City nvarchar(50) = null
AS
BEGIN
/* First set all empty string variables except ShippingMethodId to NULL */
IF (LTRIM(RTRIM(@CountryCode)) = '''')
  SET @CountryCode = NULL

IF (LTRIM(RTRIM(@StateProvinceCode)) = '''')
  SET @StateProvinceCode = NULL

IF (LTRIM(RTRIM(@ZipPostalCode)) = '''')
  SET @ZipPostalCode = NULL

IF (LTRIM(RTRIM(@District)) = '''')
  SET @District = NULL

IF (LTRIM(RTRIM(@County)) = '''')
  SET @County = NULL

IF (LTRIM(RTRIM(@City )) = '''')
  SET @City = NULL

/* If Jurisdiction values in database are null or an empty string, they will return the same results */
	SELECT C.Charge, C.Total, C.StartDate, C.EndDate, C.JurisdictionGroupId from ShippingMethodCase C 
		inner join JurisdictionGroup JG ON JG.JurisdictionGroupId = C.JurisdictionGroupId
		inner join JurisdictionRelation JR ON JG.JurisdictionGroupId = JR.JurisdictionGroupId
		inner join Jurisdiction J ON JR.JurisdictionId = J.JurisdictionId
	WHERE 
		(C.StartDate < getutcdate() OR C.StartDate is null) AND 
		(C.EndDate > getutcdate() OR C.EndDate is null) AND 
		C.ShippingMethodId = @ShippingMethodId AND
		(@Total >= C.Total OR @Total is null) AND
		(J.CountryCode = @CountryCode OR (@CountryCode is null and J.CountryCode = ''WORLD'')) AND 
		JG.JurisdictionType = 2 /*shipping*/ AND
		(COALESCE(@StateProvinceCode, J.StateProvinceCode) = J.StateProvinceCode OR J.StateProvinceCode is null OR RTRIM(LTRIM(J.StateProvinceCode)) = '''') AND
		((@ZipPostalCode between J.ZipPostalCodeStart and J.ZipPostalCodeEnd or @ZipPostalCode is null) OR J.ZipPostalCodeStart is null OR RTRIM(LTRIM(J.ZipPostalCodeStart)) = '''') AND
		(COALESCE(@District, J.District) = J.District OR J.District is null OR RTRIM(LTRIM(J.District)) = '''') AND
		(COALESCE(@County, J.County) = J.County OR J.County is null OR RTRIM(LTRIM(J.County)) = '''') AND
		(COALESCE(@City, J.City) = J.City OR J.City is null OR RTRIM(LTRIM(J.City)) = '''')
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_Jurisdiction]    Script Date: 07/21/2009 17:25:45 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Jurisdiction]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Jurisdiction]
	@ApplicationId uniqueidentifier,
	@JurisdictionType int = null
AS
BEGIN
	select * from [Jurisdiction] 
		where [ApplicationId] = @ApplicationId and 
			(COALESCE(@JurisdictionType, [JurisdictionType]) = [JurisdictionType] OR [JurisdictionType] is null)

	select * from [JurisdictionGroup] 
		where [ApplicationId] = @ApplicationId and 
		(COALESCE(@JurisdictionType, [JurisdictionType]) = [JurisdictionType] OR [JurisdictionType] is null)

	select JR.* from [JurisdictionRelation] JR
		inner join [Jurisdiction] J on JR.[JurisdictionId]=J.[JurisdictionId]
		inner join [JurisdictionGroup] JG on JR.[JurisdictionGroupId]=JG.[JurisdictionGroupId]
		where J.[ApplicationId] = @ApplicationId and JG.[ApplicationId] = @ApplicationId and
			(COALESCE(@JurisdictionType, J.[JurisdictionType]) = J.[JurisdictionType] OR J.[JurisdictionType] is null) and
			(COALESCE(@JurisdictionType, JG.[JurisdictionType]) = JG.[JurisdictionType] OR JG.[JurisdictionType] is null)
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_Jurisdiction_JurisdictionCode]    Script Date: 07/21/2009 17:25:45 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Jurisdiction_JurisdictionCode]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Jurisdiction_JurisdictionCode]
	@ApplicationId uniqueidentifier,
	@JurisdictionCode nvarchar(50),
	@ReturnAllGroups bit = 0
AS
BEGIN
	select * from [Jurisdiction] 
		where [ApplicationId] = @ApplicationId and [Code] = @JurisdictionCode

	IF @ReturnAllGroups=1 BEGIN -- return all jurisdiction groups of the found jurisdiction type
		select * from [JurisdictionGroup] 
			where [JurisdictionType] IN (select [JurisdictionType] from [Jurisdiction] 
											where [ApplicationId] = @ApplicationId and [Code] = @JurisdictionCode)
	END ELSE BEGIN
		select JG.* from [JurisdictionGroup] JG
			inner join [JurisdictionRelation] JR on JR.[JurisdictionGroupId] = JG.[JurisdictionGroupId]
			inner join [Jurisdiction] J on JR.[JurisdictionId] = J.[JurisdictionId]
			where JG.[ApplicationId] = @ApplicationId and J.[Code] = @JurisdictionCode
	END

	select JR.* from [JurisdictionRelation] JR
		inner join [Jurisdiction] J on JR.[JurisdictionId]=J.[JurisdictionId]
		where J.[ApplicationId] = @ApplicationId and J.[Code] = @JurisdictionCode
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_Jurisdiction_JurisdictionGroupCode]    Script Date: 07/21/2009 17:25:45 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Jurisdiction_JurisdictionGroupCode]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Jurisdiction_JurisdictionGroupCode]
	@ApplicationId uniqueidentifier,
	@JurisdictionGroupCode nvarchar(50)
AS
BEGIN
	select * from [JurisdictionGroup] 
		where [ApplicationId] = @ApplicationId and [Code] = @JurisdictionGroupCode

	select JR.* from [JurisdictionRelation] JR
		inner join [JurisdictionGroup] J on JR.[JurisdictionGroupId]=J.[JurisdictionGroupId]
		where J.[ApplicationId] = @ApplicationId and J.[Code] = @JurisdictionGroupCode
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_Jurisdiction_JurisdictionGroups]    Script Date: 07/21/2009 17:25:45 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Jurisdiction_JurisdictionGroups]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Jurisdiction_JurisdictionGroups]
	@ApplicationId uniqueidentifier,
	@JurisdictionType int = null
AS
BEGIN
	select * from [JurisdictionGroup] JG
		where [ApplicationId] = @ApplicationId and 
			(COALESCE(@JurisdictionType, JG.[JurisdictionType]) = JG.[JurisdictionType] OR JG.[JurisdictionType] is null)
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_Jurisdiction_JurisdictionGroupId]    Script Date: 07/21/2009 17:25:46 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Jurisdiction_JurisdictionGroupId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Jurisdiction_JurisdictionGroupId]
	@ApplicationId uniqueidentifier,
	@JurisdictionGroupId int
AS
BEGIN
	select * from [JurisdictionGroup] 
		where [ApplicationId] = @ApplicationId and [JurisdictionGroupId] = @JurisdictionGroupId

	select JR.* from [JurisdictionRelation] JR
		inner join [JurisdictionGroup] J on JR.[JurisdictionGroupId]=J.[JurisdictionGroupId]
		where J.[ApplicationId] = @ApplicationId and JR.[JurisdictionGroupId] = @JurisdictionGroupId
END' 
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_Jurisdiction_JurisdictionId]    Script Date: 07/21/2009 17:25:46 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Jurisdiction_JurisdictionId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ecf_Jurisdiction_JurisdictionId]
	@ApplicationId uniqueidentifier,
	@JurisdictionId int,
	@ReturnAllGroups bit = 0
AS
BEGIN
	select * from [Jurisdiction] 
		where [ApplicationId] = @ApplicationId and [JurisdictionId] = @JurisdictionId

	IF @ReturnAllGroups=1 BEGIN -- return all jurisdiction groups of the found jurisdiction type
		select * from [JurisdictionGroup] 
			where [JurisdictionType] IN (select [JurisdictionType] from [Jurisdiction] 
											where [ApplicationId] = @ApplicationId and [JurisdictionId] = @JurisdictionId)
	END ELSE BEGIN
		select JG.* from [JurisdictionGroup] JG
			inner join [JurisdictionRelation] JR on JR.[JurisdictionGroupId] = JG.[JurisdictionGroupId]
			where JG.[ApplicationId] = @ApplicationId and JR.[JurisdictionId] = @JurisdictionId
	END

	select JR.* from [JurisdictionRelation] JR
		inner join [Jurisdiction] J on JR.[JurisdictionId]=J.[JurisdictionId]
		where J.[ApplicationId] = @ApplicationId and JR.[JurisdictionId] = @JurisdictionId
END' 
END
GO

/****** Object:  UserDefinedFunction [dbo].[ecf_splitlist]    Script Date: 07/21/2009 17:25:46 ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_splitlist]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[ecf_splitlist]
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

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_PickList]') AND type in (N'P', N'PC'))
BEGIN
EXEC sp_ExecuteSQL N'
CREATE PROCEDURE [dbo].[ecf_PickList]
	@ShipmentPackingStatus AS NVARCHAR(64)
AS
BEGIN
	SELECT PL.*, CAST((SELECT COUNT(*) FROM [Shipment] S WHERE S.[PickListId] = PL.[PickListId] AND S.[Status] = @ShipmentPackingStatus) AS INT) AS [PackingShipments]
	FROM [PickList] PL
	ORDER BY PL.[Name]
END
'
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_Order_ReturnReasonsDictionairy]    Script Date: 05/13/2011 23:37:38 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Order_ReturnReasonsDictionairy]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[ecf_Order_ReturnReasonsDictionairy]
	@ApplicationId uniqueidentifier,
	@ReturnInactive bit = 0
 AS
 BEGIN
	SELECT * FROM dbo.ReturnReasonDictionary RRD
	where ApplicationId = @ApplicationId and
	(([Visible] = 1) or @ReturnInactive = 1)
	order by RRD.[Ordering], RRD.[ReturnReasonText]
END
'
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_Order_ReturnReasonsDictionairyId]    Script Date: 05/13/2011 23:37:44 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Order_ReturnReasonsDictionairyId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[ecf_Order_ReturnReasonsDictionairyId]
	@ApplicationId uniqueidentifier,
	@ReturnReasonId int
 AS
 BEGIN
	SELECT [ReturnReasonId]
		  ,[ReturnReasonText]
		  ,[ApplicationId]
		  ,[Ordering]
		  ,[Visible]
		FROM dbo.ReturnReasonDictionary
		where ApplicationId = @ApplicationId and ReturnReasonId = @ReturnReasonId
END
'
END
GO

/****** Object:  StoredProcedure [dbo].[ecf_Order_ReturnReasonsDictionairyName]    Script Date: 06/02/2011 23:37:50 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ecf_Order_ReturnReasonsDictionairyName]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[ecf_Order_ReturnReasonsDictionairyName]
	@ApplicationId uniqueidentifier,
	@ReturnReasonName nvarchar(50)
 AS
 BEGIN
	SELECT [ReturnReasonId]
		  ,[ReturnReasonText]
		  ,[ApplicationId]
		FROM dbo.ReturnReasonDictionary
		where ApplicationId = @ApplicationId and ReturnReasonText = @ReturnReasonName
END
'
END
GO