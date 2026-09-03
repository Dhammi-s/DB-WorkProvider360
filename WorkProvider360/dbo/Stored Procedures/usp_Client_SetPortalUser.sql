/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-09-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

/* Links (or keeps) the portal login and flips the per-client portal switch. */
CREATE   PROCEDURE dbo.usp_Client_SetPortalUser
    @ClientId      INT,
    @UserId        INT = NULL,
    @PortalEnabled BIT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.Clients
    SET UserId = COALESCE(@UserId, UserId),
        PortalEnabled = @PortalEnabled,
        UpdatedOn = SYSUTCDATETIME()
    WHERE ClientId = @ClientId;
END
