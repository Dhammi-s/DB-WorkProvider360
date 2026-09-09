/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE PROCEDURE dbo.usp_Meeting_GetAll
    @FromUtc             DATETIME2 (7) = NULL,
    @ToUtc               DATETIME2 (7) = NULL,
    @Status              NVARCHAR (20) = NULL,
    @CreatedByUserId     INT           = NULL,
    @ParticipantUserId   INT           = NULL,
    @ParticipantClientId INT           = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT m.MeetingId, m.Title, m.Description, m.StartUtc, m.EndUtc,
           m.Location, m.MeetingType, m.Status, m.IsPaid, m.FeePerParticipant,
           m.CreatedByUserId, m.CreatedByName, m.MaxParticipants,
           m.Notes, m.ColorTag, m.CreatedOn, m.UpdatedOn,
           (SELECT COUNT(*) FROM dbo.MeetingParticipants mp
            WHERE mp.MeetingId = m.MeetingId) AS ParticipantCount
    FROM   dbo.Meetings m
    WHERE  (@FromUtc IS NULL OR m.StartUtc >= @FromUtc)
      AND  (@ToUtc   IS NULL OR m.EndUtc   <= @ToUtc)
      AND  (@Status  IS NULL OR m.Status   = @Status)
      AND  (@CreatedByUserId IS NULL OR m.CreatedByUserId = @CreatedByUserId)
      AND  (@ParticipantUserId IS NULL OR EXISTS (
               SELECT 1 FROM dbo.MeetingParticipants p
               WHERE p.MeetingId = m.MeetingId AND p.UserId = @ParticipantUserId))
      AND  (@ParticipantClientId IS NULL OR EXISTS (
               SELECT 1 FROM dbo.MeetingParticipants p
               WHERE p.MeetingId = m.MeetingId AND p.ClientId = @ParticipantClientId))
    ORDER  BY m.StartUtc DESC;
END
