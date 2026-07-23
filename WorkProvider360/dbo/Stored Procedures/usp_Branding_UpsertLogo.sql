
CREATE   PROCEDURE dbo.usp_Branding_UpsertLogo
    @LogoBase64 NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM dbo.Branding WHERE SettingsId = 1)
    BEGIN
        UPDATE dbo.Branding
        SET LogoBase64 = @LogoBase64,
            UpdatedOn = sysutcdatetime()
        WHERE SettingsId = 1;
    END
    ELSE
    BEGIN
        INSERT INTO dbo.Branding (SettingsId, LogoBase64)
        VALUES (1, @LogoBase64);
    END

    SELECT SettingsId, LogoBase64, UpdatedOn
    FROM dbo.Branding
    WHERE SettingsId = 1;
END
