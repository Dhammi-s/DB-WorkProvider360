/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-09-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE   PROCEDURE dbo.usp_Client_GetById
    @ClientId INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT
        c.ClientId, c.UserId, c.OfficeId, o.OfficeName,
        c.FirstName, c.LastName, c.Email, c.Phone, c.AlternatePhone, c.DateOfBirth, c.Gender,
        c.AddressLine1, c.AddressLine2, c.City, c.State, c.PostalCode, c.Country, c.Latitude, c.Longitude,
        c.EmergencyContactName, c.EmergencyContactPhone, c.EmergencyContactRelation,
        c.PreferredLanguage, c.AccessInstructions, c.CareNotes, c.Allergies, c.MobilityNotes,
        c.PortalEnabled, c.Status, c.StartDate, c.Notes, c.CreatedByUserId, c.CreatedOn, c.UpdatedOn,
        u.Email AS PortalEmail, u.IsActive AS PortalIsActive, u.IsLockedOut AS PortalIsLockedOut,
        (SELECT STRING_AGG(st.Name, N', ') WITHIN GROUP (ORDER BY st.SortOrder, st.Name)
           FROM dbo.ClientServiceTypes cst
           INNER JOIN dbo.ServiceTypes st ON st.ServiceTypeId = cst.ServiceTypeId
          WHERE cst.ClientId = c.ClientId) AS ServiceTypeNames
    FROM dbo.Clients c
    LEFT JOIN dbo.Office o ON o.OfficeId = c.OfficeId
    LEFT JOIN dbo.Users  u ON u.UserId   = c.UserId
    WHERE c.ClientId = @ClientId;
END
