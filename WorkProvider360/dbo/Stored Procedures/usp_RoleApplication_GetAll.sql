
CREATE   PROCEDURE dbo.usp_RoleApplication_GetAll
    @Status NVARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT
        a.ApplicationId, a.FullName, a.Email, a.Phone, a.Address,
        a.RequestedRoleId, r.RoleName AS RequestedRoleName,
        a.Status, a.RejectionReason, a.ReviewedByUserId, a.ReviewedOn, a.CreatedOn
    FROM dbo.RoleApplications a
    INNER JOIN dbo.Roles r ON r.RoleId = a.RequestedRoleId
    WHERE (@Status IS NULL OR a.Status = @Status)
    ORDER BY a.CreatedOn DESC;
END
