/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


CREATE   PROCEDURE dbo.usp_TimeEntry_Update
    @TimeEntryId INT,
    @ClockInUtc  DATETIME2(7),
    @ClockOutUtc DATETIME2(7) = NULL,
    @Note        NVARCHAR(500) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.TimeEntries
    SET ClockInUtc = @ClockInUtc,
        ClockOutUtc = @ClockOutUtc,
        Note = @Note,
        UpdatedOn = SYSUTCDATETIME()
    WHERE TimeEntryId = @TimeEntryId;
END
