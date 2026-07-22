
CREATE   PROCEDURE dbo.usp_Schedule_GetById
    @ScheduleId INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT
        s.ScheduleId, s.Title, s.CustomerName, s.Location,
        s.AssignedUserId, u.FullName AS AssignedUserName,
        s.StartUtc, s.EndUtc, s.PayRatePerHour, s.OvertimeMultiplier,
        s.Status, s.RejectionReason, s.ColorTag,
        s.CreatedByUserId, s.CreatedOn, s.UpdatedOn
    FROM dbo.Schedules s
    INNER JOIN dbo.Users u ON u.UserId = s.AssignedUserId
    WHERE s.ScheduleId = @ScheduleId;
END
