/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-09-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

/* Extended profile for a staff user. Populated when an application is approved;
   editable afterwards. One row per user. */
CREATE TABLE [dbo].[UserProfiles] (
    [UserId]                INT             NOT NULL,
    [AddressLine1]          NVARCHAR (200)  NULL,
    [AddressLine2]          NVARCHAR (200)  NULL,
    [City]                  NVARCHAR (100)  NULL,
    [State]                 NVARCHAR (100)  NULL,
    [PostalCode]            NVARCHAR (20)   NULL,
    [Country]               NVARCHAR (100)  NULL,
    [DateOfBirth]           DATE            NULL,
    [Gender]                NVARCHAR (20)   NULL,
    [Qualifications]        NVARCHAR (MAX)  NULL,
    [YearsOfExperience]     DECIMAL (4, 1)  NULL,
    [About]                 NVARCHAR (2000) NULL,
    [HasDrivingLicense]     BIT             CONSTRAINT [DF_UserProfiles_HasDrivingLicense] DEFAULT ((0)) NOT NULL,
    [HasVehicle]            BIT             CONSTRAINT [DF_UserProfiles_HasVehicle] DEFAULT ((0)) NOT NULL,
    [EmergencyContactName]  NVARCHAR (200)  NULL,
    [EmergencyContactPhone] NVARCHAR (30)   NULL,
    [HireDate]              DATE            NULL,
    [ApplicationId]         INT             NULL,
    [CreatedOn]             DATETIME2 (7)   CONSTRAINT [DF_UserProfiles_CreatedOn] DEFAULT (sysutcdatetime()) NOT NULL,
    [UpdatedOn]             DATETIME2 (7)   NULL,
    CONSTRAINT [PK_UserProfiles] PRIMARY KEY CLUSTERED ([UserId] ASC),
    CONSTRAINT [FK_UserProfiles_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])
);
