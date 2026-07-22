
CREATE   PROCEDURE dbo.usp_Role_NameExists
    @RoleName NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT COUNT(1) FROM dbo.Roles WHERE RoleName = @RoleName;
END
