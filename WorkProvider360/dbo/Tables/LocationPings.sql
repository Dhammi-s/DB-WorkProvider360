/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE TABLE [dbo].[LocationPings] (
    [PingId]         BIGINT         IDENTITY (1, 1) NOT NULL,
    [ScheduleId]     INT            NOT NULL,
    [UserId]         INT            NOT NULL,
    [Latitude]       DECIMAL (9, 6) NOT NULL,
    [Longitude]      DECIMAL (9, 6) NOT NULL,
    [AccuracyMeters] DECIMAL (9, 2) NULL,
    [RecordedUtc]    DATETIME2 (7)  CONSTRAINT [DF_LocationPings_RecordedUtc] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_LocationPings] PRIMARY KEY CLUSTERED ([PingId] ASC),
    CONSTRAINT [FK_LocationPings_Schedules] FOREIGN KEY ([ScheduleId]) REFERENCES [dbo].[Schedules] ([ScheduleId]),
    CONSTRAINT [FK_LocationPings_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])
);


GO
CREATE NONCLUSTERED INDEX [IX_LocationPings_Schedule]
    ON [dbo].[LocationPings]([ScheduleId] ASC, [RecordedUtc] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_LocationPings_User]
    ON [dbo].[LocationPings]([UserId] ASC, [RecordedUtc] ASC);

