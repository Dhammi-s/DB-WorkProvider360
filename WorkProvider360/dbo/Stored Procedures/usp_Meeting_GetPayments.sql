/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE PROCEDURE dbo.usp_Meeting_GetPayments
    @MeetingId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT pay.PaymentId,
           pay.MeetingId,
           pay.ParticipantId,
           pay.Amount,
           pay.Method,
           pay.Status,
           pay.TransactionId,
           pay.Notes,
           pay.PaidAt,
           pay.RecordedByUserId,
           pay.RecordedByName,
           -- Participant info (joined for display)
           mp.UserId                                                                        AS ParticipantUserId,
           ISNULL(mp.ParticipantName, u.FullName)                                          AS ParticipantName,
           mp.ClientId                                                                      AS ParticipantClientId,
           NULLIF(RTRIM(ISNULL(c.FirstName, N'') + N' ' + ISNULL(c.LastName, N'')), N'')  AS ParticipantClientName
    FROM   dbo.MeetingPayments pay
    LEFT JOIN dbo.MeetingParticipants mp ON mp.ParticipantId = pay.ParticipantId
    LEFT JOIN dbo.Users               u  ON u.UserId         = mp.UserId
    LEFT JOIN dbo.Clients             c  ON c.ClientId       = mp.ClientId
    WHERE  pay.MeetingId = @MeetingId
    ORDER  BY pay.RecordedAt DESC;
END
