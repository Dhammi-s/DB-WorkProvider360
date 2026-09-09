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

    SELECT mp.ParticipantId,
           mp.MeetingId,
           mp.UserId,
           ISNULL(mp.ParticipantName,  u.FullName)                          AS ParticipantName,
           ISNULL(mp.ParticipantEmail, u.Email)                             AS ParticipantEmail,
           mp.RoleName                                                       AS ParticipantRoleName,
           mp.ClientId,
           NULLIF(RTRIM(ISNULL(c.FirstName, N'') + N' ' + ISNULL(c.LastName, N'')), N'') AS ClientName,
           c.Email                                                           AS ClientEmail,
           mp.ParticipantRole,
           mp.Status,
           mp.IsPaid,
           mp.PaymentAmount,
           mp.PaymentDate,
           mp.PaymentMethod,
           mp.InvitedAt,
           mp.RespondedAt
    FROM   dbo.MeetingParticipants mp
    LEFT JOIN dbo.Users   u ON u.UserId   = mp.UserId
    LEFT JOIN dbo.Clients c ON c.ClientId = mp.ClientId
    WHERE  mp.MeetingId = @MeetingId
    ORDER  BY mp.InvitedAt ASC;
END
