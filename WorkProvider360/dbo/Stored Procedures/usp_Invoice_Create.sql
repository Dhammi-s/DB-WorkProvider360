
CREATE   PROCEDURE dbo.usp_Invoice_Create
    @InvoiceNumber     NVARCHAR(40),
    @RecipientUserId   INT             = NULL,
    @RecipientName     NVARCHAR(200),
    @RecipientEmail    NVARCHAR(256),
    @RecipientRoleName NVARCHAR(50)    = NULL,
    @InvoiceType       NVARCHAR(20),
    @Amount            DECIMAL(10,2),
    @RegularHours      DECIMAL(10,2)   = NULL,
    @OvertimeHours     DECIMAL(10,2)   = NULL,
    @TotalHours        DECIMAL(10,2)   = NULL,
    @PeriodFrom        DATETIME2(7)    = NULL,
    @PeriodTo          DATETIME2(7)    = NULL,
    @Details           NVARCHAR(MAX)   = NULL,
    @PdfBase64         NVARCHAR(MAX)   = NULL,
    @PaymentMethod     NVARCHAR(20),
    @CreatedByUserId   INT             = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @NewId UNIQUEIDENTIFIER = NEWID();

    INSERT INTO dbo.Invoice
        (InvoiceId, InvoiceNumber, RecipientUserId, RecipientName, RecipientEmail, RecipientRoleName,
         InvoiceType, Amount, RegularHours, OvertimeHours, TotalHours, PeriodFrom, PeriodTo,
         Details, PdfBase64, Status, PaymentMethod, CreatedByUserId, PaidOn)
    VALUES
        (@NewId, @InvoiceNumber, @RecipientUserId, @RecipientName, @RecipientEmail, @RecipientRoleName,
         @InvoiceType, @Amount, @RegularHours, @OvertimeHours, @TotalHours, @PeriodFrom, @PeriodTo,
         @Details, @PdfBase64, N'Paid', @PaymentMethod, @CreatedByUserId, sysutcdatetime());

    SELECT @NewId;
END
