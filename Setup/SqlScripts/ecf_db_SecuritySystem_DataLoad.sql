declare @ApplicationId uniqueidentifier
select @ApplicationId = ApplicationId from [Application] where [Name] = N'$(EcfApplicationName)'

--|--------------------------------------------------------------------------------
--| [RolePermission] - Backs up all the data from a table into a SQL script.
--|--------------------------------------------------------------------------------

INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'core:mng:login');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'businessfoundation:tabviewpermission');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'businessfoundation:organization:view:permission');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'businessfoundation:contact:create:permission');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'businessfoundation:contact:view:permission');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'businessfoundation:contact:delete:permission');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'businessfoundation:organization:view:permission');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'businessfoundation:organization:create:permission');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'businessfoundation:organization:edit:permission');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'businessfoundation:organization:delete:permission');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'customer:tabviewpermission');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'customer:roles:mng:view');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'customer:roles:mng:create');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'customer:roles:mng:edit');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'customer:roles:mng:delete');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'asset:tabviewpermission');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'asset:mng:view');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'asset:mng:create');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'asset:mng:edit');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'asset:mng:delete');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'asset:admin:view');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'catalog:tabviewpermission');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'catalog:ctlg:mng:view');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'catalog:ctlg:mng:create');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'catalog:ctlg:mng:edit');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'catalog:ctlg:mng:delete');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'catalog:ctlg:mng:import');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'catalog:ctlg:mng:export');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'catalog:ctlg:nodes:mng:view');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'catalog:ctlg:nodes:mng:create');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'catalog:ctlg:nodes:mng:edit');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'catalog:ctlg:nodes:mng:delete');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'catalog:ctlg:entries:mng:view');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'catalog:ctlg:entries:mng:create');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'catalog:ctlg:entries:mng:edit');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'catalog:ctlg:entries:mng:delete');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'catalog:admin:warehouses:mng:view');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'catalog:admin:warehouses:mng:create');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'catalog:admin:warehouses:mng:edit');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'catalog:admin:warehouses:mng:delete');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'catalog:admin:meta:cls:mng:view');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'catalog:admin:meta:cls:mng:create');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'catalog:admin:meta:cls:mng:edit');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'catalog:admin:meta:cls:mng:delete');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'catalog:admin:meta:fld:mng:view');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'catalog:admin:meta:fld:mng:create');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'catalog:admin:meta:fld:mng:edit');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'catalog:admin:meta:fld:mng:delete');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'content:tabviewpermission');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'content:site:mng:view');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'content:site:mng:create');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'content:site:mng:edit');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'content:site:mng:delete');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'content:site:mng:import');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'content:site:mng:export');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'content:site:nav:mng:view');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'content:site:nav:mng:create');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'content:site:nav:mng:edit');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'content:site:nav:mng:design');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'content:site:nav:mng:delete');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'content:site:menu:mng:view');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'content:site:menu:mng:create');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'content:site:menu:mng:edit');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'content:site:menu:mng:delete');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'content:admin:workflow:mng:view');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'content:admin:workflow:mng:create');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'content:admin:workflow:mng:edit');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'content:admin:workflow:mng:delete');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'content:admin:templates:mng:view');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'content:admin:templates:mng:create');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'content:admin:templates:mng:edit');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'content:admin:templates:mng:delete');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'marketing:tabviewpermission');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'marketing:campaigns:mng:view');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'marketing:campaigns:mng:create');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'marketing:campaigns:mng:edit');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'marketing:campaigns:mng:delete');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'marketing:promotions:mng:view');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'marketing:promotions:mng:create');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'marketing:promotions:mng:edit');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'marketing:promotions:mng:delete');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'marketing:segments:mng:view');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'marketing:segments:mng:create');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'marketing:segments:mng:edit');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'marketing:segments:mng:delete');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'marketing:policies:mng:view');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'marketing:policies:mng:create');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'marketing:policies:mng:edit');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'marketing:policies:mng:delete');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'marketing:expr:mng:view');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'marketing:expr:mng:create');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'marketing:expr:mng:edit');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'marketing:expr:mng:delete');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:tabviewpermission');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:mng:view');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:mng:create');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:mng:edit');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:mng:delete');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:mng:notify');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:mng:payments');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:admin:payments:mng:view');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:admin:payments:mng:create');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:admin:payments:mng:edit');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:admin:payments:mng:delete');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:admin:shipping:jur:mng:view');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:admin:shipping:jur:mng:create');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:admin:shipping:jur:mng:edit');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:admin:shipping:jur:mng:delete');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:admin:shipping:providers:mng:view');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:admin:shipping:providers:mng:create');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:admin:shipping:providers:mng:edit');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:admin:shipping:providers:mng:delete');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:admin:shipping:packages:mng:view');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:admin:shipping:packages:mng:create');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:admin:shipping:packages:mng:edit');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:admin:shipping:packages:mng:delete');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:admin:shipping:methods:mng:view');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:admin:shipping:methods:mng:create');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:admin:shipping:methods:mng:edit');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:admin:shipping:methods:mng:delete');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:admin:taxes:mng:view');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:admin:taxes:mng:create');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:admin:taxes:mng:edit');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:admin:taxes:mng:delete');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:admin:taxes:mng:import');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:admin:meta:cls:mng:view');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:admin:meta:cls:mng:create');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:admin:meta:cls:mng:edit');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:admin:meta:cls:mng:delete');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:admin:meta:fld:mng:view');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:admin:meta:fld:mng:create');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:admin:meta:fld:mng:edit');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:admin:meta:fld:mng:delete');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:mng:return:create');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:mng:return:create_exchange');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:mng:split_shipments');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:mng:return:receiving');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:mng:shipment:packing');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:mng:shipment:complete');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:mng:discretionary_credit_payment');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Admins', 'order:mng:discount');

INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Order Managers', 'core:mng:login');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Order Managers', 'order:tabviewpermission');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Order Managers', 'order:mng:view');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Order Managers', 'order:mng:edit');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Order Managers', 'order:mng:notify');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Order Managers', 'order:mng:payments');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Order Managers', 'order:mng:return:create');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Order Managers', 'order:mng:return:create_exchange');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Order Managers', 'order:mng:split_shipments');

INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Order Supervisor', 'core:mng:login');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Order Supervisor', 'order:tabviewpermission');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Order Supervisor', 'order:mng:return:create');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Order Supervisor', 'order:mng:return:create_exchange');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Order Supervisor', 'order:mng:return:receiving');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Order Supervisor', 'order:mng:shipment:packing');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Order Supervisor', 'order:mng:shipment:complete');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Order Supervisor', 'order:mng:view');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Order Supervisor', 'order:mng:create');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Order Supervisor', 'order:mng:edit');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Order Supervisor', 'order:mng:delete');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Order Supervisor', 'order:mng:notify');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Order Supervisor', 'order:mng:payments');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Order Supervisor', 'order:mng:split_shipments');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Order Supervisor', 'order:mng:discretionary_credit_payment');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Order Supervisor', 'order:mng:discount');	
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])	 VALUES (@ApplicationId, 'Order Supervisor', 'order:mng:change_price');

INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Shipping Manager', 'core:mng:login');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Shipping Manager', 'order:tabviewpermission');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Shipping Manager', 'order:mng:shipment:packing');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Shipping Manager', 'order:mng:shipment:complete');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Shipping Manager', 'order:mng:view');

INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Receiving Manager', 'core:mng:login');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Receiving Manager', 'order:tabviewpermission');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Receiving Manager', 'order:mng:return:receiving');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Receiving Manager', 'order:mng:view');

INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Everyone', 'empty');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES (@ApplicationId, 'Registered', 'empty');
INSERT INTO [RolePermission]   ([ApplicationId], [RoleName], [Permission])   VALUES	(@ApplicationId, 'Management Users', 'core:mng:login');



GO
--|--------------------------------------------------------------------------------

--Bring the SchemaVersion up to the current level
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 1;
Set @Patch = 0;

WHILE( @Patch <= 5) --## Don't forget to update the patch counter here and also in ECF_DB_SCHEMAVERSIONCHECK.SQL ;) ##
BEGIN
	IF NOT EXISTS (Select * from SchemaVersion_SecuritySystem where Major=@Major and Minor=@Minor and Patch=@Patch)
		Insert into SchemaVersion_SecuritySystem(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())
	Set @Patch = @Patch + 1
END
Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '
GO
