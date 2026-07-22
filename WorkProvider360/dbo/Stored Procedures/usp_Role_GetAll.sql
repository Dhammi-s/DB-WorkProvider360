
/* ------------------------------- Roles ----------------------------------- */
CREATE   PROCEDURE dbo.usp_Role_GetAll
AS
BEGIN
    SET NOCOUNT ON;
    SELECT RoleId, RoleName, IsActive FROM dbo.Roles ORDER BY RoleId;
END
