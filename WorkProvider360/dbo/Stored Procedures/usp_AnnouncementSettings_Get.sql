
CREATE   PROCEDURE dbo.usp_AnnouncementSettings_Get
AS
BEGIN
    SET NOCOUNT ON;
    SELECT SettingsId, ShowToAdmin, ShowToManager, ShowToUser, UpdatedOn
    FROM dbo.AnnouncementSettings
    WHERE SettingsId = 1;
END
