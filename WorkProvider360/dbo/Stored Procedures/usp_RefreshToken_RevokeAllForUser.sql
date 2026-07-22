
CREATE   PROCEDURE dbo.usp_RefreshToken_RevokeAllForUser
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.RefreshTokens SET IsRevoked = 1 WHERE UserId = @UserId AND IsRevoked = 0;
END
