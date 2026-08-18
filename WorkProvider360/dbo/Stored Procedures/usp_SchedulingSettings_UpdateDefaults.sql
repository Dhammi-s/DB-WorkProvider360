/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


CREATE   PROCEDURE dbo.usp_SchedulingSettings_UpdateDefaults
    @DefaultPayRatePerHour     DECIMAL(10,2),
    @DefaultOvertimeMultiplier DECIMAL(5,2),
    @NotifyAdminOnCreate       BIT,
    @NotifyManagerOnCreate     BIT,
    @AutoClockEnabled          BIT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM dbo.SchedulingSettings WHERE SettingsId = 1)
        INSERT INTO dbo.SchedulingSettings (SettingsId) VALUES (1);

    UPDATE dbo.SchedulingSettings
    SET DefaultPayRatePerHour = @DefaultPayRatePerHour,
        DefaultOvertimeMultiplier = @DefaultOvertimeMultiplier,
        NotifyAdminOnCreate = @NotifyAdminOnCreate,
        NotifyManagerOnCreate = @NotifyManagerOnCreate,
        AutoClockEnabled = @AutoClockEnabled,
        UpdatedOn = SYSUTCDATETIME()
    WHERE SettingsId = 1;

    EXEC dbo.usp_SchedulingSettings_Get;
END
