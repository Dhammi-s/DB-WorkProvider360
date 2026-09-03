/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-09-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

/* Single-row (SettingsId = 1) switches for clients, service types, client
   visits (auto clock, signatures, GPS) and the client portal. Access columns
   hold None / Read / Write. Seeded by the post-deploy script. */
CREATE TABLE [dbo].[ClientSettings] (
    [SettingsId]                       INT           NOT NULL,
    [AdminClientAccess]                NVARCHAR (10) CONSTRAINT [DF_ClientSettings_AdminClientAccess] DEFAULT (N'Write') NOT NULL,
    [ManagerClientAccess]              NVARCHAR (10) CONSTRAINT [DF_ClientSettings_ManagerClientAccess] DEFAULT (N'Read') NOT NULL,
    [AdminServiceTypeAccess]           NVARCHAR (10) CONSTRAINT [DF_ClientSettings_AdminServiceTypeAccess] DEFAULT (N'Write') NOT NULL,
    [ManagerServiceTypeAccess]         NVARCHAR (10) CONSTRAINT [DF_ClientSettings_ManagerServiceTypeAccess] DEFAULT (N'Write') NOT NULL,
    [AutoClockInEnabled]               BIT           CONSTRAINT [DF_ClientSettings_AutoClockIn] DEFAULT ((0)) NOT NULL,
    [AutoClockOutEnabled]              BIT           CONSTRAINT [DF_ClientSettings_AutoClockOut] DEFAULT ((0)) NOT NULL,
    [RequireClientSignatureOnClockIn]  BIT           CONSTRAINT [DF_ClientSettings_SignatureClockIn] DEFAULT ((0)) NOT NULL,
    [RequireClientSignatureOnClockOut] BIT           CONSTRAINT [DF_ClientSettings_SignatureClockOut] DEFAULT ((1)) NOT NULL,
    [RequireSameOffice]                BIT           CONSTRAINT [DF_ClientSettings_RequireSameOffice] DEFAULT ((1)) NOT NULL,
    [RequireMatchingSkill]             BIT           CONSTRAINT [DF_ClientSettings_RequireMatchingSkill] DEFAULT ((0)) NOT NULL,
    [CaptureClockLocation]             BIT           CONSTRAINT [DF_ClientSettings_CaptureClockLocation] DEFAULT ((1)) NOT NULL,
    [ClientPortalEnabled]              BIT           CONSTRAINT [DF_ClientSettings_ClientPortalEnabled] DEFAULT ((1)) NOT NULL,
    [SendClientCredentialsEmail]       BIT           CONSTRAINT [DF_ClientSettings_SendCredentialsEmail] DEFAULT ((1)) NOT NULL,
    [NotifyClientOnSchedule]           BIT           CONSTRAINT [DF_ClientSettings_NotifyClientOnSchedule] DEFAULT ((1)) NOT NULL,
    [RequireClientEmail]               BIT           CONSTRAINT [DF_ClientSettings_RequireClientEmail] DEFAULT ((1)) NOT NULL,
    [RequireClientPhone]               BIT           CONSTRAINT [DF_ClientSettings_RequireClientPhone] DEFAULT ((1)) NOT NULL,
    [RequireClientDateOfBirth]         BIT           CONSTRAINT [DF_ClientSettings_RequireClientDob] DEFAULT ((0)) NOT NULL,
    [RequireEmergencyContact]          BIT           CONSTRAINT [DF_ClientSettings_RequireEmergencyContact] DEFAULT ((0)) NOT NULL,
    [RequireClientServiceTypes]        BIT           CONSTRAINT [DF_ClientSettings_RequireClientServiceTypes] DEFAULT ((1)) NOT NULL,
    [UpdatedOn]                        DATETIME2 (7) CONSTRAINT [DF_ClientSettings_UpdatedOn] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_ClientSettings] PRIMARY KEY CLUSTERED ([SettingsId] ASC)
);
