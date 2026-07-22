
/* RoleId is supplied by the caller (roles are static, not IDENTITY). */
CREATE   PROCEDURE dbo.usp_Role_Create
    @RoleId   INT,
    @RoleName NVARCHAR(50),
    @IsActive BIT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.Roles (RoleId, RoleName, IsActive)
    VALUES (@RoleId, @RoleName, @IsActive);

    SELECT @RoleId;   -- echo the id back
END
