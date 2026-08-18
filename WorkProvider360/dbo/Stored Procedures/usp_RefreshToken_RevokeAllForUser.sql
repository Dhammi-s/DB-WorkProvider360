/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

--make by jasmeet singh
CREATE   PROCEDURE dbo.usp_RefreshToken_RevokeAllForUser
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.RefreshTokens SET IsRevoked = 1 WHERE UserId = @UserId AND IsRevoked = 0;
END
