/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

/* --------------------------- RoleApplications ---------------------------- */
CREATE   PROCEDURE dbo.usp_RoleApplication_Create
    @FullName          NVARCHAR(200),
    @Email             NVARCHAR(256),
    @Phone             NVARCHAR(50)   = NULL,
    @Address           NVARCHAR(500)  = NULL,
    @City              NVARCHAR(100)  = NULL,
    @State             NVARCHAR(100)  = NULL,
    @PostalCode        NVARCHAR(20)   = NULL,
    @DateOfBirth       DATE           = NULL,
    @Gender            NVARCHAR(20)   = NULL,
    @Qualifications    NVARCHAR(MAX)  = NULL,
    @YearsOfExperience DECIMAL(4,1)   = NULL,
    @About             NVARCHAR(2000) = NULL,
    @HasDrivingLicense BIT            = NULL,
    @HasVehicle        BIT            = NULL,
    @RequestedRoleId   INT,
    @DesiredSalary     DECIMAL(10,2)  = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.RoleApplications
        (FullName, Email, Phone, Address, City, State, PostalCode, DateOfBirth, Gender,
         Qualifications, YearsOfExperience, About, HasDrivingLicense, HasVehicle,
         RequestedRoleId, DesiredSalary, Status)
    VALUES
        (@FullName, @Email, @Phone, @Address, @City, @State, @PostalCode, @DateOfBirth, @Gender,
         @Qualifications, @YearsOfExperience, @About, @HasDrivingLicense, @HasVehicle,
         @RequestedRoleId, @DesiredSalary, N'Pending');

    SELECT CAST(SCOPE_IDENTITY() AS INT);
END
