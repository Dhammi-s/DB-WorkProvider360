
CREATE   PROCEDURE dbo.usp_Branding_Get
AS
BEGIN
    SET NOCOUNT ON;
    SELECT SettingsId, LogoBase64, UpdatedOn
    FROM dbo.Branding
    WHERE SettingsId = 1;
END
