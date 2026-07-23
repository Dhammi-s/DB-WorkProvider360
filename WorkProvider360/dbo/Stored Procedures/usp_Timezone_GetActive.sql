
CREATE   PROCEDURE dbo.usp_Timezone_GetActive
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        TimezoneId,
        Timezone AS TimezoneName,
        Description,
        IsActive
    FROM dbo.Timezone
    WHERE IsActive = 1
      AND IsArchived = 0
    ORDER BY Timezone;
END
