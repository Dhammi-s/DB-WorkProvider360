
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
