
CREATE   PROCEDURE dbo.usp_SecurityEvent_GetTypeCounts
AS
BEGIN
    SET NOCOUNT ON;
    SELECT EventType, COUNT(*) AS [Count]
    FROM dbo.SecurityEvents
    GROUP BY EventType
    ORDER BY [Count] DESC;
END
