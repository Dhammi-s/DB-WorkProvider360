
/* ------------------------------- Users ----------------------------------- */
CREATE   PROCEDURE dbo.usp_User_GetByEmail
    @Email NVARCHAR(256)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT
        u.UserId, u.Email, u.FullName, u.PasswordHash, u.PasswordSalt,
        u.RoleId, r.RoleName, u.IsActive, u.CreatedOn, u.UpdatedOn
    FROM dbo.Users u
    INNER JOIN dbo.Roles r ON r.RoleId = u.RoleId
    WHERE u.Email = @Email;
END
