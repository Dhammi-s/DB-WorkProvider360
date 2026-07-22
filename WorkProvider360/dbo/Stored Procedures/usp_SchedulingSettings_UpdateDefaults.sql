
CREATE   PROCEDURE dbo.usp_SchedulingSettings_UpdateDefaults
    @DefaultPayRatePerHour     DECIMAL(10,2),
    @DefaultOvertimeMultiplier DECIMAL(5,2),
    @NotifyAdminOnCreate       BIT,
    @NotifyManagerOnCreate     BIT
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
        UpdatedOn = SYSUTCDATETIME()
    WHERE SettingsId = 1;

    EXEC dbo.usp_SchedulingSettings_Get;
END
