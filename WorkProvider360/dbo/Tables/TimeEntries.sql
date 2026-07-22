CREATE TABLE [dbo].[TimeEntries] (
    [TimeEntryId] INT            IDENTITY (1, 1) NOT NULL,
    [ScheduleId]  INT            NOT NULL,
    [UserId]      INT            NOT NULL,
    [ClockInUtc]  DATETIME2 (7)  NOT NULL,
    [ClockOutUtc] DATETIME2 (7)  NULL,
    [Source]      NVARCHAR (10)  CONSTRAINT [DF_TimeEntries_Source] DEFAULT (N'Timer') NOT NULL,
    [Note]        NVARCHAR (500) NULL,
    [CreatedOn]   DATETIME2 (7)  CONSTRAINT [DF_TimeEntries_CreatedOn] DEFAULT (sysutcdatetime()) NOT NULL,
    [UpdatedOn]   DATETIME2 (7)  CONSTRAINT [DF_TimeEntries_UpdatedOn] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_TimeEntries] PRIMARY KEY CLUSTERED ([TimeEntryId] ASC),
    CONSTRAINT [FK_TimeEntries_Schedules] FOREIGN KEY ([ScheduleId]) REFERENCES [dbo].[Schedules] ([ScheduleId]),
    CONSTRAINT [FK_TimeEntries_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])
);


GO
CREATE NONCLUSTERED INDEX [IX_TimeEntries_ScheduleId]
    ON [dbo].[TimeEntries]([ScheduleId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_TimeEntries_UserId]
    ON [dbo].[TimeEntries]([UserId] ASC);

