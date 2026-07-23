
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
