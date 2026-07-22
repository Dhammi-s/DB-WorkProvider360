
CREATE   PROCEDURE dbo.usp_Schedule_Delete
    @ScheduleId INT
AS
BEGIN
    SET NOCOUNT ON;
    DELETE FROM dbo.TimeEntries   WHERE ScheduleId = @ScheduleId;
    DELETE FROM dbo.ScheduleNotes WHERE ScheduleId = @ScheduleId;
    DELETE FROM dbo.Schedules     WHERE ScheduleId = @ScheduleId;
END
