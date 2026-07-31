/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


CREATE   PROCEDURE dbo.usp_TimeEntry_GetOpen
    @ScheduleId INT,
    @UserId     INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT TOP (1) TimeEntryId, ScheduleId, UserId, ClockInUtc, ClockOutUtc, Source, Note, CreatedOn, UpdatedOn
    FROM dbo.TimeEntries
    WHERE ScheduleId = @ScheduleId AND UserId = @UserId AND ClockOutUtc IS NULL
    ORDER BY ClockInUtc DESC;
END
