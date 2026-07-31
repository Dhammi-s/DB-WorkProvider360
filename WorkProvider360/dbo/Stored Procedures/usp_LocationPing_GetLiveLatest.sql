/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


/* Latest position for every schedule that is currently "live" (the assigned
   user has an open time entry). Optionally scoped to a single user. */
CREATE   PROCEDURE dbo.usp_LocationPing_GetLiveLatest
    @UserId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT
        s.ScheduleId,
        s.Title,
        s.AssignedUserId AS UserId,
        u.FullName       AS UserName,
        s.CustomerName,
        s.Location,
        p.Latitude,
        p.Longitude,
        p.AccuracyMeters,
        p.RecordedUtc
    FROM dbo.Schedules s
    INNER JOIN dbo.Users u ON u.UserId = s.AssignedUserId
    CROSS APPLY (
        SELECT TOP (1) lp.Latitude, lp.Longitude, lp.AccuracyMeters, lp.RecordedUtc
        FROM dbo.LocationPings lp
        WHERE lp.ScheduleId = s.ScheduleId
        ORDER BY lp.RecordedUtc DESC
    ) p
    WHERE EXISTS (
        SELECT 1 FROM dbo.TimeEntries te
        WHERE te.ScheduleId = s.ScheduleId AND te.ClockOutUtc IS NULL
    )
    AND (@UserId IS NULL OR s.AssignedUserId = @UserId)
    ORDER BY p.RecordedUtc DESC;
END
