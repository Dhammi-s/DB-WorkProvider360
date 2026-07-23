
CREATE   PROCEDURE dbo.usp_PosFeeSettings_Upsert
    @FeePercent DECIMAL(5,2),
    @FeeFixed   DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM dbo.PosFeeSettings WHERE SettingsId = 1)
    BEGIN
        UPDATE dbo.PosFeeSettings
        SET FeePercent = @FeePercent, FeeFixed = @FeeFixed, UpdatedOn = sysutcdatetime()
        WHERE SettingsId = 1;
    END
    ELSE
    BEGIN
        INSERT INTO dbo.PosFeeSettings (SettingsId, FeePercent, FeeFixed)
        VALUES (1, @FeePercent, @FeeFixed);
    END

    SELECT SettingsId, FeePercent, FeeFixed, UpdatedOn
    FROM dbo.PosFeeSettings
    WHERE SettingsId = 1;
END
