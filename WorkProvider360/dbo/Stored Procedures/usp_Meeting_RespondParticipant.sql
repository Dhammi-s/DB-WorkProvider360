/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE PROCEDURE dbo.usp_Meeting_RespondParticipant
    @MeetingId INT,
    @UserId    INT,
    @Status    NVARCHAR (20)
AS
BEGIN
    SET NOCOUNT ON;

    -- A user can respond to their own invitation; hosts cannot change their own status this way
    UPDATE dbo.MeetingParticipants
    SET    Status      = @Status,
           RespondedAt = sysutcdatetime()
    WHERE  MeetingId       = @MeetingId
      AND  UserId          = @UserId
      AND  ParticipantRole != N'Host';

    -- Caller checks @@ROWCOUNT to detect "not a participant / is host"
    SELECT @@ROWCOUNT AS RowsAffected;
END
