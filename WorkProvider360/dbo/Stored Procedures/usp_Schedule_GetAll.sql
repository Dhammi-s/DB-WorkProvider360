/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


CREATE   PROCEDURE dbo.usp_Schedule_GetAll
    @FromUtc        DATETIME2(7) = NULL,
    @ToUtc          DATETIME2(7) = NULL,
    @AssignedUserId INT          = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT
        s.ScheduleId, s.Title, s.CustomerName, s.Location,
        s.AssignedUserId, u.FullName AS AssignedUserName,
        s.StartUtc, s.EndUtc, s.PayRatePerHour, s.OvertimeMultiplier,
        s.Status, s.RejectionReason, s.ColorTag,
        s.CreatedByUserId, s.CreatedOn, s.UpdatedOn
    FROM dbo.Schedules s
    INNER JOIN dbo.Users u ON u.UserId = s.AssignedUserId
    WHERE (@FromUtc IS NULL OR s.EndUtc   >= @FromUtc)
      AND (@ToUtc   IS NULL OR s.StartUtc <  @ToUtc)
      AND (@AssignedUserId IS NULL OR s.AssignedUserId = @AssignedUserId)
    ORDER BY s.StartUtc;
END
