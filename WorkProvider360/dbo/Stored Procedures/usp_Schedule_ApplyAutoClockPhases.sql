/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-09-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

/* ---------------------------------------------------------------------------
   Lazy auto clock-in / clock-out for CLIENT VISITS (Schedules.ClientId set),
   driven by ClientSettings.AutoClockInEnabled / AutoClockOutEnabled and called
   on scheduler reads next to the legacy usp_Schedule_ApplyAutoClock (which
   handles ended shifts for the whole tenant).

   Clock-in phase : visits started but not yet ended, still Scheduled/Accepted
                    and without any time entry -> open an 'Auto' entry at
                    StartUtc and mark the visit InProgress.
   Clock-out phase: open entries on ended visits -> close at EndUtc and mark
                    the visit Completed.

   Windows are disjoint from the legacy proc (which only touches EndUtc <= now),
   so running both in one request never double-processes. Idempotent.
   --------------------------------------------------------------------------- */
CREATE   PROCEDURE dbo.usp_Schedule_ApplyAutoClockPhases
    @NowUtc       DATETIME2(7),
    @AutoClockIn  BIT = 0,
    @AutoClockOut BIT = 0
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRANSACTION;

    IF @AutoClockIn = 1
    BEGIN
        INSERT INTO dbo.TimeEntries (ScheduleId, UserId, ClockInUtc, Source)
        SELECT s.ScheduleId, s.AssignedUserId, s.StartUtc, N'Auto'
        FROM dbo.Schedules s WITH (UPDLOCK, HOLDLOCK)
        WHERE s.ClientId IS NOT NULL
          AND s.StartUtc <= @NowUtc
          AND s.EndUtc   >  @NowUtc
          AND s.Status IN (N'Scheduled', N'Accepted')
          AND NOT EXISTS (SELECT 1 FROM dbo.TimeEntries t WHERE t.ScheduleId = s.ScheduleId);

        UPDATE s
        SET s.Status = N'InProgress',
            s.UpdatedOn = SYSUTCDATETIME()
        FROM dbo.Schedules s
        WHERE s.ClientId IS NOT NULL
          AND s.StartUtc <= @NowUtc
          AND s.EndUtc   >  @NowUtc
          AND s.Status IN (N'Scheduled', N'Accepted')
          AND EXISTS (SELECT 1 FROM dbo.TimeEntries t
                      WHERE t.ScheduleId = s.ScheduleId AND t.ClockOutUtc IS NULL);
    END

    IF @AutoClockOut = 1
    BEGIN
        UPDATE t
        SET t.ClockOutUtc = CASE WHEN s.EndUtc >= t.ClockInUtc THEN s.EndUtc ELSE @NowUtc END,
            t.UpdatedOn   = SYSUTCDATETIME()
        FROM dbo.TimeEntries t
        INNER JOIN dbo.Schedules s ON s.ScheduleId = t.ScheduleId
        WHERE s.ClientId IS NOT NULL
          AND t.ClockOutUtc IS NULL
          AND s.EndUtc <= @NowUtc
          AND s.Status NOT IN (N'Cancelled', N'Rejected');

        UPDATE s
        SET s.Status = N'Completed',
            s.UpdatedOn = SYSUTCDATETIME()
        FROM dbo.Schedules s
        WHERE s.ClientId IS NOT NULL
          AND s.EndUtc <= @NowUtc
          AND s.Status NOT IN (N'Completed', N'Cancelled', N'Rejected')
          AND EXISTS (SELECT 1 FROM dbo.TimeEntries t
                      WHERE t.ScheduleId = s.ScheduleId AND t.ClockOutUtc IS NOT NULL)
          AND NOT EXISTS (SELECT 1 FROM dbo.TimeEntries t
                          WHERE t.ScheduleId = s.ScheduleId AND t.ClockOutUtc IS NULL);
    END

    COMMIT TRANSACTION;
END
