/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


/* Resolve a tenant by domain. The application sends a normalized host such as
   "yourdomain.com"; this proc strips scheme/slashes from the stored DomainUrl
   so it matches regardless of how the URL was saved. */
CREATE   PROCEDURE dbo.usp_Agency_GetByDomain
    @DomainUrl NVARCHAR(256)
   --jassa
   --testdeploy
AS
   hfsghghd
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (1)
        AgencyId, AgencyName, DomainUrl, Location, DbServer, DbName, DbUser,
        DbPassword, ConnectionString, IsActive, IsArchived, CreatedOn, UpdatedOn
    FROM dbo.Agencies
    WHERE IsActive = 1
      AND IsArchived = 0
      AND REPLACE(REPLACE(REPLACE(REPLACE(DomainUrl,
              'https://', ''), 'http://', ''), '/', ''), ' ', '') = @DomainUrl;
END
