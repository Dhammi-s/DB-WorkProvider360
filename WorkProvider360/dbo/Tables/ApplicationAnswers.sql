CREATE TABLE [dbo].[ApplicationAnswers] (
    [AnswerId]      INT             IDENTITY (1, 1) NOT NULL,
    [ApplicationId] INT             NOT NULL,
    [QuestionId]    INT             NULL,
    [QuestionText]  NVARCHAR (500)  NOT NULL,
    [AnswerText]    NVARCHAR (2000) NULL,
    CONSTRAINT [PK_ApplicationAnswers] PRIMARY KEY CLUSTERED ([AnswerId] ASC),
    CONSTRAINT [FK_ApplicationAnswers_Applications] FOREIGN KEY ([ApplicationId]) REFERENCES [dbo].[RoleApplications] ([ApplicationId])
);


GO
CREATE NONCLUSTERED INDEX [IX_ApplicationAnswers_ApplicationId]
    ON [dbo].[ApplicationAnswers]([ApplicationId] ASC);

