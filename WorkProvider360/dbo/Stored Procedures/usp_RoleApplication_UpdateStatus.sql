/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


CREATE   PROCEDURE dbo.usp_RoleApplication_UpdateStatus
    @ApplicationId    INT,
    @Status           NVARCHAR(20),
    @RejectionReason  NVARCHAR(1000) = NULL,
    @ReviewedByUserId INT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.RoleApplications
    SET Status = @Status,
        RejectionReason = @RejectionReason,
        ReviewedByUserId = @ReviewedByUserId,
        ReviewedOn = SYSUTCDATETIME()
    WHERE ApplicationId = @ApplicationId;
END
