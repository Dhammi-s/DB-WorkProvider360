/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE TABLE [dbo].[RoleApplications] (
    [ApplicationId]     INT             IDENTITY (1, 1) NOT NULL,
    [FullName]          NVARCHAR (200)  NOT NULL,
    [Email]             NVARCHAR (256)  NOT NULL,
    [Phone]             NVARCHAR (50)   NULL,
    [Address]           NVARCHAR (500)  NULL,
    [City]              NVARCHAR (100)  NULL,
    [State]             NVARCHAR (100)  NULL,
    [PostalCode]        NVARCHAR (20)   NULL,
    [DateOfBirth]       DATE            NULL,
    [Gender]            NVARCHAR (20)   NULL,
    [Qualifications]    NVARCHAR (MAX)  NULL,
    [YearsOfExperience] DECIMAL (4, 1)  NULL,
    [About]             NVARCHAR (2000) NULL,
    [HasDrivingLicense] BIT             NULL,
    [HasVehicle]        BIT             NULL,
    [RequestedRoleId]   INT             NOT NULL,
    [DesiredSalary]     DECIMAL (10, 2) NULL,
    [Status]            NVARCHAR (20)   CONSTRAINT [DF_RoleApplications_Status] DEFAULT (N'Pending') NOT NULL,
    [RejectionReason]   NVARCHAR (1000) NULL,
    [ReviewedByUserId]  INT             NULL,
    [ReviewedOn]        DATETIME2 (7)   NULL,
    [CreatedOn]         DATETIME2 (7)   CONSTRAINT [DF_RoleApplications_CreatedOn] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_RoleApplications] PRIMARY KEY CLUSTERED ([ApplicationId] ASC),
    CONSTRAINT [FK_RoleApplications_Roles] FOREIGN KEY ([RequestedRoleId]) REFERENCES [dbo].[Roles] ([RoleId])
);


GO
CREATE NONCLUSTERED INDEX [IX_RoleApplications_Status]
    ON [dbo].[RoleApplications]([Status] ASC);
