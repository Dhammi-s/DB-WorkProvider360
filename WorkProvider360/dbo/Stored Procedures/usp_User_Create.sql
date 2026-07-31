/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


CREATE   PROCEDURE dbo.usp_User_Create
    @Email        NVARCHAR(256),
    @FullName     NVARCHAR(200),
    @PasswordHash NVARCHAR(200),
    @PasswordSalt NVARCHAR(100),
    @RoleId       INT,
    @IsActive     BIT,
    @OfficeId     UNIQUEIDENTIFIER = NULL,
    @Salary       DECIMAL(10,2)    = NULL,
    @Phone        NVARCHAR(30)     = NULL
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.Users (Email, FullName, PasswordHash, PasswordSalt, RoleId, IsActive, OfficeId, Salary, Phone)
    VALUES (@Email, @FullName, @PasswordHash, @PasswordSalt, @RoleId, @IsActive, @OfficeId, @Salary, @Phone);

    SELECT CAST(SCOPE_IDENTITY() AS INT);   -- new UserId
END
