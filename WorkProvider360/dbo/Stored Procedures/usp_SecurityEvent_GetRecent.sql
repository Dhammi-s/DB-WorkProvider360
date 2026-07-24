
CREATE   PROCEDURE dbo.usp_SecurityEvent_GetRecent
    @Take INT = 200
AS
BEGIN
    SET NOCOUNT ON;
    SELECT TOP (@Take)
        SecurityEventId, EventType, Email, UserId, IpAddress, UserAgent, Path, Detail, CreatedOn
    FROM dbo.SecurityEvents
    ORDER BY CreatedOn DESC;
END
