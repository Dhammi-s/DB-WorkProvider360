CREATE TABLE [dbo].[RoleApplications] (
    [ApplicationId]    INT             IDENTITY (1, 1) NOT NULL,
    [FullName]         NVARCHAR (200)  NOT NULL,
    [Email]            NVARCHAR (256)  NOT NULL,
    [Phone]            NVARCHAR (50)   NULL,
    [Address]          NVARCHAR (500)  NULL,
    [RequestedRoleId]  INT             NOT NULL,
    [Status]           NVARCHAR (20)   CONSTRAINT [DF_RoleApplications_Status] DEFAULT (N'Pending') NOT NULL,
    [RejectionReason]  NVARCHAR (1000) NULL,
    [ReviewedByUserId] INT             NULL,
    [ReviewedOn]       DATETIME2 (7)   NULL,
    [CreatedOn]        DATETIME2 (7)   CONSTRAINT [DF_RoleApplications_CreatedOn] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_RoleApplications] PRIMARY KEY CLUSTERED ([ApplicationId] ASC),
    CONSTRAINT [FK_RoleApplications_Roles] FOREIGN KEY ([RequestedRoleId]) REFERENCES [dbo].[Roles] ([RoleId])
);


GO
CREATE NONCLUSTERED INDEX [IX_RoleApplications_Status]
    ON [dbo].[RoleApplications]([Status] ASC);

