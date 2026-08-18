/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE   PROCEDURE dbo.usp_ChatMessage_ClearByUser
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;
    DELETE FROM dbo.ChatMessages WHERE UserId = @UserId;
END
