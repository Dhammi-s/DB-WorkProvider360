/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

/* ------------------------------ TimeEntries ------------------------------ */
CREATE   PROCEDURE dbo.usp_TimeEntry_ClockIn
    @ScheduleId INT,
    @UserId     INT,
    @Latitude   DECIMAL(9,6) = NULL,
    @Longitude  DECIMAL(9,6) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.TimeEntries (ScheduleId, UserId, ClockInUtc, ClockInLatitude, ClockInLongitude, Source)
    VALUES (@ScheduleId, @UserId, SYSUTCDATETIME(), @Latitude, @Longitude, N'Timer');

    SELECT CAST(SCOPE_IDENTITY() AS INT);
END
