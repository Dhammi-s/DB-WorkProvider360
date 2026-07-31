
CREATE   PROCEDURE dbo.usp_User_UpdateAvatar
    @UserId    INT,
    @AvatarUrl NVARCHAR(500)
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.Users
    SET AvatarUrl = @AvatarUrl,
        UpdatedOn = SYSUTCDATETIME()
    WHERE UserId = @UserId;
END
