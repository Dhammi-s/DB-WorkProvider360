
/* ------------------------------ TimeEntries ------------------------------ */
CREATE   PROCEDURE dbo.usp_TimeEntry_ClockIn
    @ScheduleId INT,
    @UserId     INT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.TimeEntries (ScheduleId, UserId, ClockInUtc, Source)
    VALUES (@ScheduleId, @UserId, SYSUTCDATETIME(), N'Timer');

    SELECT CAST(SCOPE_IDENTITY() AS INT);
END
