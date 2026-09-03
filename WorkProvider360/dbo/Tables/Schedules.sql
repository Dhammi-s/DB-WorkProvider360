/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE TABLE [dbo].[Schedules] (
    [ScheduleId]         INT             IDENTITY (1, 1) NOT NULL,
    [Title]              NVARCHAR (200)  NOT NULL,
    [CustomerName]       NVARCHAR (200)  NULL,
    [Location]           NVARCHAR (300)  NULL,
    [ClientId]           INT             NULL,
    [ServiceTypeId]      INT             NULL,
    [AssignedUserId]     INT             NOT NULL,
    [StartUtc]           DATETIME2 (7)   NOT NULL,
    [EndUtc]             DATETIME2 (7)   NOT NULL,
    [PayRatePerHour]     DECIMAL (10, 2) CONSTRAINT [DF_Schedules_PayRate] DEFAULT ((0)) NOT NULL,
    [OvertimeMultiplier] DECIMAL (5, 2)  CONSTRAINT [DF_Schedules_OtMultiplier] DEFAULT ((1.5)) NOT NULL,
    [Status]             NVARCHAR (20)   CONSTRAINT [DF_Schedules_Status] DEFAULT (N'Scheduled') NOT NULL,
    [RejectionReason]    NVARCHAR (1000) NULL,
    [ColorTag]           NVARCHAR (20)   NULL,
    [CreatedByUserId]    INT             NOT NULL,
    [CreatedOn]          DATETIME2 (7)   CONSTRAINT [DF_Schedules_CreatedOn] DEFAULT (sysutcdatetime()) NOT NULL,
    [UpdatedOn]          DATETIME2 (7)   CONSTRAINT [DF_Schedules_UpdatedOn] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Schedules] PRIMARY KEY CLUSTERED ([ScheduleId] ASC),
    CONSTRAINT [FK_Schedules_AssignedUser] FOREIGN KEY ([AssignedUserId]) REFERENCES [dbo].[Users] ([UserId]),
    CONSTRAINT [FK_Schedules_CreatedBy] FOREIGN KEY ([CreatedByUserId]) REFERENCES [dbo].[Users] ([UserId]),
    CONSTRAINT [FK_Schedules_Clients] FOREIGN KEY ([ClientId]) REFERENCES [dbo].[Clients] ([ClientId]),
    CONSTRAINT [FK_Schedules_ServiceTypes] FOREIGN KEY ([ServiceTypeId]) REFERENCES [dbo].[ServiceTypes] ([ServiceTypeId])
);


GO
CREATE NONCLUSTERED INDEX [IX_Schedules_AssignedUserId]
    ON [dbo].[Schedules]([AssignedUserId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Schedules_StartUtc]
    ON [dbo].[Schedules]([StartUtc] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Schedules_ClientId]
    ON [dbo].[Schedules]([ClientId] ASC);
