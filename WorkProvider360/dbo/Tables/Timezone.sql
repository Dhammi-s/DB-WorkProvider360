/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE TABLE [dbo].[Timezone] (
    [TimezoneId]     UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [Timezone]       NVARCHAR (100)   NOT NULL,
    [Description]    NVARCHAR (100)   NULL,
    [AgencyTimezone] NVARCHAR (100)   NULL,
    [CreatedOn]      DATETIME2 (7)    DEFAULT (sysdatetime()) NOT NULL,
    [ModifiedOn]     DATETIME2 (7)    DEFAULT (sysdatetime()) NOT NULL,
    [IsActive]       BIT              DEFAULT ((1)) NOT NULL,
    [IsArchived]     BIT              DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_Timezone] PRIMARY KEY CLUSTERED ([TimezoneId] ASC)
);

