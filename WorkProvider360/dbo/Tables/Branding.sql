CREATE TABLE [dbo].[Branding] (
    [SettingsId] INT           NOT NULL,
    [LogoBase64] NVARCHAR (MAX) NULL,   -- data URI, e.g. data:image/png;base64,....
    [UpdatedOn]  DATETIME2 (7) CONSTRAINT [DF_Branding_UpdatedOn] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Branding] PRIMARY KEY CLUSTERED ([SettingsId] ASC)
);
