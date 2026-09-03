/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-09-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

/* --------------------------- TimeEntrySignatures ------------------------- */
/* One signature per time entry and phase (ClockIn | ClockOut). Re-signing the
   same phase replaces the earlier image instead of failing on the unique key. */
CREATE   PROCEDURE dbo.usp_TimeEntrySignature_Create
    @TimeEntryId     INT,
    @Phase           NVARCHAR(10),
    @SignatureBase64 NVARCHAR(MAX),
    @SignedByName    NVARCHAR(200) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @SignatureId INT = (SELECT SignatureId FROM dbo.TimeEntrySignatures
                                WHERE TimeEntryId = @TimeEntryId AND Phase = @Phase);

    IF @SignatureId IS NOT NULL
    BEGIN
        UPDATE dbo.TimeEntrySignatures
        SET SignatureBase64 = @SignatureBase64,
            SignedByName = @SignedByName,
            SignedOnUtc = SYSUTCDATETIME()
        WHERE SignatureId = @SignatureId;

        SELECT @SignatureId;
        RETURN;
    END

    INSERT INTO dbo.TimeEntrySignatures (TimeEntryId, Phase, SignatureBase64, SignedByName)
    VALUES (@TimeEntryId, @Phase, @SignatureBase64, @SignedByName);

    SELECT CAST(SCOPE_IDENTITY() AS INT);
END
