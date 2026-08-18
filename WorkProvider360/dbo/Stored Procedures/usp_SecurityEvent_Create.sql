/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


/* ---------------------------- SecurityEvents ----------------------------- */
CREATE   PROCEDURE dbo.usp_SecurityEvent_Create
    @EventType NVARCHAR(40),
    @Email     NVARCHAR(256) = NULL,
    @UserId    INT           = NULL,
    @IpAddress NVARCHAR(64)  = NULL,
    @UserAgent NVARCHAR(512) = NULL,
    @Path      NVARCHAR(300) = NULL,
    @Detail    NVARCHAR(1000)= NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.SecurityEvents (EventType, Email, UserId, IpAddress, UserAgent, Path, Detail)
    VALUES (@EventType, @Email, @UserId, @IpAddress, @UserAgent, @Path, @Detail);
END
