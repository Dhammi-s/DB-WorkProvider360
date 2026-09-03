/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-09-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE   PROCEDURE dbo.usp_ClientServiceType_GetByClient
    @ClientId INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT st.ServiceTypeId, st.Name, st.Description, st.Category, st.ColorTag, st.SortOrder,
           st.IsActive, st.CreatedByUserId, st.CreatedOn, st.UpdatedOn, cst.Notes
    FROM dbo.ClientServiceTypes cst
    INNER JOIN dbo.ServiceTypes st ON st.ServiceTypeId = cst.ServiceTypeId
    WHERE cst.ClientId = @ClientId
    ORDER BY st.SortOrder, st.Name;
END
