
CREATE   PROCEDURE dbo.usp_ApplicationSettings_Upsert
    @RequirePhone              BIT,
    @RequireAddress            BIT,
    @EmailNotificationsEnabled BIT,
    @NotificationEmail         NVARCHAR(256) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM dbo.ApplicationSettings WHERE SettingsId = 1)
    BEGIN
        UPDATE dbo.ApplicationSettings
        SET RequirePhone = @RequirePhone,
            RequireAddress = @RequireAddress,
            EmailNotificationsEnabled = @EmailNotificationsEnabled,
            NotificationEmail = @NotificationEmail,
            UpdatedOn = SYSUTCDATETIME()
        WHERE SettingsId = 1;
    END
    ELSE
    BEGIN
        INSERT INTO dbo.ApplicationSettings (SettingsId, RequirePhone, RequireAddress, EmailNotificationsEnabled, NotificationEmail)
        VALUES (1, @RequirePhone, @RequireAddress, @EmailNotificationsEnabled, @NotificationEmail);
    END

    SELECT SettingsId, RequirePhone, RequireAddress, EmailNotificationsEnabled, NotificationEmail, UpdatedOn
    FROM dbo.ApplicationSettings
    WHERE SettingsId = 1;
END
