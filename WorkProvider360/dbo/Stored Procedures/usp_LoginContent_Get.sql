
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
