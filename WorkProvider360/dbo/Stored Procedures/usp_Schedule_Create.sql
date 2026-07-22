
/* ------------------------------ Schedules -------------------------------- */
CREATE   PROCEDURE dbo.usp_Schedule_Create
    @Title              NVARCHAR(200),
    @CustomerName       NVARCHAR(200) = NULL,
    @Location           NVARCHAR(300) = NULL,
    @AssignedUserId     INT,
    @StartUtc           DATETIME2(7),
    @EndUtc             DATETIME2(7),
    @PayRatePerHour     DECIMAL(10,2),
    @OvertimeMultiplier DECIMAL(5,2),
    @ColorTag           NVARCHAR(20)  = NULL,
    @CreatedByUserId    INT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.Schedules
        (Title, CustomerName, Location, AssignedUserId, StartUtc, EndUtc,
         PayRatePerHour, OvertimeMultiplier, Status, ColorTag, CreatedByUserId)
    VALUES
        (@Title, @CustomerName, @Location, @AssignedUserId, @StartUtc, @EndUtc,
         @PayRatePerHour, @OvertimeMultiplier, N'Scheduled', @ColorTag, @CreatedByUserId);

    SELECT CAST(SCOPE_IDENTITY() AS INT);
END
