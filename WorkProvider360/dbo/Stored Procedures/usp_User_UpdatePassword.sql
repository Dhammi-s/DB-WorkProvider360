
CREATE   PROCEDURE dbo.usp_User_UpdatePassword
    @UserId       INT,
    @PasswordHash NVARCHAR(200),
    @PasswordSalt NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.Users
        SET PasswordHash = @PasswordHash,
            PasswordSalt = @PasswordSalt,
            UpdatedOn    = SYSUTCDATETIME()
    WHERE UserId = @UserId;
END
