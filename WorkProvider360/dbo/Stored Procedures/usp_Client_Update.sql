/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-09-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

/* Profile update. Status, portal login and PortalEnabled have their own procs. */
CREATE   PROCEDURE dbo.usp_Client_Update
    @ClientId                 INT,
    @OfficeId                 UNIQUEIDENTIFIER = NULL,
    @FirstName                NVARCHAR(100),
    @LastName                 NVARCHAR(100),
    @Email                    NVARCHAR(256)  = NULL,
    @Phone                    NVARCHAR(30)   = NULL,
    @AlternatePhone           NVARCHAR(30)   = NULL,
    @DateOfBirth              DATE           = NULL,
    @Gender                   NVARCHAR(20)   = NULL,
    @AddressLine1             NVARCHAR(200),
    @AddressLine2             NVARCHAR(200)  = NULL,
    @City                     NVARCHAR(100)  = NULL,
    @State                    NVARCHAR(100)  = NULL,
    @PostalCode               NVARCHAR(20)   = NULL,
    @Country                  NVARCHAR(100)  = NULL,
    @Latitude                 DECIMAL(9,6)   = NULL,
    @Longitude                DECIMAL(9,6)   = NULL,
    @EmergencyContactName     NVARCHAR(200)  = NULL,
    @EmergencyContactPhone    NVARCHAR(30)   = NULL,
    @EmergencyContactRelation NVARCHAR(50)   = NULL,
    @PreferredLanguage        NVARCHAR(50)   = NULL,
    @AccessInstructions       NVARCHAR(1000) = NULL,
    @CareNotes                NVARCHAR(MAX)  = NULL,
    @Allergies                NVARCHAR(500)  = NULL,
    @MobilityNotes            NVARCHAR(500)  = NULL,
    @StartDate                DATE           = NULL,
    @Notes                    NVARCHAR(2000) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.Clients
    SET OfficeId                 = @OfficeId,
        FirstName                = @FirstName,
        LastName                 = @LastName,
        Email                    = @Email,
        Phone                    = @Phone,
        AlternatePhone           = @AlternatePhone,
        DateOfBirth              = @DateOfBirth,
        Gender                   = @Gender,
        AddressLine1             = @AddressLine1,
        AddressLine2             = @AddressLine2,
        City                     = @City,
        State                    = @State,
        PostalCode               = @PostalCode,
        Country                  = @Country,
        Latitude                 = @Latitude,
        Longitude                = @Longitude,
        EmergencyContactName     = @EmergencyContactName,
        EmergencyContactPhone    = @EmergencyContactPhone,
        EmergencyContactRelation = @EmergencyContactRelation,
        PreferredLanguage        = @PreferredLanguage,
        AccessInstructions       = @AccessInstructions,
        CareNotes                = @CareNotes,
        Allergies                = @Allergies,
        MobilityNotes            = @MobilityNotes,
        StartDate                = @StartDate,
        Notes                    = @Notes,
        UpdatedOn                = SYSUTCDATETIME()
    WHERE ClientId = @ClientId;
END
