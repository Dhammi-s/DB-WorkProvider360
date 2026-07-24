CREATE TABLE [dbo].[SchedulingSettings] (
    [SettingsId]                INT             NOT NULL,
    [AdminAccess]               NVARCHAR (10)   CONSTRAINT [DF_SchedSettings_AdminAccess] DEFAULT (N'Write') NOT NULL,
    [ManagerAccess]             NVARCHAR (10)   CONSTRAINT [DF_SchedSettings_ManagerAccess] DEFAULT (N'Read') NOT NULL,
    [DefaultPayRatePerHour]     DECIMAL (10, 2) CONSTRAINT [DF_SchedSettings_PayRate] DEFAULT ((0)) NOT NULL,
    [DefaultOvertimeMultiplier] DECIMAL (5, 2)  CONSTRAINT [DF_SchedSettings_OtMultiplier] DEFAULT ((1.5)) NOT NULL,
    [NotifyAdminOnCreate]       BIT             CONSTRAINT [DF_SchedSettings_NotifyAdmin] DEFAULT ((0)) NOT NULL,
    [NotifyManagerOnCreate]     BIT             CONSTRAINT [DF_SchedSettings_NotifyManager] DEFAULT ((0)) NOT NULL,
    [AutoClockEnabled]          BIT             CONSTRAINT [DF_SchedSettings_AutoClock] DEFAULT ((0)) NOT NULL,
    [UpdatedOn]                 DATETIME2 (7)   CONSTRAINT [DF_SchedSettings_UpdatedOn] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_SchedulingSettings] PRIMARY KEY CLUSTERED ([SettingsId] ASC)
);

