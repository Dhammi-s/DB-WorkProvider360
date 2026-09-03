/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-09-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

/* Weekly availability an applicant offers on the public application form.
   DayOfWeek follows .NET: 0 = Sunday ... 6 = Saturday. */
CREATE TABLE [dbo].[ApplicationAvailability] (
    [AvailabilityId] INT      IDENTITY (1, 1) NOT NULL,
    [ApplicationId]  INT      NOT NULL,
    [DayOfWeek]      TINYINT  NOT NULL,
    [StartTime]      TIME (0) NOT NULL,
    [EndTime]        TIME (0) NOT NULL,
    CONSTRAINT [PK_ApplicationAvailability] PRIMARY KEY CLUSTERED ([AvailabilityId] ASC),
    CONSTRAINT [FK_ApplicationAvailability_RoleApplications] FOREIGN KEY ([ApplicationId]) REFERENCES [dbo].[RoleApplications] ([ApplicationId])
);


GO
CREATE NONCLUSTERED INDEX [IX_ApplicationAvailability_ApplicationId]
    ON [dbo].[ApplicationAvailability]([ApplicationId] ASC, [DayOfWeek] ASC);
