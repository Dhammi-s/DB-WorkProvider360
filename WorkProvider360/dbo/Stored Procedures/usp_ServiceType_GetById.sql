/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-09-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE   PROCEDURE dbo.usp_ServiceType_GetById
    @ServiceTypeId INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT
        st.ServiceTypeId, st.Name, st.Description, st.Category, st.ColorTag, st.SortOrder,
        st.IsActive, st.CreatedByUserId, st.CreatedOn, st.UpdatedOn,
        (SELECT COUNT(*) FROM dbo.ClientServiceTypes cst WHERE cst.ServiceTypeId = st.ServiceTypeId) AS ClientCount,
        (SELECT COUNT(*) FROM dbo.UserServiceTypes ust WHERE ust.ServiceTypeId = st.ServiceTypeId)   AS UserCount
    FROM dbo.ServiceTypes st
    WHERE st.ServiceTypeId = @ServiceTypeId;
END
