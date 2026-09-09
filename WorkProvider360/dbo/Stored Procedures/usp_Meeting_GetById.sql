/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE PROCEDURE dbo.usp_Meeting_GetById
    @MeetingId INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Single result set (participants fetched separately via usp_Meeting_GetParticipants)
    SELECT m.MeetingId, m.Title, m.Description, m.StartUtc, m.EndUtc,
           m.Location, m.MeetingType, m.Status, m.IsPaid, m.FeePerParticipant,
           m.CreatedByUserId, m.CreatedByName, m.MaxParticipants,
           m.Notes, m.ColorTag, m.CreatedOn, m.UpdatedOn,
           (SELECT COUNT(*) FROM dbo.MeetingParticipants mp
            WHERE mp.MeetingId = m.MeetingId) AS ParticipantCount
    FROM   dbo.Meetings m
    WHERE  m.MeetingId = @MeetingId;
END
