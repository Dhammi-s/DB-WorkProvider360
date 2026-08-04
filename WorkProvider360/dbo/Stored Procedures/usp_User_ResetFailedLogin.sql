/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-08-04
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


/* -----------------------------------------------------------------------------
   Clears the failed-attempt counter after a successful sign-in. Does not touch
   IsLockedOut (a locked account never reaches a successful verify).
   ----------------------------------------------------------------------------- */
CREATE   PROCEDURE dbo.usp_User_ResetFailedLogin
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.Users
    SET AccessFailedCount = 0
    WHERE UserId = @UserId
      AND AccessFailedCount <> 0;
END
