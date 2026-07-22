CREATE TABLE [dbo].[ApplicationQuestions] (
    [QuestionId]   INT            IDENTITY (1, 1) NOT NULL,
    [QuestionText] NVARCHAR (500) NOT NULL,
    [IsRequired]   BIT            CONSTRAINT [DF_AppQuestions_IsRequired] DEFAULT ((1)) NOT NULL,
    [IsActive]     BIT            CONSTRAINT [DF_AppQuestions_IsActive] DEFAULT ((1)) NOT NULL,
    [SortOrder]    INT            CONSTRAINT [DF_AppQuestions_SortOrder] DEFAULT ((0)) NOT NULL,
    [CreatedOn]    DATETIME2 (7)  CONSTRAINT [DF_AppQuestions_CreatedOn] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_ApplicationQuestions] PRIMARY KEY CLUSTERED ([QuestionId] ASC)
);

