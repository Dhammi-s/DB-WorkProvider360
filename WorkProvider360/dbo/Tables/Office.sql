/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE TABLE [dbo].[Office] (
    [OfficeId]   UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [OfficeName] NVARCHAR (200)   NOT NULL,
    [Address]    NVARCHAR (500)   NULL,
    [Phone]      NVARCHAR (50)    NULL,
    [TimezoneId] UNIQUEIDENTIFIER NULL,
    [IsActive]   BIT              CONSTRAINT [DF_Office_IsActive] DEFAULT ((1)) NOT NULL,
    [IsArchived] BIT              CONSTRAINT [DF_Office_IsArchived] DEFAULT ((0)) NOT NULL,
    [CreatedOn]  DATETIME2 (7)    CONSTRAINT [DF_Office_CreatedOn] DEFAULT (sysutcdatetime()) NOT NULL,
    [UpdatedOn]  DATETIME2 (7)    NULL,
    CONSTRAINT [PK_Office] PRIMARY KEY CLUSTERED ([OfficeId] ASC),
    CONSTRAINT [FK_Office_Timezone] FOREIGN KEY ([TimezoneId]) REFERENCES [dbo].[Timezone] ([TimezoneId])
);
