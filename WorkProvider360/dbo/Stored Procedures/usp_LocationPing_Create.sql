/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


/* =============================== PROCEDURES ================================= */

CREATE   PROCEDURE dbo.usp_LocationPing_Create
    @ScheduleId     INT,
    @UserId         INT,
    @Latitude       DECIMAL(9,6),
    @Longitude      DECIMAL(9,6),
    @AccuracyMeters DECIMAL(9,2) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.LocationPings (ScheduleId, UserId, Latitude, Longitude, AccuracyMeters)
    VALUES (@ScheduleId, @UserId, @Latitude, @Longitude, @AccuracyMeters);

    SELECT CAST(SCOPE_IDENTITY() AS BIGINT);
END
