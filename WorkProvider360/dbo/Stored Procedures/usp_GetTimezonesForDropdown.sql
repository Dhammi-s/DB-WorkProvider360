CREATE PROCEDURE usp_GetTimezonesForDropdown
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        TimezoneId,
        Timezone
    FROM Timezone
    WHERE IsActive = 1
      AND IsArchived = 0
    ORDER BY Timezone;
END;
