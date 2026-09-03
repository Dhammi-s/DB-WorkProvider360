/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-09-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

/* Visits for one client (portal + client detail), newest first, with the
   assigned team member, service, actual clock times, worked seconds and
   whether a clock-out signature exists. */
CREATE   PROCEDURE dbo.usp_Schedule_GetByClient
    @ClientId INT,
    @FromUtc  DATETIME2(7) = NULL,
    @ToUtc    DATETIME2(7) = NULL,
    @Status   NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT
        s.ScheduleId, s.Title, s.ClientId, s.ServiceTypeId, st.Name AS ServiceTypeName,
        s.AssignedUserId, u.FullName AS AssignedUserName, u.AvatarUrl AS AssignedUserAvatarUrl,
        s.Location, s.StartUtc, s.EndUtc, s.Status,
        te.ClockInUtc, te.ClockOutUtc,
        CAST(ISNULL(te.WorkedSeconds, 0) AS BIGINT) AS WorkedSeconds,
        CAST(CASE WHEN EXISTS (SELECT 1
                               FROM dbo.TimeEntrySignatures x
                               INNER JOIN dbo.TimeEntries t2 ON t2.TimeEntryId = x.TimeEntryId
                               WHERE t2.ScheduleId = s.ScheduleId AND x.Phase = N'ClockOut')
                  THEN 1 ELSE 0 END AS BIT) AS HasClockOutSignature
    FROM dbo.Schedules s
    INNER JOIN dbo.Users u ON u.UserId = s.AssignedUserId
    LEFT JOIN dbo.ServiceTypes st ON st.ServiceTypeId = s.ServiceTypeId
    OUTER APPLY (SELECT MIN(t.ClockInUtc)  AS ClockInUtc,
                        MAX(t.ClockOutUtc) AS ClockOutUtc,
                        SUM(DATEDIFF(SECOND, t.ClockInUtc, ISNULL(t.ClockOutUtc, t.ClockInUtc))) AS WorkedSeconds
                 FROM dbo.TimeEntries t
                 WHERE t.ScheduleId = s.ScheduleId) te
    WHERE s.ClientId = @ClientId
      AND (@FromUtc IS NULL OR s.EndUtc   >= @FromUtc)
      AND (@ToUtc   IS NULL OR s.StartUtc <  @ToUtc)
      AND (@Status  IS NULL OR s.Status = @Status)
    ORDER BY s.StartUtc DESC;
END
