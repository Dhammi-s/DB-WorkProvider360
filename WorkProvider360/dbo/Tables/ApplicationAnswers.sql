/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

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

