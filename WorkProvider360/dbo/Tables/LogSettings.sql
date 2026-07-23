CREATE TABLE [dbo].[LogSettings] (
    [SettingsId]         INT           NOT NULL,
    [AdminCanViewLogs]   BIT           CONSTRAINT [DF_LogSettings_Admin]     DEFAULT ((0)) NOT NULL,
    [ManagerCanViewLogs] BIT           CONSTRAINT [DF_LogSettings_Manager]   DEFAULT ((0)) NOT NULL,
    [UpdatedOn]          DATETIME2 (7) CONSTRAINT [DF_LogSettings_UpdatedOn] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_LogSettings] PRIMARY KEY CLUSTERED ([SettingsId] ASC)
);
