
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
