
CREATE   PROCEDURE dbo.usp_Announcement_Deactivate
    @AnnouncementId UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.Announcement SET IsActive = 0 WHERE AnnouncementId = @AnnouncementId;
END
