
CREATE   PROCEDURE dbo.usp_AnnouncementSettings_Upsert
    @ShowToAdmin   BIT,
    @ShowToManager BIT,
    @ShowToUser    BIT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM dbo.AnnouncementSettings WHERE SettingsId = 1)
    BEGIN
        UPDATE dbo.AnnouncementSettings
        SET ShowToAdmin = @ShowToAdmin,
            ShowToManager = @ShowToManager,
            ShowToUser = @ShowToUser,
            UpdatedOn = sysutcdatetime()
        WHERE SettingsId = 1;
    END
    ELSE
    BEGIN
        INSERT INTO dbo.AnnouncementSettings (SettingsId, ShowToAdmin, ShowToManager, ShowToUser)
        VALUES (1, @ShowToAdmin, @ShowToManager, @ShowToUser);
    END

    SELECT SettingsId, ShowToAdmin, ShowToManager, ShowToUser, UpdatedOn
    FROM dbo.AnnouncementSettings
    WHERE SettingsId = 1;
END
