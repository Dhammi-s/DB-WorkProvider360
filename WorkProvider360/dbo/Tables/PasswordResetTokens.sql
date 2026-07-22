CREATE TABLE [dbo].[PasswordResetTokens] (
    [PasswordResetTokenId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [UserId]               INT            NOT NULL,
    [Token]                NVARCHAR (200) NOT NULL,
    [ExpiresOn]            DATETIME2 (7)  NOT NULL,
    [IsUsed]               BIT            CONSTRAINT [DF_PasswordResetTokens_IsUsed] DEFAULT ((0)) NOT NULL,
    [CreatedOn]            DATETIME2 (7)  CONSTRAINT [DF_PasswordResetTokens_CreatedOn] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_PasswordResetTokens] PRIMARY KEY CLUSTERED ([PasswordResetTokenId] ASC),
    CONSTRAINT [FK_PasswordResetTokens_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])
);


GO
CREATE NONCLUSTERED INDEX [IX_PasswordResetTokens_UserId_Token]
    ON [dbo].[PasswordResetTokens]([UserId] ASC, [Token] ASC);

