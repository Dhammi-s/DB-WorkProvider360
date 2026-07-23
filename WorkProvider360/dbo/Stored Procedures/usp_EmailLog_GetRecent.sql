
CREATE   PROCEDURE dbo.usp_EmailLog_GetRecent
    @Top INT = 200
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (@Top)
        EmailLogId,
        ToAddress,
        Subject,
        Body,
        Status,
        ErrorMessage,
        CreatedOn
    FROM dbo.EmailLog
    ORDER BY CreatedOn DESC;
END
