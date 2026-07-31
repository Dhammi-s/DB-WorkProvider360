/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


CREATE   PROCEDURE dbo.usp_LoginContent_Get
AS
BEGIN
    SET NOCOUNT ON;
    SELECT SettingsId, HeadlineLead, HeadlineHighlight, HeadlineTrail, Subtitle,
           Stat1Label, Stat1Value, Stat2Label, Stat2Value, Stat3Label, Stat3Value,
           QuoteText, QuoteAuthor, QuoteRole, UpdatedOn
    FROM dbo.LoginPageContent
    WHERE SettingsId = 1;
END
