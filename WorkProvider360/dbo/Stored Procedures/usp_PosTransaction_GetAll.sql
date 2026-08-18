/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


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
