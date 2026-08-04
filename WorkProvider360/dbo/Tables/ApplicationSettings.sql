/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE TABLE [dbo].[ApplicationSettings] (
    [SettingsId]                INT            NOT NULL,
    [RequirePhone]              BIT            CONSTRAINT [DF_AppSettings_RequirePhone] DEFAULT ((1)) NOT NULL,
    [RequireAddress]            BIT            CONSTRAINT [DF_AppSettings_RequireAddress] DEFAULT ((1)) NOT NULL,
    [EmailNotificationsEnabled] BIT            CONSTRAINT [DF_AppSettings_Email] DEFAULT ((1)) NOT NULL,
    [NotificationEmail]         NVARCHAR (256) NULL,
    [AllowStaffUnlock]          BIT            CONSTRAINT [DF_AppSettings_AllowStaffUnlock] DEFAULT ((0)) NOT NULL,
    [UpdatedOn]                 DATETIME2 (7)  CONSTRAINT [DF_AppSettings_UpdatedOn] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_ApplicationSettings] PRIMARY KEY CLUSTERED ([SettingsId] ASC)
);

