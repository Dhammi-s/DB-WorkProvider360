
CREATE   PROCEDURE dbo.usp_Office_Update
    @OfficeId   UNIQUEIDENTIFIER,
    @OfficeName NVARCHAR(200),
    @Address    NVARCHAR(500)    = NULL,
    @Phone      NVARCHAR(50)     = NULL,
    @TimezoneId UNIQUEIDENTIFIER = NULL,
    @IsActive   BIT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.Office
    SET OfficeName = @OfficeName,
        Address    = @Address,
        Phone      = @Phone,
        TimezoneId = @TimezoneId,
        IsActive   = @IsActive,
        UpdatedOn  = sysutcdatetime()
    WHERE OfficeId = @OfficeId;
END
