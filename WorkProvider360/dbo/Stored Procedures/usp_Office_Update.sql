/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


CREATE   PROCEDURE dbo.usp_Office_Update
    @OfficeId   UNIQUEIDENTIFIER,
    @OfficeName NVARCHAR(200),
    @Address    NVARCHAR(500)    = NULL,
    @Phone      NVARCHAR(50)     = NULL,
    @TimezoneId UNIQUEIDENTIFIER = NULL,
    @IsActive   BIT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.Office
    SET OfficeName = @OfficeName,
        Address    = @Address,
        Phone      = @Phone,
        TimezoneId = @TimezoneId,
        IsActive   = @IsActive,
        UpdatedOn  = sysutcdatetime()
    WHERE OfficeId = @OfficeId;
END
