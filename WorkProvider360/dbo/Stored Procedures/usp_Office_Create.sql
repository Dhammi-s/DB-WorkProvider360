
CREATE   PROCEDURE dbo.usp_Office_Create
    @OfficeName NVARCHAR(200),
    @Address    NVARCHAR(500)    = NULL,
    @Phone      NVARCHAR(50)     = NULL,
    @TimezoneId UNIQUEIDENTIFIER = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @NewId UNIQUEIDENTIFIER = NEWID();

    INSERT INTO dbo.Office (OfficeId, OfficeName, Address, Phone, TimezoneId, IsActive, IsArchived)
    VALUES (@NewId, @OfficeName, @Address, @Phone, @TimezoneId, 1, 0);

    SELECT @NewId;   -- new OfficeId
END
