/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


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
