/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-09-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

/* ---------------------------- ClientSettings ----------------------------- */
CREATE   PROCEDURE dbo.usp_ClientSettings_Get
AS
BEGIN
    SET NOCOUNT ON;
    SELECT SettingsId,
           AdminClientAccess, ManagerClientAccess, AdminServiceTypeAccess, ManagerServiceTypeAccess,
           AutoClockInEnabled, AutoClockOutEnabled,
           RequireClientSignatureOnClockIn, RequireClientSignatureOnClockOut,
           RequireSameOffice, RequireMatchingSkill, CaptureClockLocation,
           ClientPortalEnabled, SendClientCredentialsEmail, NotifyClientOnSchedule,
           RequireClientEmail, RequireClientPhone, RequireClientDateOfBirth,
           RequireEmergencyContact, RequireClientServiceTypes,
           UpdatedOn
    FROM dbo.ClientSettings
    WHERE SettingsId = 1;
END
