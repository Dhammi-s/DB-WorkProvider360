
CREATE   PROCEDURE dbo.usp_LoginContent_Upsert
    @HeadlineLead      NVARCHAR(100),
    @HeadlineHighlight NVARCHAR(100),
    @HeadlineTrail     NVARCHAR(100),
    @Subtitle          NVARCHAR(500),
    @Stat1Label        NVARCHAR(60),
    @Stat1Value        NVARCHAR(40),
    @Stat2Label        NVARCHAR(60),
    @Stat2Value        NVARCHAR(40),
    @Stat3Label        NVARCHAR(60),
    @Stat3Value        NVARCHAR(40),
    @QuoteText         NVARCHAR(600),
    @QuoteAuthor       NVARCHAR(100),
    @QuoteRole         NVARCHAR(150)
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM dbo.LoginPageContent WHERE SettingsId = 1)
        INSERT INTO dbo.LoginPageContent (SettingsId) VALUES (1);

    UPDATE dbo.LoginPageContent
    SET HeadlineLead = @HeadlineLead,
        HeadlineHighlight = @HeadlineHighlight,
        HeadlineTrail = @HeadlineTrail,
        Subtitle = @Subtitle,
        Stat1Label = @Stat1Label, Stat1Value = @Stat1Value,
        Stat2Label = @Stat2Label, Stat2Value = @Stat2Value,
        Stat3Label = @Stat3Label, Stat3Value = @Stat3Value,
        QuoteText = @QuoteText, QuoteAuthor = @QuoteAuthor, QuoteRole = @QuoteRole,
        UpdatedOn = SYSUTCDATETIME()
    WHERE SettingsId = 1;

    EXEC dbo.usp_LoginContent_Get;
END
