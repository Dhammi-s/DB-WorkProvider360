/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


CREATE   PROCEDURE dbo.usp_Branding_Get
AS
BEGIN
    SET NOCOUNT ON;
    SELECT SettingsId, LogoBase64, UpdatedOn
    FROM dbo.Branding
    WHERE SettingsId = 1;
END
