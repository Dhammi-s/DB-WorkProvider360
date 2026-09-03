/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-09-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

/* Every active staff user (never portal clients) with flags telling whether
   they share the client's office and hold the requested skill. The service
   decides how strict to be from ClientSettings and the caller's role; the UI
   shows the flags as hints. */
CREATE   PROCEDURE dbo.usp_Client_GetEligibleCaregivers
    @ClientId      INT,
    @ServiceTypeId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @OfficeId UNIQUEIDENTIFIER = (SELECT c.OfficeId FROM dbo.Clients c WHERE c.ClientId = @ClientId);

    SELECT
        u.UserId, u.FullName, u.Email, u.AvatarUrl, u.RoleId, r.RoleName, u.OfficeId, o.OfficeName,
        CAST(CASE WHEN @OfficeId IS NULL OR u.OfficeId = @OfficeId THEN 1 ELSE 0 END AS BIT) AS IsSameOffice,
        CAST(CASE WHEN @ServiceTypeId IS NULL
                    OR EXISTS (SELECT 1 FROM dbo.UserServiceTypes ust
                               WHERE ust.UserId = u.UserId AND ust.ServiceTypeId = @ServiceTypeId)
                  THEN 1 ELSE 0 END AS BIT) AS HasSkill,
        (SELECT STRING_AGG(st.Name, N', ') WITHIN GROUP (ORDER BY st.SortOrder, st.Name)
           FROM dbo.UserServiceTypes ust
           INNER JOIN dbo.ServiceTypes st ON st.ServiceTypeId = ust.ServiceTypeId
          WHERE ust.UserId = u.UserId) AS SkillNames
    FROM dbo.Users u
    INNER JOIN dbo.Roles r ON r.RoleId = u.RoleId
    LEFT JOIN dbo.Office o ON o.OfficeId = u.OfficeId
    WHERE u.IsActive = 1
      AND r.RoleName <> N'Client'
    ORDER BY IsSameOffice DESC, HasSkill DESC, u.FullName;
END
