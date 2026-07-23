
CREATE   PROCEDURE dbo.usp_Office_Deactivate
    @OfficeId UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.Office
    SET IsActive = 0,
        UpdatedOn = sysutcdatetime()
    WHERE OfficeId = @OfficeId;
END
