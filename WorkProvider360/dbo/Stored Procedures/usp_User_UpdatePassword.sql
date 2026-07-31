/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


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
