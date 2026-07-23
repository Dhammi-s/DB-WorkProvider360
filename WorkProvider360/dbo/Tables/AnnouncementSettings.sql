CREATE TABLE [dbo].[AnnouncementSettings] (
    [SettingsId]      INT           NOT NULL,
    [ShowToAdmin]     BIT           CONSTRAINT [DF_AnnSettings_Admin]     DEFAULT ((1)) NOT NULL,
    [ShowToManager]   BIT           CONSTRAINT [DF_AnnSettings_Manager]   DEFAULT ((1)) NOT NULL,
    [ShowToUser]      BIT           CONSTRAINT [DF_AnnSettings_User]      DEFAULT ((1)) NOT NULL,
    [UpdatedOn]       DATETIME2 (7) CONSTRAINT [DF_AnnSettings_UpdatedOn] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_AnnouncementSettings] PRIMARY KEY CLUSTERED ([SettingsId] ASC)
);
