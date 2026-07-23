
CREATE   PROCEDURE dbo.usp_Announcement_GetActive
AS
BEGIN
    SET NOCOUNT ON;
    SELECT AnnouncementId, Title, Message, IsActive, CreatedByUserId, CreatedOn
    FROM dbo.Announcement
    WHERE IsActive = 1
    ORDER BY CreatedOn DESC;
END
