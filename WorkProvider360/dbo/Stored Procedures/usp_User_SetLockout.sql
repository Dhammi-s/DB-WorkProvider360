/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-08-04
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


/* -----------------------------------------------------------------------------
   Manually locks or unlocks a user (used by the admin "Unlock account" action).
   Unlocking also clears the failed-attempt counter so the user gets a fresh set
   of attempts.
   ----------------------------------------------------------------------------- */
CREATE   PROCEDURE dbo.usp_User_SetLockout
    @UserId      INT,
    @IsLockedOut BIT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.Users
    SET IsLockedOut = @IsLockedOut,
        AccessFailedCount = CASE WHEN @IsLockedOut = 0 THEN 0 ELSE AccessFailedCount END,
        UpdatedOn = SYSUTCDATETIME()
    WHERE UserId = @UserId;
END
