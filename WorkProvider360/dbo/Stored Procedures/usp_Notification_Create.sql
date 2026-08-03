/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-08-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE   PROCEDURE dbo.usp_Notification_Create
    @UserId          INT,
    @Title           NVARCHAR(150) = NULL,
    @Message         NVARCHAR(1000),
    @CreatedByUserId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.Notifications (UserId, Title, Message, CreatedByUserId)
    VALUES (@UserId, @Title, @Message, @CreatedByUserId);
END
