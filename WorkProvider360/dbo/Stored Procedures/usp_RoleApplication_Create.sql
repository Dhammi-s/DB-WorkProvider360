/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


/* --------------------------- RoleApplications ---------------------------- */
CREATE   PROCEDURE dbo.usp_RoleApplication_Create
    @FullName        NVARCHAR(200),
    @Email           NVARCHAR(256),
    @Phone           NVARCHAR(50)  = NULL,
    @Address         NVARCHAR(500) = NULL,
    @RequestedRoleId INT,
    @DesiredSalary   DECIMAL(10,2) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.RoleApplications (FullName, Email, Phone, Address, RequestedRoleId, DesiredSalary, Status)
    VALUES (@FullName, @Email, @Phone, @Address, @RequestedRoleId, @DesiredSalary, N'Pending');

    SELECT CAST(SCOPE_IDENTITY() AS INT);
END
