/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

/* Closes the most recent still-open timer for this user + schedule and returns
   the closed TimeEntryId, or 0 when nothing was open (the service checks == 0). */
CREATE   PROCEDURE dbo.usp_TimeEntry_ClockOut
    @ScheduleId INT,
    @UserId     INT,
    @Latitude   DECIMAL(9,6) = NULL,
    @Longitude  DECIMAL(9,6) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @TimeEntryId INT =
    (
        SELECT TOP (1) TimeEntryId
        FROM dbo.TimeEntries
        WHERE ScheduleId = @ScheduleId AND UserId = @UserId AND ClockOutUtc IS NULL
        ORDER BY ClockInUtc DESC
    );

    IF @TimeEntryId IS NOT NULL
    BEGIN
        UPDATE dbo.TimeEntries
        SET ClockOutUtc = SYSUTCDATETIME(),
            ClockOutLatitude = @Latitude,
            ClockOutLongitude = @Longitude,
            UpdatedOn = SYSUTCDATETIME()
        WHERE TimeEntryId = @TimeEntryId;
    END

    SELECT ISNULL(@TimeEntryId, 0);
END
