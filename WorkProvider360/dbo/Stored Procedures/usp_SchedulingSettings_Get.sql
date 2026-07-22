
/* =============================== PROCEDURES ================================= */

/* ------------------------- SchedulingSettings ---------------------------- */
CREATE   PROCEDURE dbo.usp_SchedulingSettings_Get
AS
BEGIN
    SET NOCOUNT ON;
    SELECT SettingsId, AdminAccess, ManagerAccess, DefaultPayRatePerHour,
           DefaultOvertimeMultiplier, NotifyAdminOnCreate, NotifyManagerOnCreate, UpdatedOn
    FROM dbo.SchedulingSettings
    WHERE SettingsId = 1;
END
