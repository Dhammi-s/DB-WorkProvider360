
CREATE   PROCEDURE dbo.usp_RefreshToken_GetActive
    @UserId INT,
    @Token  NVARCHAR(200)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT RefreshTokenId, UserId, Token, ExpiresOn, IsRevoked, CreatedOn
    FROM dbo.RefreshTokens
    WHERE UserId = @UserId
      AND Token = @Token
      AND IsRevoked = 0
      AND ExpiresOn > SYSUTCDATETIME();
END
