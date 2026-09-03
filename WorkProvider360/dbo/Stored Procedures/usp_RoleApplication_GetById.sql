/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE   PROCEDURE dbo.usp_RoleApplication_GetById
    @ApplicationId INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT
        a.ApplicationId, a.FullName, a.Email, a.Phone, a.Address,
        a.City, a.State, a.PostalCode, a.DateOfBirth, a.Gender,
        a.Qualifications, a.YearsOfExperience, a.About, a.HasDrivingLicense, a.HasVehicle,
        a.RequestedRoleId, r.RoleName AS RequestedRoleName, a.DesiredSalary,
        a.Status, a.RejectionReason, a.ReviewedByUserId, a.ReviewedOn, a.CreatedOn
    FROM dbo.RoleApplications a
    INNER JOIN dbo.Roles r ON r.RoleId = a.RequestedRoleId
    WHERE a.ApplicationId = @ApplicationId;
END
