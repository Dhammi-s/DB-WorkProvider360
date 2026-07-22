
/* --------------------------------- Report -------------------------------- */
/* One row per schedule in range, with total COMPLETED worked seconds. The BLL
   layer computes regular vs overtime hours and earnings from these rows. */
CREATE   PROCEDURE dbo.usp_Schedule_GetReport
    @FromUtc        DATETIME2(7),
    @ToUtc          DATETIME2(7),
    @AssignedUserId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT
        s.ScheduleId,
        s.Title,
        s.AssignedUserId,
        u.FullName AS AssignedUserName,
        s.StartUtc,
        s.EndUtc,
        s.PayRatePerHour,
        s.OvertimeMultiplier,
        s.Status,
        ISNULL((
            SELECT SUM(DATEDIFF(SECOND, te.ClockInUtc, te.ClockOutUtc))
            FROM dbo.TimeEntries te
            WHERE te.ScheduleId = s.ScheduleId AND te.ClockOutUtc IS NOT NULL
        ), 0) AS WorkedSeconds
    FROM dbo.Schedules s
    INNER JOIN dbo.Users u ON u.UserId = s.AssignedUserId
    WHERE s.StartUtc >= @FromUtc
      AND s.StartUtc <  @ToUtc
      AND (@AssignedUserId IS NULL OR s.AssignedUserId = @AssignedUserId)
    ORDER BY u.FullName, s.StartUtc;
END
