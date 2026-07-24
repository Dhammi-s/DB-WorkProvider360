
/* Per-account login tallies: successful vs failed attempts. */
CREATE   PROCEDURE dbo.usp_SecurityEvent_GetLoginStats
AS
BEGIN
    SET NOCOUNT ON;
    SELECT
        ISNULL(Email, N'(unknown)') AS Email,
        SUM(CASE WHEN EventType = N'LoginSuccess' THEN 1 ELSE 0 END) AS SuccessCount,
        SUM(CASE WHEN EventType = N'LoginFailed'  THEN 1 ELSE 0 END) AS FailedCount
    FROM dbo.SecurityEvents
    WHERE EventType IN (N'LoginSuccess', N'LoginFailed')
    GROUP BY Email
    ORDER BY SuccessCount DESC, FailedCount DESC;
END
