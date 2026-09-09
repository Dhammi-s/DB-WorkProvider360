/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE PROCEDURE dbo.usp_Meeting_AddParticipant
    @MeetingId       INT,
    @UserId          INT,
    @ClientId        INT,
    @ParticipantName NVARCHAR (200),
    @ParticipantEmail NVARCHAR (200),
    @RoleName        NVARCHAR (100),
    @ParticipantRole NVARCHAR (20)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.MeetingParticipants
           (MeetingId, UserId, ClientId, ParticipantName, ParticipantEmail,
            RoleName, ParticipantRole)
    VALUES (@MeetingId, NULLIF(@UserId, 0), NULLIF(@ClientId, 0),
            @ParticipantName, @ParticipantEmail, @RoleName, @ParticipantRole);

    SELECT SCOPE_IDENTITY() AS ParticipantId;
END
