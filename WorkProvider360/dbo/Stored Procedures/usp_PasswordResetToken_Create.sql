/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


/* ------------------------ PasswordResetTokens ---------------------------- */
CREATE   PROCEDURE dbo.usp_PasswordResetToken_Create
    @UserId    INT,
    @Token     NVARCHAR(200),
    @ExpiresOn DATETIME2(7)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.PasswordResetTokens (UserId, Token, ExpiresOn)
    VALUES (@UserId, @Token, @ExpiresOn);

    SELECT CAST(SCOPE_IDENTITY() AS BIGINT);
END
