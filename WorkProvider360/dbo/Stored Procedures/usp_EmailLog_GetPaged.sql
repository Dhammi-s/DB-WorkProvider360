
CREATE   PROCEDURE dbo.usp_EmailLog_GetPaged
    @Page     INT = 1,
    @PageSize INT = 10
AS
BEGIN
    SET NOCOUNT ON;

    IF @Page < 1 SET @Page = 1;
    IF @PageSize < 1 SET @PageSize = 10;

    SELECT EmailLogId, ToAddress, Subject, Body, Status, ErrorMessage, CreatedOn
    FROM dbo.EmailLog
    ORDER BY CreatedOn DESC
    OFFSET (@Page - 1) * @PageSize ROWS FETCH NEXT @PageSize ROWS ONLY;

    SELECT COUNT(*) AS Total FROM dbo.EmailLog;
END
