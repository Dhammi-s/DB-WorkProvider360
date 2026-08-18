/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-08-04
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


/* -----------------------------------------------------------------------------
   Records one failed sign-in for a user. When the running failure count reaches
   @Threshold the account is locked — EXCEPT SuperAdmin (RoleId = 1), which is
   never locked so a tenant can always be recovered.
   ----------------------------------------------------------------------------- */
CREATE   PROCEDURE dbo.usp_User_RegisterFailedLogin
    @UserId    INT,
    @Threshold INT = 3
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.Users
    SET AccessFailedCount = AccessFailedCount + 1,
        IsLockedOut = CASE
                          WHEN RoleId <> 1 AND (AccessFailedCount + 1) >= @Threshold THEN 1
                          ELSE IsLockedOut
                      END,
        UpdatedOn = SYSUTCDATETIME()
    WHERE UserId = @UserId;
END
