/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


/* ---------------------------------------------------------------------------
   Lazy auto clock-in/out. Resolves ONLY shifts that have already ended, so it
   never pre-empts a user who is still on an active shift. Idempotent: safe to
   call on every scheduler/report read. The caller (SchedulingService) only
   invokes this when the agency toggle SchedulingSettings.AutoClockEnabled = 1.
   --------------------------------------------------------------------------- */
CREATE   PROCEDURE dbo.usp_Schedule_ApplyAutoClock
    @NowUtc DATETIME2(7)
AS
BEGIN
    SET NOCOUNT ON;

    /* 1) Fully missed shift (no time entry at all) -> record the whole window. */
    INSERT INTO dbo.TimeEntries (ScheduleId, UserId, ClockInUtc, ClockOutUtc, Source)
    SELECT s.ScheduleId, s.AssignedUserId, s.StartUtc, s.EndUtc, N'Auto'
    FROM dbo.Schedules s
    WHERE s.EndUtc <= @NowUtc
      AND s.Status NOT IN (N'Cancelled', N'Rejected')
      AND NOT EXISTS (SELECT 1 FROM dbo.TimeEntries t WHERE t.ScheduleId = s.ScheduleId);

    /* 2) Clocked in but never clocked out on an ended shift -> close at EndUtc. */
    UPDATE t
    SET t.ClockOutUtc = s.EndUtc,
        t.UpdatedOn   = SYSUTCDATETIME()
    FROM dbo.TimeEntries t
    INNER JOIN dbo.Schedules s ON s.ScheduleId = t.ScheduleId
    WHERE t.ClockOutUtc IS NULL
      AND s.EndUtc <= @NowUtc
      AND s.Status NOT IN (N'Cancelled', N'Rejected');

    /* 3) Mark those shifts complete (they now have a closed entry). */
    UPDATE s
    SET s.Status = N'Completed',
        s.UpdatedOn = SYSUTCDATETIME()
    FROM dbo.Schedules s
    WHERE s.EndUtc <= @NowUtc
      AND s.Status NOT IN (N'Completed', N'Cancelled', N'Rejected')
      AND EXISTS (SELECT 1 FROM dbo.TimeEntries t
                  WHERE t.ScheduleId = s.ScheduleId AND t.ClockOutUtc IS NOT NULL);
END
