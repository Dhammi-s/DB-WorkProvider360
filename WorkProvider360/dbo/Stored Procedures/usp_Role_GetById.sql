
CREATE   PROCEDURE dbo.usp_Role_GetById
    @RoleId INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT RoleId, RoleName, IsActive FROM dbo.Roles WHERE RoleId = @RoleId;
END
