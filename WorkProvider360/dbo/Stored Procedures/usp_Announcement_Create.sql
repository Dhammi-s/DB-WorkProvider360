/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


CREATE   PROCEDURE dbo.usp_Announcement_Create
    @Title           NVARCHAR(200),
    @Message         NVARCHAR(MAX),
    @CreatedByUserId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @NewId UNIQUEIDENTIFIER = NEWID();

    INSERT INTO dbo.Announcement (AnnouncementId, Title, Message, IsActive, CreatedByUserId)
    VALUES (@NewId, @Title, @Message, 1, @CreatedByUserId);

    SELECT @NewId;
END
