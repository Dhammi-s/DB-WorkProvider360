/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


CREATE   PROCEDURE dbo.usp_Office_GetById
    @OfficeId UNIQUEIDENTIFIER
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
    WHERE o.OfficeId = @OfficeId;
END
