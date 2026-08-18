/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


/* Resolve a tenant by its primary key (used for authenticated requests where
   the agency id travels inside the JWT). */
CREATE   PROCEDURE dbo.usp_Agency_GetById
    @AgencyId INT
   --jassa
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        AgencyId, AgencyName, DomainUrl, Location, DbServer, DbName, DbUser,
        DbPassword, ConnectionString, IsActive, IsArchived, CreatedOn, UpdatedOn
    FROM dbo.Agencies
    WHERE AgencyId = @AgencyId;
END
