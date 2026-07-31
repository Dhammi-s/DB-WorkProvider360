/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


CREATE   PROCEDURE dbo.usp_RoleApplication_GetAll
    @Status NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT
        a.ApplicationId, a.FullName, a.Email, a.Phone, a.Address,
        a.RequestedRoleId, r.RoleName AS RequestedRoleName, a.DesiredSalary,
        a.Status, a.RejectionReason, a.ReviewedByUserId, a.ReviewedOn, a.CreatedOn
    FROM dbo.RoleApplications a
    INNER JOIN dbo.Roles r ON r.RoleId = a.RequestedRoleId
    WHERE (@Status IS NULL OR a.Status = @Status)
    ORDER BY a.CreatedOn DESC;
END
