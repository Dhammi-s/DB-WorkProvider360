
CREATE   PROCEDURE dbo.usp_PasswordResetToken_GetActive
    @UserId INT,
    @Token  NVARCHAR(200)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT PasswordResetTokenId, UserId, Token, ExpiresOn, IsUsed, CreatedOn
    FROM dbo.PasswordResetTokens
    WHERE UserId = @UserId
      AND Token = @Token
      AND IsUsed = 0
      AND ExpiresOn > SYSUTCDATETIME();
END
