
CREATE   PROCEDURE dbo.usp_TimeEntry_GetBySchedule
    @ScheduleId INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT te.TimeEntryId, te.ScheduleId, te.UserId, u.FullName AS UserName,
           te.ClockInUtc, te.ClockOutUtc, te.Source, te.Note, te.CreatedOn, te.UpdatedOn
    FROM dbo.TimeEntries te
    INNER JOIN dbo.Users u ON u.UserId = te.UserId
    WHERE te.ScheduleId = @ScheduleId
    ORDER BY te.ClockInUtc;
END
