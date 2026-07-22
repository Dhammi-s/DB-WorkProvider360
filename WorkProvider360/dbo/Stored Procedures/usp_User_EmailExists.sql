
CREATE   PROCEDURE dbo.usp_User_EmailExists
    @Email NVARCHAR(256)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT COUNT(1) FROM dbo.Users WHERE Email = @Email;
END
