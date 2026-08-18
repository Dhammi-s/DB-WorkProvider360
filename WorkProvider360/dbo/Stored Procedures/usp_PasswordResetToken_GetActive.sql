/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


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
