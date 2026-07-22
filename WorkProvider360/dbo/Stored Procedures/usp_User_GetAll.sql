
CREATE   PROCEDURE dbo.usp_User_GetAll
AS
BEGIN
    SET NOCOUNT ON;
    SELECT
        u.UserId, u.Email, u.FullName, u.PasswordHash, u.PasswordSalt,
        u.RoleId, r.RoleName, u.IsActive, u.CreatedOn, u.UpdatedOn
    FROM dbo.Users u
    INNER JOIN dbo.Roles r ON r.RoleId = u.RoleId
    ORDER BY u.UserId;
END
