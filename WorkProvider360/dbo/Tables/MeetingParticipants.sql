/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE TABLE [dbo].[MeetingParticipants] (
    [ParticipantId]      INT             IDENTITY (1, 1) NOT NULL,
    [MeetingId]          INT             NOT NULL,
    [UserId]             INT             NULL,
    [ClientId]           INT             NULL,
    [ParticipantName]    NVARCHAR (200)  NULL,
    [ParticipantEmail]   NVARCHAR (200)  NULL,
    [RoleName]           NVARCHAR (100)  NULL,
    [ParticipantRole]    NVARCHAR (20)   CONSTRAINT [DF_MeetPart_Role]     DEFAULT (N'Attendee') NOT NULL,
    [Status]             NVARCHAR (20)   CONSTRAINT [DF_MeetPart_Status]   DEFAULT (N'Pending')  NOT NULL,
    [IsPaid]             BIT             CONSTRAINT [DF_MeetPart_IsPaid]   DEFAULT ((0))         NOT NULL,
    [PaymentAmount]      DECIMAL (10, 2) NULL,
    [PaymentDate]        DATETIME2 (7)   NULL,
    [PaymentMethod]      NVARCHAR (50)   NULL,
    [InvitedAt]          DATETIME2 (7)   CONSTRAINT [DF_MeetPart_InvitedAt] DEFAULT (sysutcdatetime()) NOT NULL,
    [RespondedAt]        DATETIME2 (7)   NULL,
    CONSTRAINT [PK_MeetingParticipants] PRIMARY KEY CLUSTERED ([ParticipantId] ASC),
    CONSTRAINT [FK_MeetPart_Meeting]    FOREIGN KEY ([MeetingId])  REFERENCES [dbo].[Meetings] ([MeetingId]) ON DELETE CASCADE,
    CONSTRAINT [FK_MeetPart_User]       FOREIGN KEY ([UserId])     REFERENCES [dbo].[Users]    ([UserId]),
    CONSTRAINT [FK_MeetPart_Client]     FOREIGN KEY ([ClientId])   REFERENCES [dbo].[Clients]  ([ClientId])
);


GO
CREATE NONCLUSTERED INDEX [IX_MeetPart_MeetingId]
    ON [dbo].[MeetingParticipants]([MeetingId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_MeetPart_UserId]
    ON [dbo].[MeetingParticipants]([UserId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_MeetPart_ClientId]
    ON [dbo].[MeetingParticipants]([ClientId] ASC);
