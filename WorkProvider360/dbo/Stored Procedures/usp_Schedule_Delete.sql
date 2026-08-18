/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


CREATE   PROCEDURE dbo.usp_Schedule_Delete
    @ScheduleId INT
AS
BEGIN
    SET NOCOUNT ON;
    DELETE FROM dbo.TimeEntries   WHERE ScheduleId = @ScheduleId;
    DELETE FROM dbo.ScheduleNotes WHERE ScheduleId = @ScheduleId;
    DELETE FROM dbo.Schedules     WHERE ScheduleId = @ScheduleId;
END
