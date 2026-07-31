
CREATE   PROCEDURE dbo.usp_User_GetPaged
    @Page     INT = 1,
    @PageSize INT = 10
AS
BEGIN
    SET NOCOUNT ON;

    IF @Page < 1 SET @Page = 1;
    IF @PageSize < 1 SET @PageSize = 10;

    SELECT
        u.UserId, u.Email, u.FullName, u.PasswordHash, u.PasswordSalt,
        u.RoleId, r.RoleName, u.Phone, u.OfficeId, o.OfficeName, u.Salary,
        u.IsActive, u.CreatedOn, u.UpdatedOn
    FROM dbo.Users u
    INNER JOIN dbo.Roles r ON r.RoleId = u.RoleId
    LEFT JOIN dbo.Office o ON o.OfficeId = u.OfficeId
    ORDER BY u.UserId
    OFFSET (@Page - 1) * @PageSize ROWS FETCH NEXT @PageSize ROWS ONLY;

    SELECT COUNT(*) AS Total FROM dbo.Users;
END
