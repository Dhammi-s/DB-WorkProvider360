/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


/* =============================== PROCEDURES ================================= */

/* ------------------------- ApplicationSettings --------------------------- */
CREATE   PROCEDURE dbo.usp_ApplicationSettings_Get
AS
BEGIN
    SET NOCOUNT ON;
    SELECT SettingsId, RequirePhone, RequireAddress, EmailNotificationsEnabled, NotificationEmail, UpdatedOn
    FROM dbo.ApplicationSettings
    WHERE SettingsId = 1;
END
