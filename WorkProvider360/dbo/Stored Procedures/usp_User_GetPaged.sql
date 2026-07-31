/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


CREATE   PROCEDURE dbo.usp_User_GetPaged
    @Page     INT = 1,
    @PageSize INT = 10,
    @RoleName NVARCHAR(50)     = NULL,
    @OfficeId UNIQUEIDENTIFIER = NULL,
    @NoOffice BIT              = 0
AS
BEGIN
    SET NOCOUNT ON;

    IF @Page < 1 SET @Page = 1;
    IF @PageSize < 1 SET @PageSize = 10;

    ;WITH filtered AS (
        SELECT u.UserId
        FROM dbo.Users u
        INNER JOIN dbo.Roles r ON r.RoleId = u.RoleId
        WHERE (@RoleName IS NULL OR r.RoleName = @RoleName)
          AND (
                (@NoOffice = 1 AND u.OfficeId IS NULL)
             OR (@NoOffice = 0 AND (@OfficeId IS NULL OR u.OfficeId = @OfficeId))
          )
    )
    SELECT
        u.UserId, u.Email, u.FullName, u.PasswordHash, u.PasswordSalt,
        u.RoleId, r.RoleName, u.Phone, u.AvatarUrl, u.OfficeId, o.OfficeName, u.Salary,
        u.IsActive, u.CreatedOn, u.UpdatedOn
    FROM dbo.Users u
    INNER JOIN dbo.Roles r ON r.RoleId = u.RoleId
    LEFT JOIN dbo.Office o ON o.OfficeId = u.OfficeId
    WHERE u.UserId IN (SELECT UserId FROM filtered)
    ORDER BY u.UserId
    OFFSET (@Page - 1) * @PageSize ROWS FETCH NEXT @PageSize ROWS ONLY;

    SELECT COUNT(*) AS Total
    FROM dbo.Users u
    INNER JOIN dbo.Roles r ON r.RoleId = u.RoleId
    WHERE (@RoleName IS NULL OR r.RoleName = @RoleName)
      AND (
            (@NoOffice = 1 AND u.OfficeId IS NULL)
         OR (@NoOffice = 0 AND (@OfficeId IS NULL OR u.OfficeId = @OfficeId))
      );
END
