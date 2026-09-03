/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

/* Hard delete with a manual cascade. Signatures reference TimeEntries and
   LocationPings reference Schedules, so both must go before their parents.
   Wrapped in a transaction so a failure leaves nothing half-deleted. */
CREATE   PROCEDURE dbo.usp_Schedule_Delete
    @ScheduleId INT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRANSACTION;

    DELETE sig
    FROM dbo.TimeEntrySignatures sig
    INNER JOIN dbo.TimeEntries te ON te.TimeEntryId = sig.TimeEntryId
    WHERE te.ScheduleId = @ScheduleId;

    DELETE FROM dbo.LocationPings WHERE ScheduleId = @ScheduleId;
    DELETE FROM dbo.TimeEntries   WHERE ScheduleId = @ScheduleId;
    DELETE FROM dbo.ScheduleNotes WHERE ScheduleId = @ScheduleId;
    DELETE FROM dbo.Schedules     WHERE ScheduleId = @ScheduleId;

    COMMIT TRANSACTION;
END
