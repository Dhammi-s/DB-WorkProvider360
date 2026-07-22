
CREATE   PROCEDURE dbo.usp_SchedulingSettings_UpdateAccess
    @AdminAccess   NVARCHAR(10),
    @ManagerAccess NVARCHAR(10)
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM dbo.SchedulingSettings WHERE SettingsId = 1)
        INSERT INTO dbo.SchedulingSettings (SettingsId) VALUES (1);

    UPDATE dbo.SchedulingSettings
    SET AdminAccess = @AdminAccess,
        ManagerAccess = @ManagerAccess,
        UpdatedOn = SYSUTCDATETIME()
    WHERE SettingsId = 1;

    EXEC dbo.usp_SchedulingSettings_Get;
END
