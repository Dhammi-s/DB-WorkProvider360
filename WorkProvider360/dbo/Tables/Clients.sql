/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-09-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

/* A client (the person whose home is visited). Optional portal login lives in
   Users (RoleId = 5, role name Client) and is linked through UserId. */
CREATE TABLE [dbo].[Clients] (
    [ClientId]                 INT              IDENTITY (1, 1) NOT NULL,
    [UserId]                   INT              NULL,
    [OfficeId]                 UNIQUEIDENTIFIER NULL,
    [FirstName]                NVARCHAR (100)   NOT NULL,
    [LastName]                 NVARCHAR (100)   NOT NULL,
    [Email]                    NVARCHAR (256)   NULL,
    [Phone]                    NVARCHAR (30)    NULL,
    [AlternatePhone]           NVARCHAR (30)    NULL,
    [DateOfBirth]              DATE             NULL,
    [Gender]                   NVARCHAR (20)    NULL,
    [AddressLine1]             NVARCHAR (200)   NOT NULL,
    [AddressLine2]             NVARCHAR (200)   NULL,
    [City]                     NVARCHAR (100)   NULL,
    [State]                    NVARCHAR (100)   NULL,
    [PostalCode]               NVARCHAR (20)    NULL,
    [Country]                  NVARCHAR (100)   NULL,
    [Latitude]                 DECIMAL (9, 6)   NULL,
    [Longitude]                DECIMAL (9, 6)   NULL,
    [EmergencyContactName]     NVARCHAR (200)   NULL,
    [EmergencyContactPhone]    NVARCHAR (30)    NULL,
    [EmergencyContactRelation] NVARCHAR (50)    NULL,
    [PreferredLanguage]        NVARCHAR (50)    NULL,
    [AccessInstructions]       NVARCHAR (1000)  NULL,
    [CareNotes]                NVARCHAR (MAX)   NULL,
    [Allergies]                NVARCHAR (500)   NULL,
    [MobilityNotes]            NVARCHAR (500)   NULL,
    [PortalEnabled]            BIT              CONSTRAINT [DF_Clients_PortalEnabled] DEFAULT ((0)) NOT NULL,
    [Status]                   NVARCHAR (20)    CONSTRAINT [DF_Clients_Status] DEFAULT (N'Active') NOT NULL,
    [StartDate]                DATE             NULL,
    [Notes]                    NVARCHAR (2000)  NULL,
    [CreatedByUserId]          INT              NULL,
    [CreatedOn]                DATETIME2 (7)    CONSTRAINT [DF_Clients_CreatedOn] DEFAULT (sysutcdatetime()) NOT NULL,
    [UpdatedOn]                DATETIME2 (7)    NULL,
    CONSTRAINT [PK_Clients] PRIMARY KEY CLUSTERED ([ClientId] ASC),
    CONSTRAINT [FK_Clients_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]),
    CONSTRAINT [FK_Clients_Office] FOREIGN KEY ([OfficeId]) REFERENCES [dbo].[Office] ([OfficeId])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UX_Clients_UserId]
    ON [dbo].[Clients]([UserId] ASC) WHERE ([UserId] IS NOT NULL);


GO
CREATE NONCLUSTERED INDEX [IX_Clients_OfficeId]
    ON [dbo].[Clients]([OfficeId] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Clients_Status]
    ON [dbo].[Clients]([Status] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Clients_LastName]
    ON [dbo].[Clients]([LastName] ASC, [FirstName] ASC);
