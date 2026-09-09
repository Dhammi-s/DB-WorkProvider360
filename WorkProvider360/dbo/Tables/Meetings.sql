/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE TABLE [dbo].[Meetings] (
    [MeetingId]        INT             IDENTITY (1, 1) NOT NULL,
    [Title]            NVARCHAR (200)  NOT NULL,
    [Description]      NVARCHAR (MAX)  NULL,
    [StartUtc]         DATETIME2 (7)   NOT NULL,
    [EndUtc]           DATETIME2 (7)   NOT NULL,
    [Location]         NVARCHAR (300)  NULL,
    [MeetingType]      NVARCHAR (20)   CONSTRAINT [DF_Meetings_MeetingType] DEFAULT (N'InPerson')  NOT NULL,
    [Status]           NVARCHAR (20)   CONSTRAINT [DF_Meetings_Status]      DEFAULT (N'Scheduled') NOT NULL,
    [IsPaid]           BIT             CONSTRAINT [DF_Meetings_IsPaid]      DEFAULT ((0))          NOT NULL,
    [FeePerParticipant]DECIMAL (10, 2) CONSTRAINT [DF_Meetings_Fee]         DEFAULT ((0))          NOT NULL,
    [CreatedByUserId]  INT             NOT NULL,
    [CreatedByName]    NVARCHAR (200)  NULL,
    [MaxParticipants]  INT             CONSTRAINT [DF_Meetings_MaxPart]     DEFAULT ((10))         NOT NULL,
    [Notes]            NVARCHAR (MAX)  NULL,
    [ColorTag]         NVARCHAR (20)   NULL,
    [CreatedOn]        DATETIME2 (7)   CONSTRAINT [DF_Meetings_CreatedOn]   DEFAULT (sysutcdatetime()) NOT NULL,
    [UpdatedOn]        DATETIME2 (7)   CONSTRAINT [DF_Meetings_UpdatedOn]   DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Meetings] PRIMARY KEY CLUSTERED ([MeetingId] ASC),
    CONSTRAINT [FK_Meetings_CreatedBy] FOREIGN KEY ([CreatedByUserId]) REFERENCES [dbo].[Users] ([UserId])
);


GO
CREATE NONCLUSTERED INDEX [IX_Meetings_StartUtc]
    ON [dbo].[Meetings]([StartUtc] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Meetings_Status]
    ON [dbo].[Meetings]([Status] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Meetings_CreatedByUserId]
    ON [dbo].[Meetings]([CreatedByUserId] ASC);
