/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-09-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE   PROCEDURE dbo.usp_Client_GetPaged
    @Page          INT              = 1,
    @PageSize      INT              = 10,
    @OfficeId      UNIQUEIDENTIFIER = NULL,
    @Status        NVARCHAR(20)     = NULL,
    @ServiceTypeId INT              = NULL,
    @Search        NVARCHAR(200)    = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF @Page < 1 SET @Page = 1;
    IF @PageSize < 1 SET @PageSize = 10;
    IF @Search IS NOT NULL AND LTRIM(RTRIM(@Search)) = N'' SET @Search = NULL;

    /* Filter once so the page and the total share a single predicate. */
    SELECT c.ClientId
    INTO #filtered
    FROM dbo.Clients c
    WHERE (@OfficeId IS NULL OR c.OfficeId = @OfficeId)
      AND (@Status IS NULL OR c.Status = @Status)
      AND (@ServiceTypeId IS NULL OR EXISTS (SELECT 1 FROM dbo.ClientServiceTypes cst
                                             WHERE cst.ClientId = c.ClientId AND cst.ServiceTypeId = @ServiceTypeId))
      AND (@Search IS NULL
           OR c.FirstName LIKE N'%' + @Search + N'%'
           OR c.LastName  LIKE N'%' + @Search + N'%'
           OR (c.FirstName + N' ' + c.LastName) LIKE N'%' + @Search + N'%'
           OR c.Email     LIKE N'%' + @Search + N'%'
           OR c.Phone     LIKE N'%' + @Search + N'%'
           OR c.City      LIKE N'%' + @Search + N'%');

    SELECT
        c.ClientId, c.UserId, c.OfficeId, o.OfficeName,
        c.FirstName, c.LastName, c.Email, c.Phone, c.AlternatePhone, c.DateOfBirth, c.Gender,
        c.AddressLine1, c.AddressLine2, c.City, c.State, c.PostalCode, c.Country, c.Latitude, c.Longitude,
        c.EmergencyContactName, c.EmergencyContactPhone, c.EmergencyContactRelation,
        c.PreferredLanguage, c.AccessInstructions, c.CareNotes, c.Allergies, c.MobilityNotes,
        c.PortalEnabled, c.Status, c.StartDate, c.Notes, c.CreatedByUserId, c.CreatedOn, c.UpdatedOn,
        u.Email AS PortalEmail, u.IsActive AS PortalIsActive, u.IsLockedOut AS PortalIsLockedOut,
        (SELECT STRING_AGG(st.Name, N', ') WITHIN GROUP (ORDER BY st.SortOrder, st.Name)
           FROM dbo.ClientServiceTypes cst
           INNER JOIN dbo.ServiceTypes st ON st.ServiceTypeId = cst.ServiceTypeId
          WHERE cst.ClientId = c.ClientId) AS ServiceTypeNames
    FROM dbo.Clients c
    LEFT JOIN dbo.Office o ON o.OfficeId = c.OfficeId
    LEFT JOIN dbo.Users  u ON u.UserId   = c.UserId
    WHERE c.ClientId IN (SELECT ClientId FROM #filtered)
    ORDER BY c.LastName, c.FirstName, c.ClientId
    OFFSET (@Page - 1) * @PageSize ROWS FETCH NEXT @PageSize ROWS ONLY;

    SELECT COUNT(*) AS Total FROM #filtered;

    DROP TABLE #filtered;
END
