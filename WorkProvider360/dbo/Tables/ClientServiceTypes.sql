/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-09-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

/* Services a client has asked for. */
CREATE TABLE [dbo].[ClientServiceTypes] (
    [ClientId]      INT            NOT NULL,
    [ServiceTypeId] INT            NOT NULL,
    [Notes]         NVARCHAR (500) NULL,
    [CreatedOn]     DATETIME2 (7)  CONSTRAINT [DF_ClientServiceTypes_CreatedOn] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_ClientServiceTypes] PRIMARY KEY CLUSTERED ([ClientId] ASC, [ServiceTypeId] ASC),
    CONSTRAINT [FK_ClientServiceTypes_Clients] FOREIGN KEY ([ClientId]) REFERENCES [dbo].[Clients] ([ClientId]),
    CONSTRAINT [FK_ClientServiceTypes_ServiceTypes] FOREIGN KEY ([ServiceTypeId]) REFERENCES [dbo].[ServiceTypes] ([ServiceTypeId])
);


GO
CREATE NONCLUSTERED INDEX [IX_ClientServiceTypes_ServiceTypeId]
    ON [dbo].[ClientServiceTypes]([ServiceTypeId] ASC);
