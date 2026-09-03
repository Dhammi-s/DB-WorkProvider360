/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE   PROCEDURE dbo.usp_ApplicationSettings_Upsert
    @RequirePhone              BIT,
    @RequireAddress            BIT,
    @EmailNotificationsEnabled BIT,
    @NotificationEmail         NVARCHAR(256) = NULL,
    @AllowStaffUnlock          BIT = 0,
    @RequireQualifications     BIT = 0,
    @RequireSkills             BIT = 1,
    @RequireAvailability       BIT = 0,
    @RequireDateOfBirth        BIT = 0
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
            AllowStaffUnlock = @AllowStaffUnlock,
            RequireQualifications = @RequireQualifications,
            RequireSkills = @RequireSkills,
            RequireAvailability = @RequireAvailability,
            RequireDateOfBirth = @RequireDateOfBirth,
            UpdatedOn = SYSUTCDATETIME()
        WHERE SettingsId = 1;
    END
    ELSE
    BEGIN
        INSERT INTO dbo.ApplicationSettings
            (SettingsId, RequirePhone, RequireAddress, EmailNotificationsEnabled, NotificationEmail,
             AllowStaffUnlock, RequireQualifications, RequireSkills, RequireAvailability, RequireDateOfBirth)
        VALUES
            (1, @RequirePhone, @RequireAddress, @EmailNotificationsEnabled, @NotificationEmail,
             @AllowStaffUnlock, @RequireQualifications, @RequireSkills, @RequireAvailability, @RequireDateOfBirth);
    END

    SELECT SettingsId, RequirePhone, RequireAddress, EmailNotificationsEnabled, NotificationEmail,
           AllowStaffUnlock, RequireQualifications, RequireSkills, RequireAvailability, RequireDateOfBirth,
           UpdatedOn
    FROM dbo.ApplicationSettings
    WHERE SettingsId = 1;
END
