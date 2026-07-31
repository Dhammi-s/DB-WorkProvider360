/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


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
