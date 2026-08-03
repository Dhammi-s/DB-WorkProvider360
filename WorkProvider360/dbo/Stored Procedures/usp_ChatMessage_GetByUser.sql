/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

/* The most recent @Take messages for a user, returned oldest-first for display. */
CREATE   PROCEDURE dbo.usp_ChatMessage_GetByUser
    @UserId INT,
    @Take   INT = 200
AS
BEGIN
    SET NOCOUNT ON;
    IF @Take < 1 SET @Take = 200;

    SELECT ChatMessageId, UserId, Role, Content, CreatedOn
    FROM (
        SELECT TOP (@Take) ChatMessageId, UserId, Role, Content, CreatedOn
        FROM dbo.ChatMessages
        WHERE UserId = @UserId
        ORDER BY CreatedOn DESC, ChatMessageId DESC
    ) t
    ORDER BY CreatedOn ASC, ChatMessageId ASC;
END
