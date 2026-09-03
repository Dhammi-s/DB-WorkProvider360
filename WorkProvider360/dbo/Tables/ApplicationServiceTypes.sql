/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-09-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

/* Skills an applicant claims on the public application form. */
CREATE TABLE [dbo].[ApplicationServiceTypes] (
    [ApplicationId] INT           NOT NULL,
    [ServiceTypeId] INT           NOT NULL,
    [CreatedOn]     DATETIME2 (7) CONSTRAINT [DF_ApplicationServiceTypes_CreatedOn] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_ApplicationServiceTypes] PRIMARY KEY CLUSTERED ([ApplicationId] ASC, [ServiceTypeId] ASC),
    CONSTRAINT [FK_ApplicationServiceTypes_RoleApplications] FOREIGN KEY ([ApplicationId]) REFERENCES [dbo].[RoleApplications] ([ApplicationId]),
    CONSTRAINT [FK_ApplicationServiceTypes_ServiceTypes] FOREIGN KEY ([ServiceTypeId]) REFERENCES [dbo].[ServiceTypes] ([ServiceTypeId])
);
