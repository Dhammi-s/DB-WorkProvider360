
CREATE   PROCEDURE dbo.usp_User_Create
    @Email        NVARCHAR(256),
    @FullName     NVARCHAR(200),
    @PasswordHash NVARCHAR(200),
    @PasswordSalt NVARCHAR(100),
    @RoleId       INT,
    @IsActive     BIT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.Users (Email, FullName, PasswordHash, PasswordSalt, RoleId, IsActive)
    VALUES (@Email, @FullName, @PasswordHash, @PasswordSalt, @RoleId, @IsActive);

    SELECT CAST(SCOPE_IDENTITY() AS INT);   -- new UserId
END
