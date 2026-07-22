
/* Full breadcrumb trail for one schedule, oldest first. */
CREATE   PROCEDURE dbo.usp_LocationPing_GetTrail
    @ScheduleId INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT p.PingId, p.ScheduleId, p.UserId, u.FullName AS UserName,
           p.Latitude, p.Longitude, p.AccuracyMeters, p.RecordedUtc
    FROM dbo.LocationPings p
    INNER JOIN dbo.Users u ON u.UserId = p.UserId
    WHERE p.ScheduleId = @ScheduleId
    ORDER BY p.RecordedUtc;
END
