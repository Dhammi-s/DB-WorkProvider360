/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE TABLE [dbo].[SecurityEvents] (
    [SecurityEventId] UNIQUEIDENTIFIER CONSTRAINT [DF_SecurityEvents_Id] DEFAULT (newid()) NOT NULL,
    [EventType]       NVARCHAR (40)    NOT NULL,   -- LoginSuccess | LoginFailed | Unauthorized | SqlInjection | DosAttempt
    [Email]           NVARCHAR (256)   NULL,
    [UserId]          INT              NULL,
    [IpAddress]       NVARCHAR (64)    NULL,       -- real client IP (X-Forwarded-For), SuperAdmin-only
    [UserAgent]       NVARCHAR (512)   NULL,
    [Path]            NVARCHAR (300)   NULL,
    [Detail]          NVARCHAR (1000)  NULL,
    [CreatedOn]       DATETIME2 (7)    CONSTRAINT [DF_SecurityEvents_CreatedOn] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_SecurityEvents] PRIMARY KEY CLUSTERED ([SecurityEventId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_SecurityEvents_CreatedOn]
    ON [dbo].[SecurityEvents]([CreatedOn] DESC);


GO
CREATE NONCLUSTERED INDEX [IX_SecurityEvents_EventType]
    ON [dbo].[SecurityEvents]([EventType] ASC);
