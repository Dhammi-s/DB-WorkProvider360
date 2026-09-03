/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-09-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE   PROCEDURE dbo.usp_ApplicationAvailability_GetByApplication
    @ApplicationId INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT AvailabilityId, ApplicationId, DayOfWeek, StartTime, EndTime
    FROM dbo.ApplicationAvailability
    WHERE ApplicationId = @ApplicationId
    ORDER BY DayOfWeek, StartTime;
END
