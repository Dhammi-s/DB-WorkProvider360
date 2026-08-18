/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


CREATE   PROCEDURE dbo.usp_Announcement_GetAll
AS
BEGIN
    SET NOCOUNT ON;
    SELECT AnnouncementId, Title, Message, IsActive, CreatedByUserId, CreatedOn
    FROM dbo.Announcement
    ORDER BY CreatedOn DESC;
END
