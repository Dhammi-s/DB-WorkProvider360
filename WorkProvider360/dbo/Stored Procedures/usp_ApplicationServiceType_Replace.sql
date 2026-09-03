/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-09-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

/* --------------------------- ApplicationServiceTypes --------------------- */
CREATE   PROCEDURE dbo.usp_ApplicationServiceType_Replace
    @ApplicationId      INT,
    @ServiceTypeIdsJson NVARCHAR(MAX) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRANSACTION;

    DELETE FROM dbo.ApplicationServiceTypes WHERE ApplicationId = @ApplicationId;

    INSERT INTO dbo.ApplicationServiceTypes (ApplicationId, ServiceTypeId)
    SELECT DISTINCT @ApplicationId, CAST(j.[value] AS INT)
    FROM OPENJSON(ISNULL(@ServiceTypeIdsJson, N'[]')) j
    WHERE TRY_CAST(j.[value] AS INT) IS NOT NULL
      AND EXISTS (SELECT 1 FROM dbo.ServiceTypes st WHERE st.ServiceTypeId = CAST(j.[value] AS INT));

    COMMIT TRANSACTION;
END
