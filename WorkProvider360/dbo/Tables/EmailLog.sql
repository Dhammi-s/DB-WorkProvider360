CREATE TABLE [dbo].[EmailLog] (
    [EmailLogId]   UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [ToAddress]    NVARCHAR (256)   NOT NULL,
    [Subject]      NVARCHAR (300)   NULL,
    [Body]         NVARCHAR (MAX)   NULL,
    [Status]       NVARCHAR (20)    NOT NULL,   -- Sent / Failed
    [ErrorMessage] NVARCHAR (2000)  NULL,
    [CreatedOn]    DATETIME2 (7)    CONSTRAINT [DF_EmailLog_CreatedOn] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_EmailLog] PRIMARY KEY CLUSTERED ([EmailLogId] ASC)
);
GO
CREATE NONCLUSTERED INDEX [IX_EmailLog_CreatedOn]
    ON [dbo].[EmailLog]([CreatedOn] DESC);
