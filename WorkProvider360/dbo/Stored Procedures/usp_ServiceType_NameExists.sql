/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-09-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE   PROCEDURE dbo.usp_ServiceType_NameExists
    @Name                 NVARCHAR(100),
    @ExcludeServiceTypeId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SELECT COUNT(1)
    FROM dbo.ServiceTypes
    WHERE Name = @Name
      AND (@ExcludeServiceTypeId IS NULL OR ServiceTypeId <> @ExcludeServiceTypeId);
END
