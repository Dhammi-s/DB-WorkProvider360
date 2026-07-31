/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE TABLE [dbo].[ScheduleNotes] (
    [NoteId]       INT             IDENTITY (1, 1) NOT NULL,
    [ScheduleId]   INT             NOT NULL,
    [AuthorUserId] INT             NOT NULL,
    [NoteType]     NVARCHAR (20)   CONSTRAINT [DF_ScheduleNotes_Type] DEFAULT (N'Note') NOT NULL,
    [Message]      NVARCHAR (2000) NOT NULL,
    [CreatedOn]    DATETIME2 (7)   CONSTRAINT [DF_ScheduleNotes_CreatedOn] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_ScheduleNotes] PRIMARY KEY CLUSTERED ([NoteId] ASC),
    CONSTRAINT [FK_ScheduleNotes_Author] FOREIGN KEY ([AuthorUserId]) REFERENCES [dbo].[Users] ([UserId]),
    CONSTRAINT [FK_ScheduleNotes_Schedules] FOREIGN KEY ([ScheduleId]) REFERENCES [dbo].[Schedules] ([ScheduleId])
);


GO
CREATE NONCLUSTERED INDEX [IX_ScheduleNotes_ScheduleId]
    ON [dbo].[ScheduleNotes]([ScheduleId] ASC);

