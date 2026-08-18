/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


/* ------------------------------- Users ----------------------------------- */
CREATE   PROCEDURE dbo.usp_User_GetByEmail
    @Email NVARCHAR(256)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT
        u.UserId, u.Email, u.FullName, u.PasswordHash, u.PasswordSalt,
        u.RoleId, r.RoleName, u.Phone, u.AvatarUrl, u.IsActive,
        u.AccessFailedCount, u.IsLockedOut, u.CreatedOn, u.UpdatedOn
    FROM dbo.Users u
    INNER JOIN dbo.Roles r ON r.RoleId = u.RoleId
    WHERE u.Email = @Email;
END
