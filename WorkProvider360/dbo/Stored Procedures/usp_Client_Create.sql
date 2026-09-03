/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-09-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

/* --------------------------------- Clients ------------------------------- */
CREATE   PROCEDURE dbo.usp_Client_Create
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
    @Status                   NVARCHAR(20)   = N'Active',
    @StartDate                DATE           = NULL,
    @Notes                    NVARCHAR(2000) = NULL,
    @CreatedByUserId          INT            = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.Clients
        (OfficeId, FirstName, LastName, Email, Phone, AlternatePhone, DateOfBirth, Gender,
         AddressLine1, AddressLine2, City, State, PostalCode, Country, Latitude, Longitude,
         EmergencyContactName, EmergencyContactPhone, EmergencyContactRelation, PreferredLanguage,
         AccessInstructions, CareNotes, Allergies, MobilityNotes, PortalEnabled, Status, StartDate, Notes,
         CreatedByUserId)
    VALUES
        (@OfficeId, @FirstName, @LastName, @Email, @Phone, @AlternatePhone, @DateOfBirth, @Gender,
         @AddressLine1, @AddressLine2, @City, @State, @PostalCode, @Country, @Latitude, @Longitude,
         @EmergencyContactName, @EmergencyContactPhone, @EmergencyContactRelation, @PreferredLanguage,
         @AccessInstructions, @CareNotes, @Allergies, @MobilityNotes, 0, @Status, @StartDate, @Notes,
         @CreatedByUserId);

    SELECT CAST(SCOPE_IDENTITY() AS INT);
END
