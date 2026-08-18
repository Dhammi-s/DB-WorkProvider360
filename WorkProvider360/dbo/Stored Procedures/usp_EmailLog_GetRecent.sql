/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


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
