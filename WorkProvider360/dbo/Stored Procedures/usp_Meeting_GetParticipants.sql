/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE PROCEDURE dbo.usp_Meeting_GetParticipants
    @MeetingId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT ParticipantId, MeetingId, UserId, ClientId, ParticipantName,
           ParticipantEmail, RoleName, ParticipantRole, Status,
           IsPaid, PaymentAmount, PaymentDate, PaymentMethod,
           InvitedAt, RespondedAt
    FROM   dbo.MeetingParticipants
    WHERE  MeetingId = @MeetingId
    ORDER  BY InvitedAt ASC;
END
