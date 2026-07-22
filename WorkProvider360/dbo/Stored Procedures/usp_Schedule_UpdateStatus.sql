
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
