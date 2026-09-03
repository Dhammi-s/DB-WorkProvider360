/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-09-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

/* Weekly working-time ranges for a staff user. DayOfWeek follows .NET:
   0 = Sunday ... 6 = Saturday. Several ranges per day are allowed. */
CREATE TABLE [dbo].[UserAvailability] (
    [AvailabilityId] INT      IDENTITY (1, 1) NOT NULL,
    [UserId]         INT      NOT NULL,
    [DayOfWeek]      TINYINT  NOT NULL,
    [StartTime]      TIME (0) NOT NULL,
    [EndTime]        TIME (0) NOT NULL,
    CONSTRAINT [PK_UserAvailability] PRIMARY KEY CLUSTERED ([AvailabilityId] ASC),
    CONSTRAINT [FK_UserAvailability_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])
);


GO
CREATE NONCLUSTERED INDEX [IX_UserAvailability_UserId]
    ON [dbo].[UserAvailability]([UserId] ASC, [DayOfWeek] ASC);
