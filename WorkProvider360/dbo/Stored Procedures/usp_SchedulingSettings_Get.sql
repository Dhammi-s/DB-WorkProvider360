/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


/* =============================== PROCEDURES ================================= */

/* ------------------------- SchedulingSettings ---------------------------- */
CREATE   PROCEDURE dbo.usp_SchedulingSettings_Get
AS
BEGIN
    SET NOCOUNT ON;
    SELECT SettingsId, AdminAccess, ManagerAccess, DefaultPayRatePerHour,
           DefaultOvertimeMultiplier, NotifyAdminOnCreate, NotifyManagerOnCreate,
           AutoClockEnabled, UpdatedOn
    FROM dbo.SchedulingSettings
    WHERE SettingsId = 1;
END
