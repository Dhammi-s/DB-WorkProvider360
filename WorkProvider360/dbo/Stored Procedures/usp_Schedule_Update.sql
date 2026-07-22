
CREATE   PROCEDURE dbo.usp_Schedule_Update
    @ScheduleId         INT,
    @Title              NVARCHAR(200),
    @CustomerName       NVARCHAR(200) = NULL,
    @Location           NVARCHAR(300) = NULL,
    @AssignedUserId     INT,
    @StartUtc           DATETIME2(7),
    @EndUtc             DATETIME2(7),
    @PayRatePerHour     DECIMAL(10,2),
    @OvertimeMultiplier DECIMAL(5,2),
    @ColorTag           NVARCHAR(20)  = NULL
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.Schedules
    SET Title = @Title,
        CustomerName = @CustomerName,
        Location = @Location,
        AssignedUserId = @AssignedUserId,
        StartUtc = @StartUtc,
        EndUtc = @EndUtc,
        PayRatePerHour = @PayRatePerHour,
        OvertimeMultiplier = @OvertimeMultiplier,
        ColorTag = @ColorTag,
        UpdatedOn = SYSUTCDATETIME()
    WHERE ScheduleId = @ScheduleId;
END
