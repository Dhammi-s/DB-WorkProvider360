
CREATE   PROCEDURE dbo.usp_PosTransaction_GetAll
AS
BEGIN
    SET NOCOUNT ON;
    SELECT
        PosTransactionId, PayerName, PayerEmail, Description, GrossAmount, FeePercent, FeeFixed,
        PlatformFee, NetAmount, CardLast4, Status, DeclineReason, Provider, ProviderRef, CreatedByUserId, CreatedOn
    FROM dbo.PosTransaction
    ORDER BY CreatedOn DESC;
END
