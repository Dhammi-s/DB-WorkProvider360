
CREATE   PROCEDURE dbo.usp_Invoice_GetById
    @InvoiceId UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON;
    SELECT
        InvoiceId, InvoiceNumber, RecipientUserId, RecipientName, RecipientEmail, RecipientRoleName,
        InvoiceType, Amount, RegularHours, OvertimeHours, TotalHours, PeriodFrom, PeriodTo,
        Details, PdfBase64, Status, PaymentMethod, CreatedByUserId, CreatedOn, PaidOn
    FROM dbo.Invoice
    WHERE InvoiceId = @InvoiceId;
END
