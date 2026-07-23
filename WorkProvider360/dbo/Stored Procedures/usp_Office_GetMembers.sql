
CREATE   PROCEDURE dbo.usp_Office_GetMembers
    @OfficeId UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        u.UserId,
        u.Email,
        u.FullName,
        u.RoleId,
        r.RoleName,
        u.IsActive
    FROM dbo.Users u
    INNER JOIN dbo.Roles r ON r.RoleId = u.RoleId
    WHERE u.OfficeId = @OfficeId
    ORDER BY u.RoleId, u.FullName;
END
