/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


CREATE   PROCEDURE dbo.usp_Schedule_UpdateStatus
    @ScheduleId      INT,
    @Status          NVARCHAR(20),
    @RejectionReason NVARCHAR(1000) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.Schedules
    SET Status = @Status,
        RejectionReason = @RejectionReason,
        UpdatedOn = SYSUTCDATETIME()
    WHERE ScheduleId = @ScheduleId;
END
