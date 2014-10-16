--|--------------------------------------------------------------------------------
--| [dps_NodeType] - Backs up all the data from a table into a SQL script.
--|--------------------------------------------------------------------------------
if (select count([NodeTypeId]) from [dps_NodeType]) = 0
begin
	SET IDENTITY_INSERT [dps_NodeType] ON

	INSERT INTO [dps_NodeType]
	([NodeTypeId], [TypeName])
	VALUES
	(1, 'Static');

	INSERT INTO [dps_NodeType]
	([NodeTypeId], [TypeName])
	VALUES
	(2, 'Dynamic');
	SET IDENTITY_INSERT [dps_NodeType] OFF
end
GO
--|--------------------------------------------------------------------------------

declare @ApplicationId uniqueidentifier
select @ApplicationId = ApplicationId from [Application] where [Name] = N'$(EcfApplicationName)'

--|--------------------------------------------------------------------------------
--| [main_PageState] - Backs up all the data from a table into a SQL script.
--|--------------------------------------------------------------------------------
INSERT INTO [main_PageState]
([FriendlyName], [ApplicationId])
VALUES
('Page is under review', @ApplicationId);

INSERT INTO [main_PageState]
([FriendlyName], [ApplicationId])
VALUES
('Denied', @ApplicationId);
--|--------------------------------------------------------------------------------

--|--------------------------------------------------------------------------------
--| [Workflow] - Backs up all the data from a table into a SQL script.
--|--------------------------------------------------------------------------------
INSERT INTO [Workflow]
([FriendlyName], [IsDefault], [ApplicationId])
VALUES
('Page Workflow', 1, @ApplicationId);
--|--------------------------------------------------------------------------------

declare @WorkflowId int
set @WorkflowId = SCOPE_IDENTITY() -- select workflowId that has just been inserted
--|--------------------------------------------------------------------------------
--| [WorkflowStatus] - Backs up all the data from a table into a SQL script.
--|--------------------------------------------------------------------------------
declare @DraftWorkflowStatusId int, @PublishedWorkflowStatusId int, @ReadyWorkflowStatusId int

INSERT INTO [WorkflowStatus]
([WorkflowId], [Weight], [FriendlyName])
VALUES
(@WorkflowId, -1, 'Archive');

INSERT INTO [WorkflowStatus]
([WorkflowId], [Weight], [FriendlyName])
VALUES
(@WorkflowId, 0, 'Draft');
set @DraftWorkflowStatusId = SCOPE_IDENTITY()

INSERT INTO [WorkflowStatus]
([WorkflowId], [Weight], [FriendlyName])
VALUES
(@WorkflowId, 3, 'Published');
set @PublishedWorkflowStatusId = SCOPE_IDENTITY()

INSERT INTO [WorkflowStatus]
([WorkflowId], [Weight], [FriendlyName])
VALUES
(@WorkflowId, 2, 'Ready');
set @ReadyWorkflowStatusId = SCOPE_IDENTITY()
--|--------------------------------------------------------------------------------

--|--------------------------------------------------------------------------------
--| [WorkflowStatusAccess] - Backs up all the data from a table into a SQL script.
--|--------------------------------------------------------------------------------
INSERT INTO [WorkflowStatusAccess]
([StatusId], [RoleId])
VALUES
(@DraftWorkflowStatusId, 'Everyone');

INSERT INTO [WorkflowStatusAccess]
([StatusId], [RoleId])
VALUES
(@PublishedWorkflowStatusId, 'Cms Managers');

INSERT INTO [WorkflowStatusAccess]
([StatusId], [RoleId])
VALUES
(@PublishedWorkflowStatusId, 'Admins');

INSERT INTO [WorkflowStatusAccess]
([StatusId], [RoleId])
VALUES
(@PublishedWorkflowStatusId, 'Cms Admins');

INSERT INTO [WorkflowStatusAccess]
([StatusId], [RoleId])
VALUES
(@ReadyWorkflowStatusId, 'Cms Editors');	

INSERT INTO [WorkflowStatusAccess]
([StatusId], [RoleId])
VALUES
(@ReadyWorkflowStatusId, 'Admins');
GO
--|--------------------------------------------------------------------------------

--Bring the SchemaVersion up to the current level
DECLARE @Major int, @Minor int, @Patch int, @Installed DateTime

Set @Major = 5;
Set @Minor = 0;
Set @Patch = 0;

WHILE( @Patch <= 33)  --## Don't forget to update the patch counter here and also in ECF_DB_SCHEMAVERSIONCHECK.SQL ;) ##
BEGIN
	IF NOT EXISTS (Select * from SchemaVersion where Major=@Major and Minor=@Minor and Patch=@Patch)
		Insert into SchemaVersion(Major, Minor, Patch, InstallDate) values (@Major, @Minor, @Patch, GetDate())
	Set @Patch = @Patch + 1
END
Print 'Schema Patch v' + Convert(Varchar(2),@Major) + '.' + Convert(Varchar(2),@Minor) + '.' +  Convert(Varchar(3),@Patch) + ' was applied successfully '
GO