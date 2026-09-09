/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE TABLE [dbo].[MeetingSettings] (
    [SettingsId]               INT             NOT NULL,
    [AdminAccess]              NVARCHAR (10)   CONSTRAINT [DF_MeetingSettings_AdminAccess]      DEFAULT (N'Write') NOT NULL,
    [ManagerAccess]            NVARCHAR (10)   CONSTRAINT [DF_MeetingSettings_ManagerAccess]    DEFAULT (N'Read')  NOT NULL,
    [UserCanCreate]            BIT             CONSTRAINT [DF_MeetingSettings_UserCanCreate]     DEFAULT ((0))      NOT NULL,
    [AllowClientParticipants]  BIT             CONSTRAINT [DF_MeetingSettings_AllowClients]      DEFAULT ((0))      NOT NULL,
    [AllowPaidMeetings]        BIT             CONSTRAINT [DF_MeetingSettings_AllowPaid]         DEFAULT ((0))      NOT NULL,
    [DefaultFeePerParticipant] DECIMAL (10, 2) CONSTRAINT [DF_MeetingSettings_DefaultFee]       DEFAULT ((0))      NOT NULL,
    [RequireApproval]          BIT             CONSTRAINT [DF_MeetingSettings_RequireApproval]   DEFAULT ((0))      NOT NULL,
    [NotifyOnCreate]           BIT             CONSTRAINT [DF_MeetingSettings_NotifyCreate]      DEFAULT ((0))      NOT NULL,
    [NotifyOnUpdate]           BIT             CONSTRAINT [DF_MeetingSettings_NotifyUpdate]      DEFAULT ((0))      NOT NULL,
    [NotifyOnCancel]           BIT             CONSTRAINT [DF_MeetingSettings_NotifyCancel]      DEFAULT ((0))      NOT NULL,
    [MaxParticipantsDefault]   INT             CONSTRAINT [DF_MeetingSettings_MaxParticipants]   DEFAULT ((10))     NOT NULL,
    [UpdatedOn]                DATETIME2 (7)   CONSTRAINT [DF_MeetingSettings_UpdatedOn]         DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_MeetingSettings] PRIMARY KEY CLUSTERED ([SettingsId] ASC)
);
