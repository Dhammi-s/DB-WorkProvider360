/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-09-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

/* --------------------------- ApplicationAvailability --------------------- */
CREATE   PROCEDURE dbo.usp_ApplicationAvailability_Replace
    @ApplicationId INT,
    @SlotsJson     NVARCHAR(MAX) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRANSACTION;

    DELETE FROM dbo.ApplicationAvailability WHERE ApplicationId = @ApplicationId;

    INSERT INTO dbo.ApplicationAvailability (ApplicationId, DayOfWeek, StartTime, EndTime)
    SELECT @ApplicationId, j.DayOfWeek, j.StartTime, j.EndTime
    FROM OPENJSON(ISNULL(@SlotsJson, N'[]'))
         WITH (DayOfWeek TINYINT  '$.DayOfWeek',
               StartTime TIME(0)  '$.StartTime',
               EndTime   TIME(0)  '$.EndTime') j
    WHERE j.DayOfWeek BETWEEN 0 AND 6
      AND j.StartTime IS NOT NULL AND j.EndTime IS NOT NULL
      AND j.EndTime > j.StartTime;

    COMMIT TRANSACTION;
END
