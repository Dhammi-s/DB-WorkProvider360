
CREATE   PROCEDURE dbo.usp_RefreshToken_Revoke
    @RefreshTokenId BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.RefreshTokens SET IsRevoked = 1 WHERE RefreshTokenId = @RefreshTokenId;
END
