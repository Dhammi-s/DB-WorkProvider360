
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
