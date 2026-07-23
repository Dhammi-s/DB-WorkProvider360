
CREATE   PROCEDURE dbo.usp_PosFeeSettings_Get
AS
BEGIN
    SET NOCOUNT ON;
    SELECT SettingsId, FeePercent, FeeFixed, UpdatedOn
    FROM dbo.PosFeeSettings
    WHERE SettingsId = 1;
END
