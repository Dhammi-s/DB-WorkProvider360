/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE TABLE [dbo].[MeetingPayments] (
    [PaymentId]          INT             IDENTITY (1, 1) NOT NULL,
    [MeetingId]          INT             NOT NULL,
    [ParticipantId]      INT             NULL,
    [Amount]             DECIMAL (10, 2) NOT NULL,
    [Method]             NVARCHAR (20)   CONSTRAINT [DF_MeetPay_Method]  DEFAULT (N'Cash')    NOT NULL,
    [Status]             NVARCHAR (20)   CONSTRAINT [DF_MeetPay_Status]  DEFAULT (N'Pending') NOT NULL,
    [TransactionId]      NVARCHAR (200)  NULL,
    [Notes]              NVARCHAR (MAX)  NULL,
    [PaidAt]             DATETIME2 (7)   NULL,
    [RecordedByUserId]   INT             NOT NULL,
    [RecordedByName]     NVARCHAR (200)  NULL,
    [RecordedAt]         DATETIME2 (7)   CONSTRAINT [DF_MeetPay_RecordedAt] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_MeetingPayments] PRIMARY KEY CLUSTERED ([PaymentId] ASC),
    CONSTRAINT [FK_MeetPay_Meeting]      FOREIGN KEY ([MeetingId])       REFERENCES [dbo].[Meetings]            ([MeetingId]) ON DELETE CASCADE,
    CONSTRAINT [FK_MeetPay_Participant]  FOREIGN KEY ([ParticipantId])   REFERENCES [dbo].[MeetingParticipants] ([ParticipantId]),
    CONSTRAINT [FK_MeetPay_RecordedBy]  FOREIGN KEY ([RecordedByUserId]) REFERENCES [dbo].[Users]              ([UserId])
);


GO
CREATE NONCLUSTERED INDEX [IX_MeetPay_MeetingId]
    ON [dbo].[MeetingPayments]([MeetingId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_MeetPay_ParticipantId]
    ON [dbo].[MeetingPayments]([ParticipantId] ASC);
