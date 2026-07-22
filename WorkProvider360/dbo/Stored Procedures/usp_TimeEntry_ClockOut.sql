
CREATE   PROCEDURE dbo.usp_TimeEntry_ClockOut
    @ScheduleId INT,
    @UserId     INT
AS
BEGIN
    SET NOCOUNT ON;
    /* Close the most recent still-open timer for this user + schedule. */
    UPDATE te
    SET te.ClockOutUtc = SYSUTCDATETIME(),
        te.UpdatedOn = SYSUTCDATETIME()
    FROM dbo.TimeEntries te
    INNER JOIN (
        SELECT TOP (1) TimeEntryId
        FROM dbo.TimeEntries
        WHERE ScheduleId = @ScheduleId AND UserId = @UserId AND ClockOutUtc IS NULL
        ORDER BY ClockInUtc DESC
    ) open_entry ON open_entry.TimeEntryId = te.TimeEntryId;

    SELECT @@ROWCOUNT;
END
