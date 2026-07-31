/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


CREATE   PROCEDURE dbo.usp_LogSettings_Get
AS
BEGIN
    SET NOCOUNT ON;
    SELECT SettingsId, AdminCanViewLogs, ManagerCanViewLogs, UpdatedOn
    FROM dbo.LogSettings
    WHERE SettingsId = 1;
END
