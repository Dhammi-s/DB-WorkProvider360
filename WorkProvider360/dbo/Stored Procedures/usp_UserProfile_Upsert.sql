/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-09-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

/* Creates or updates the 1:1 profile row. HireDate/ApplicationId are only
   overwritten when supplied, so a later profile edit keeps them. */
CREATE   PROCEDURE dbo.usp_UserProfile_Upsert
    @UserId                INT,
    @AddressLine1          NVARCHAR(200)  = NULL,
    @AddressLine2          NVARCHAR(200)  = NULL,
    @City                  NVARCHAR(100)  = NULL,
    @State                 NVARCHAR(100)  = NULL,
    @PostalCode            NVARCHAR(20)   = NULL,
    @Country               NVARCHAR(100)  = NULL,
    @DateOfBirth           DATE           = NULL,
    @Gender                NVARCHAR(20)   = NULL,
    @Qualifications        NVARCHAR(MAX)  = NULL,
    @YearsOfExperience     DECIMAL(4,1)   = NULL,
    @About                 NVARCHAR(2000) = NULL,
    @HasDrivingLicense     BIT            = 0,
    @HasVehicle            BIT            = 0,
    @EmergencyContactName  NVARCHAR(200)  = NULL,
    @EmergencyContactPhone NVARCHAR(30)   = NULL,
    @HireDate              DATE           = NULL,
    @ApplicationId         INT            = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM dbo.UserProfiles WHERE UserId = @UserId)
    BEGIN
        UPDATE dbo.UserProfiles
        SET AddressLine1          = @AddressLine1,
            AddressLine2          = @AddressLine2,
            City                  = @City,
            State                 = @State,
            PostalCode            = @PostalCode,
            Country               = @Country,
            DateOfBirth           = @DateOfBirth,
            Gender                = @Gender,
            Qualifications        = @Qualifications,
            YearsOfExperience     = @YearsOfExperience,
            About                 = @About,
            HasDrivingLicense     = @HasDrivingLicense,
            HasVehicle            = @HasVehicle,
            EmergencyContactName  = @EmergencyContactName,
            EmergencyContactPhone = @EmergencyContactPhone,
            HireDate              = COALESCE(@HireDate, HireDate),
            ApplicationId         = COALESCE(@ApplicationId, ApplicationId),
            UpdatedOn             = SYSUTCDATETIME()
        WHERE UserId = @UserId;
    END
    ELSE
    BEGIN
        INSERT INTO dbo.UserProfiles
            (UserId, AddressLine1, AddressLine2, City, State, PostalCode, Country, DateOfBirth, Gender,
             Qualifications, YearsOfExperience, About, HasDrivingLicense, HasVehicle,
             EmergencyContactName, EmergencyContactPhone, HireDate, ApplicationId)
        VALUES
            (@UserId, @AddressLine1, @AddressLine2, @City, @State, @PostalCode, @Country, @DateOfBirth, @Gender,
             @Qualifications, @YearsOfExperience, @About, @HasDrivingLicense, @HasVehicle,
             @EmergencyContactName, @EmergencyContactPhone, @HireDate, @ApplicationId);
    END

    EXEC dbo.usp_UserProfile_Get @UserId = @UserId;
END
