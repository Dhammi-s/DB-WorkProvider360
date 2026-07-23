
CREATE   PROCEDURE dbo.usp_Announcement_GetAll
AS
BEGIN
    SET NOCOUNT ON;
    SELECT AnnouncementId, Title, Message, IsActive, CreatedByUserId, CreatedOn
    FROM dbo.Announcement
    ORDER BY CreatedOn DESC;
END
