CREATE TABLE [dbo].[LoginPageContent] (
    [SettingsId]        INT             NOT NULL,
    [HeadlineLead]      NVARCHAR (100)  NULL,
    [HeadlineHighlight] NVARCHAR (100)  NULL,
    [HeadlineTrail]     NVARCHAR (100)  NULL,
    [Subtitle]          NVARCHAR (500)  NULL,
    [Stat1Label]        NVARCHAR (60)   NULL,
    [Stat1Value]        NVARCHAR (40)   NULL,
    [Stat2Label]        NVARCHAR (60)   NULL,
    [Stat2Value]        NVARCHAR (40)   NULL,
    [Stat3Label]        NVARCHAR (60)   NULL,
    [Stat3Value]        NVARCHAR (40)   NULL,
    [QuoteText]         NVARCHAR (600)  NULL,
    [QuoteAuthor]       NVARCHAR (100)  NULL,
    [QuoteRole]         NVARCHAR (150)  NULL,
    [UpdatedOn]         DATETIME2 (7)   CONSTRAINT [DF_LoginPageContent_UpdatedOn] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_LoginPageContent] PRIMARY KEY CLUSTERED ([SettingsId] ASC)
);
