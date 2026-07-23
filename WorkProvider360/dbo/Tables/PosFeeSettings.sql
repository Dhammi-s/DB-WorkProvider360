CREATE TABLE [dbo].[PosFeeSettings] (
    [SettingsId] INT            NOT NULL,
    [FeePercent] DECIMAL (5, 2) CONSTRAINT [DF_PosFee_Percent] DEFAULT ((1.00)) NOT NULL,
    [FeeFixed]   DECIMAL (10, 2) CONSTRAINT [DF_PosFee_Fixed]  DEFAULT ((0.20)) NOT NULL,
    [UpdatedOn]  DATETIME2 (7)  CONSTRAINT [DF_PosFee_UpdatedOn] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_PosFeeSettings] PRIMARY KEY CLUSTERED ([SettingsId] ASC)
);
