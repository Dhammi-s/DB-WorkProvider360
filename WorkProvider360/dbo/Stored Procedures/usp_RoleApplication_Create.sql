
/* --------------------------- RoleApplications ---------------------------- */
CREATE   PROCEDURE dbo.usp_RoleApplication_Create
    @FullName        NVARCHAR(200),
    @Email           NVARCHAR(256),
    @Phone           NVARCHAR(50)  = NULL,
    @Address         NVARCHAR(500) = NULL,
    @RequestedRoleId INT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.RoleApplications (FullName, Email, Phone, Address, RequestedRoleId, Status)
    VALUES (@FullName, @Email, @Phone, @Address, @RequestedRoleId, N'Pending');

    SELECT CAST(SCOPE_IDENTITY() AS INT);
END
