/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-09-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

/* Soft delete: a service type referenced by schedules/clients/users must stay. */
CREATE   PROCEDURE dbo.usp_ServiceType_Deactivate
    @ServiceTypeId INT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.ServiceTypes
    SET IsActive = 0,
        UpdatedOn = SYSUTCDATETIME()
    WHERE ServiceTypeId = @ServiceTypeId;
END
