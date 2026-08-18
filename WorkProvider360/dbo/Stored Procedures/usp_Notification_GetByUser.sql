/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-08-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

/* Most recent @Take notifications for a user, newest first (with sender name). */
CREATE   PROCEDURE dbo.usp_Notification_GetByUser
    @UserId INT,
    @Take   INT = 50
AS
BEGIN
    SET NOCOUNT ON;
    IF @Take < 1 SET @Take = 50;

    SELECT TOP (@Take)
        n.NotificationId, n.UserId, n.Title, n.Message, n.IsRead,
        n.CreatedByUserId, s.FullName AS CreatedByName, n.CreatedOn
    FROM dbo.Notifications n
    LEFT JOIN dbo.Users s ON s.UserId = n.CreatedByUserId
    WHERE n.UserId = @UserId
    ORDER BY n.CreatedOn DESC, n.NotificationId DESC;
END
