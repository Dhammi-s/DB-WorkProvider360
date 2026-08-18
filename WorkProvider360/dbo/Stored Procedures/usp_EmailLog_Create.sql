/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


CREATE   PROCEDURE dbo.usp_EmailLog_Create
    @ToAddress    NVARCHAR(256),
    @Subject      NVARCHAR(300)  = NULL,
    @Body         NVARCHAR(MAX)  = NULL,
    @Status       NVARCHAR(20),
    @ErrorMessage NVARCHAR(2000) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.EmailLog (ToAddress, Subject, Body, Status, ErrorMessage)
    VALUES (@ToAddress, @Subject, @Body, @Status, @ErrorMessage);
END
