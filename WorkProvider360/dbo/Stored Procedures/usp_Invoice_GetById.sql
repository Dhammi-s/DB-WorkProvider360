/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


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
