/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE PROCEDURE dbo.usp_Meeting_AddParticipant
    @MeetingId        INT,
    @UserId           INT           = NULL,
    @ClientId         INT           = NULL,
    @ParticipantRole  NVARCHAR (20),
    @ParticipantName  NVARCHAR (200) = NULL,   -- resolved from Users/Clients if not supplied
    @ParticipantEmail NVARCHAR (200) = NULL,   -- resolved from Users/Clients if not supplied
    @RoleName         NVARCHAR (100) = NULL    -- system role of the invited user
AS
BEGIN
    SET NOCOUNT ON;

    -- Guard: already a participant?
    IF EXISTS (
        SELECT 1 FROM dbo.MeetingParticipants
        WHERE MeetingId = @MeetingId
          AND ((@UserId   IS NOT NULL AND UserId   = @UserId)
           OR  (@ClientId IS NOT NULL AND ClientId = @ClientId)))
    BEGIN
        SELECT -1 AS ParticipantId;
        RETURN;
    END

    -- Resolve name/email from source tables if not explicitly supplied
    DECLARE @resolvedName  NVARCHAR (200) = @ParticipantName;
    DECLARE @resolvedEmail NVARCHAR (200) = @ParticipantEmail;
    DECLARE @resolvedRole  NVARCHAR (100) = @RoleName;

    IF @UserId IS NOT NULL AND (@resolvedName IS NULL OR @resolvedEmail IS NULL OR @resolvedRole IS NULL)
    BEGIN
        SELECT @resolvedName  = ISNULL(@resolvedName,  u.FullName),
               @resolvedEmail = ISNULL(@resolvedEmail, u.Email),
               @resolvedRole  = ISNULL(@resolvedRole,  r.RoleName)
        FROM   dbo.Users u
        JOIN   dbo.Roles r ON r.RoleId = u.RoleId
        WHERE  u.UserId = @UserId;
    END

    IF @ClientId IS NOT NULL AND (@resolvedName IS NULL OR @resolvedEmail IS NULL)
    BEGIN
        SELECT @resolvedName  = ISNULL(@resolvedName,  c.FirstName + N' ' + c.LastName),
               @resolvedEmail = ISNULL(@resolvedEmail, c.Email)
        FROM   dbo.Clients c
        WHERE  c.ClientId = @ClientId;
    END

    INSERT INTO dbo.MeetingParticipants
           (MeetingId, UserId, ClientId, ParticipantName, ParticipantEmail,
            RoleName, ParticipantRole)
    VALUES (@MeetingId, @UserId, @ClientId, @resolvedName, @resolvedEmail,
            @resolvedRole, @ParticipantRole);

    SELECT SCOPE_IDENTITY() AS ParticipantId;
END
