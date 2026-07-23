CREATE TABLE [dbo].[Invoice] (
    [InvoiceId]         UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [InvoiceNumber]     NVARCHAR (40)    NOT NULL,
    [RecipientUserId]   INT              NULL,
    [RecipientName]     NVARCHAR (200)   NOT NULL,
    [RecipientEmail]    NVARCHAR (256)   NOT NULL,
    [RecipientRoleName] NVARCHAR (50)    NULL,
    [InvoiceType]       NVARCHAR (20)    NOT NULL,   -- Salary | ShiftPay
    [Amount]            DECIMAL (10, 2)  NOT NULL,
    [RegularHours]      DECIMAL (10, 2)  NULL,
    [OvertimeHours]     DECIMAL (10, 2)  NULL,
    [TotalHours]        DECIMAL (10, 2)  NULL,
    [PeriodFrom]        DATETIME2 (7)    NULL,
    [PeriodTo]          DATETIME2 (7)    NULL,
    [Details]           NVARCHAR (MAX)   NULL,
    [PdfBase64]         NVARCHAR (MAX)   NULL,
    [Status]            NVARCHAR (20)    CONSTRAINT [DF_Invoice_Status] DEFAULT (N'Paid') NOT NULL,
    [PaymentMethod]     NVARCHAR (20)    NOT NULL,   -- Cash | Online
    [CreatedByUserId]   INT              NULL,
    [CreatedOn]         DATETIME2 (7)    CONSTRAINT [DF_Invoice_CreatedOn] DEFAULT (sysutcdatetime()) NOT NULL,
    [PaidOn]            DATETIME2 (7)    NULL,
    CONSTRAINT [PK_Invoice] PRIMARY KEY CLUSTERED ([InvoiceId] ASC)
);
GO
CREATE NONCLUSTERED INDEX [IX_Invoice_CreatedOn]
    ON [dbo].[Invoice]([CreatedOn] DESC);
