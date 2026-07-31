/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


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
