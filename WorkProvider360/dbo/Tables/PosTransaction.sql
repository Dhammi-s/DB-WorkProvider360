CREATE TABLE [dbo].[PosTransaction] (
    [PosTransactionId] UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [PayerName]        NVARCHAR (200)   NOT NULL,
    [PayerEmail]       NVARCHAR (256)   NULL,
    [Description]      NVARCHAR (300)   NULL,
    [GrossAmount]      DECIMAL (10, 2)  NOT NULL,
    [FeePercent]       DECIMAL (5, 2)   NOT NULL,   -- snapshot at time of sale
    [FeeFixed]         DECIMAL (10, 2)  NOT NULL,
    [PlatformFee]      DECIMAL (10, 2)  NOT NULL,   -- what the platform earns
    [NetAmount]        DECIMAL (10, 2)  NOT NULL,   -- what the merchant/agency keeps
    [CardLast4]        NVARCHAR (4)     NULL,
    [Status]           NVARCHAR (20)    NOT NULL,   -- Approved | Declined
    [DeclineReason]    NVARCHAR (200)   NULL,
    [Provider]         NVARCHAR (40)    NOT NULL,   -- Mock (sandbox) | Stripe | Bank...
    [ProviderRef]      NVARCHAR (100)   NULL,
    [CreatedByUserId]  INT              NULL,
    [CreatedOn]        DATETIME2 (7)    CONSTRAINT [DF_PosTransaction_CreatedOn] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_PosTransaction] PRIMARY KEY CLUSTERED ([PosTransactionId] ASC)
);
GO
CREATE NONCLUSTERED INDEX [IX_PosTransaction_CreatedOn]
    ON [dbo].[PosTransaction]([CreatedOn] DESC);
