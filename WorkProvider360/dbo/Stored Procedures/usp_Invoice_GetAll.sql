
CREATE   PROCEDURE dbo.usp_Invoice_GetAll
AS
BEGIN
    SET NOCOUNT ON;
    -- List view: omit the heavy PdfBase64 column.
    SELECT
        InvoiceId, InvoiceNumber, RecipientUserId, RecipientName, RecipientEmail, RecipientRoleName,
        InvoiceType, Amount, RegularHours, OvertimeHours, TotalHours, PeriodFrom, PeriodTo,
        Details, Status, PaymentMethod, CreatedByUserId, CreatedOn, PaidOn
    FROM dbo.Invoice
    ORDER BY CreatedOn DESC;
END
