/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-09-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

/* Tenant-managed list of services/skills. Soft-deactivate only. */
CREATE TABLE [dbo].[ServiceTypes] (
    [ServiceTypeId]   INT            IDENTITY (1, 1) NOT NULL,
    [Name]            NVARCHAR (100) NOT NULL,
    [Description]     NVARCHAR (500) NULL,
    [Category]        NVARCHAR (50)  NULL,
    [ColorTag]        NVARCHAR (20)  NULL,
    [SortOrder]       INT            CONSTRAINT [DF_ServiceTypes_SortOrder] DEFAULT ((0)) NOT NULL,
    [IsActive]        BIT            CONSTRAINT [DF_ServiceTypes_IsActive] DEFAULT ((1)) NOT NULL,
    [CreatedByUserId] INT            NULL,
    [CreatedOn]       DATETIME2 (7)  CONSTRAINT [DF_ServiceTypes_CreatedOn] DEFAULT (sysutcdatetime()) NOT NULL,
    [UpdatedOn]       DATETIME2 (7)  NULL,
    CONSTRAINT [PK_ServiceTypes] PRIMARY KEY CLUSTERED ([ServiceTypeId] ASC),
    CONSTRAINT [UQ_ServiceTypes_Name] UNIQUE NONCLUSTERED ([Name] ASC)
);
