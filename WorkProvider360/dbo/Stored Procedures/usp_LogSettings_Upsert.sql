/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


CREATE   PROCEDURE dbo.usp_LogSettings_Upsert
    @AdminCanViewLogs   BIT,
    @ManagerCanViewLogs BIT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM dbo.LogSettings WHERE SettingsId = 1)
    BEGIN
        UPDATE dbo.LogSettings
        SET AdminCanViewLogs = @AdminCanViewLogs,
            ManagerCanViewLogs = @ManagerCanViewLogs,
            UpdatedOn = sysutcdatetime()
        WHERE SettingsId = 1;
    END
    ELSE
    BEGIN
        INSERT INTO dbo.LogSettings (SettingsId, AdminCanViewLogs, ManagerCanViewLogs)
        VALUES (1, @AdminCanViewLogs, @ManagerCanViewLogs);
    END

    SELECT SettingsId, AdminCanViewLogs, ManagerCanViewLogs, UpdatedOn
    FROM dbo.LogSettings
    WHERE SettingsId = 1;
END
