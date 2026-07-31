/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


CREATE   PROCEDURE dbo.usp_TimeEntry_GetBySchedule
    @ScheduleId INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT te.TimeEntryId, te.ScheduleId, te.UserId, u.FullName AS UserName,
           te.ClockInUtc, te.ClockOutUtc, te.Source, te.Note, te.CreatedOn, te.UpdatedOn
    FROM dbo.TimeEntries te
    INNER JOIN dbo.Users u ON u.UserId = te.UserId
    WHERE te.ScheduleId = @ScheduleId
    ORDER BY te.ClockInUtc;
END
