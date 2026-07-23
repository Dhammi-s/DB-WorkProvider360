
CREATE   PROCEDURE dbo.usp_LogSettings_Get
AS
BEGIN
    SET NOCOUNT ON;
    SELECT SettingsId, AdminCanViewLogs, ManagerCanViewLogs, UpdatedOn
    FROM dbo.LogSettings
    WHERE SettingsId = 1;
END
