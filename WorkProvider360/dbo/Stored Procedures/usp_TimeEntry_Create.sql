/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


CREATE   PROCEDURE dbo.usp_TimeEntry_Create
    @ScheduleId  INT,
    @UserId      INT,
    @ClockInUtc  DATETIME2(7),
    @ClockOutUtc DATETIME2(7) = NULL,
    @Note        NVARCHAR(500) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.TimeEntries (ScheduleId, UserId, ClockInUtc, ClockOutUtc, Source, Note)
    VALUES (@ScheduleId, @UserId, @ClockInUtc, @ClockOutUtc, N'Manual', @Note);

    SELECT CAST(SCOPE_IDENTITY() AS INT);
END
