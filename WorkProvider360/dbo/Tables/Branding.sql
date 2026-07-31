/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE TABLE [dbo].[Branding] (
    [SettingsId] INT           NOT NULL,
    [LogoBase64] NVARCHAR (MAX) NULL,   -- data URI, e.g. data:image/png;base64,....
    [UpdatedOn]  DATETIME2 (7) CONSTRAINT [DF_Branding_UpdatedOn] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Branding] PRIMARY KEY CLUSTERED ([SettingsId] ASC)
);
