CREATE PROCEDURE usp_GetTimezones
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        TimezoneId,
        Timezone,
        Description,
        AgencyTimezone,
        CreatedOn,
        ModifiedOn,
        IsActive,
        IsArchived
    FROM Timezone
    WHERE IsActive = 1
      AND IsArchived = 0
    ORDER BY Timezone;
END;
