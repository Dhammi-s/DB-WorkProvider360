/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


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
