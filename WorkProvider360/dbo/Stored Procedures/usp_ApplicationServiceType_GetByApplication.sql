/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-09-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE   PROCEDURE dbo.usp_ApplicationServiceType_GetByApplication
    @ApplicationId INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT st.ServiceTypeId, st.Name, st.Description, st.Category, st.ColorTag, st.SortOrder,
           st.IsActive, st.CreatedByUserId, st.CreatedOn, st.UpdatedOn
    FROM dbo.ApplicationServiceTypes ast
    INNER JOIN dbo.ServiceTypes st ON st.ServiceTypeId = ast.ServiceTypeId
    WHERE ast.ApplicationId = @ApplicationId
    ORDER BY st.SortOrder, st.Name;
END
