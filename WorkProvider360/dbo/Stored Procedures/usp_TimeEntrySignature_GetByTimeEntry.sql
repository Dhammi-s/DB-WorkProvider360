/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-09-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE   PROCEDURE dbo.usp_TimeEntrySignature_GetByTimeEntry
    @TimeEntryId INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT SignatureId, TimeEntryId, Phase, SignatureBase64, SignedByName, SignedOnUtc
    FROM dbo.TimeEntrySignatures
    WHERE TimeEntryId = @TimeEntryId
    ORDER BY SignedOnUtc;
END
