/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-09-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

/* Replaces a user's weekly availability from JSON such as
   [{"DayOfWeek":1,"StartTime":"09:00","EndTime":"17:00"}, ...].
   Rows with an invalid day or a non-positive range are skipped. */
CREATE   PROCEDURE dbo.usp_UserAvailability_Replace
    @UserId    INT,
    @SlotsJson NVARCHAR(MAX) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRANSACTION;

    DELETE FROM dbo.UserAvailability WHERE UserId = @UserId;

    INSERT INTO dbo.UserAvailability (UserId, DayOfWeek, StartTime, EndTime)
    SELECT @UserId, j.DayOfWeek, j.StartTime, j.EndTime
    FROM OPENJSON(ISNULL(@SlotsJson, N'[]'))
         WITH (DayOfWeek TINYINT  '$.DayOfWeek',
               StartTime TIME(0)  '$.StartTime',
               EndTime   TIME(0)  '$.EndTime') j
    WHERE j.DayOfWeek BETWEEN 0 AND 6
      AND j.StartTime IS NOT NULL AND j.EndTime IS NOT NULL
      AND j.EndTime > j.StartTime;

    COMMIT TRANSACTION;
END
