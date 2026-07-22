CREATE TABLE [dbo].[RefreshTokens] (
    [RefreshTokenId] BIGINT         IDENTITY (1, 1) NOT NULL,
    [UserId]         INT            NOT NULL,
    [Token]          NVARCHAR (200) NOT NULL,
    [ExpiresOn]      DATETIME2 (7)  NOT NULL,
    [IsRevoked]      BIT            CONSTRAINT [DF_RefreshTokens_IsRevoked] DEFAULT ((0)) NOT NULL,
    [CreatedOn]      DATETIME2 (7)  CONSTRAINT [DF_RefreshTokens_CreatedOn] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_RefreshTokens] PRIMARY KEY CLUSTERED ([RefreshTokenId] ASC),
    CONSTRAINT [FK_RefreshTokens_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])
);


GO
CREATE NONCLUSTERED INDEX [IX_RefreshTokens_UserId_Token]
    ON [dbo].[RefreshTokens]([UserId] ASC, [Token] ASC);

