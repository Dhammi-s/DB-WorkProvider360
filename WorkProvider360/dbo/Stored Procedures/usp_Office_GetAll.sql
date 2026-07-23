
CREATE   PROCEDURE dbo.usp_Office_GetAll
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        o.OfficeId,
        o.OfficeName,
        o.Address,
        o.Phone,
        o.TimezoneId,
        t.Timezone AS TimezoneName,
        o.IsActive,
        o.CreatedOn,
        o.UpdatedOn,
        (SELECT COUNT(1) FROM dbo.Users u WHERE u.OfficeId = o.OfficeId) AS MemberCount
    FROM dbo.Office o
    LEFT JOIN dbo.Timezone t ON t.TimezoneId = o.TimezoneId
    WHERE o.IsArchived = 0
    ORDER BY o.OfficeName;
END
