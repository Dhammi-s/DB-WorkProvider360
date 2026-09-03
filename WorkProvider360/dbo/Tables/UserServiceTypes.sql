/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-09-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

/* Skills (service types) a staff user can perform. */
CREATE TABLE [dbo].[UserServiceTypes] (
    [UserId]        INT           NOT NULL,
    [ServiceTypeId] INT           NOT NULL,
    [CreatedOn]     DATETIME2 (7) CONSTRAINT [DF_UserServiceTypes_CreatedOn] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_UserServiceTypes] PRIMARY KEY CLUSTERED ([UserId] ASC, [ServiceTypeId] ASC),
    CONSTRAINT [FK_UserServiceTypes_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]),
    CONSTRAINT [FK_UserServiceTypes_ServiceTypes] FOREIGN KEY ([ServiceTypeId]) REFERENCES [dbo].[ServiceTypes] ([ServiceTypeId])
);


GO
CREATE NONCLUSTERED INDEX [IX_UserServiceTypes_ServiceTypeId]
    ON [dbo].[UserServiceTypes]([ServiceTypeId] ASC);
