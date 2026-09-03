/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-09-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

/* ------------------------------ UserProfiles ----------------------------- */
CREATE   PROCEDURE dbo.usp_UserProfile_Get
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT p.UserId, p.AddressLine1, p.AddressLine2, p.City, p.State, p.PostalCode, p.Country,
           p.DateOfBirth, p.Gender, p.Qualifications, p.YearsOfExperience, p.About,
           p.HasDrivingLicense, p.HasVehicle, p.EmergencyContactName, p.EmergencyContactPhone,
           p.HireDate, p.ApplicationId, p.CreatedOn, p.UpdatedOn
    FROM dbo.UserProfiles p
    WHERE p.UserId = @UserId;
END
