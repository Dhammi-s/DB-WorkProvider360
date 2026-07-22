
CREATE   PROCEDURE dbo.usp_TimeEntry_GetOpen
    @ScheduleId INT,
    @UserId     INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT TOP (1) TimeEntryId, ScheduleId, UserId, ClockInUtc, ClockOutUtc, Source, Note, CreatedOn, UpdatedOn
    FROM dbo.TimeEntries
    WHERE ScheduleId = @ScheduleId AND UserId = @UserId AND ClockOutUtc IS NULL
    ORDER BY ClockInUtc DESC;
END
