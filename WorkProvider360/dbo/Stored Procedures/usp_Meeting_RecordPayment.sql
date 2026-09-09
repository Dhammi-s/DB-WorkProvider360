/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE PROCEDURE dbo.usp_Meeting_RecordPayment
    @MeetingId         INT,
    @ParticipantId     INT,
    @Amount            DECIMAL (10, 2),
    @Method            NVARCHAR (20),
    @Status            NVARCHAR (20),
    @TransactionId     NVARCHAR (200),
    @Notes             NVARCHAR (MAX),
    @PaidAt            DATETIME2 (7),
    @RecordedByUserId  INT,
    @RecordedByName    NVARCHAR (200)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.MeetingPayments
           (MeetingId, ParticipantId, Amount, Method, Status,
            TransactionId, Notes, PaidAt, RecordedByUserId, RecordedByName)
    VALUES (@MeetingId, NULLIF(@ParticipantId, 0), @Amount, @Method, @Status,
            NULLIF(@TransactionId, ''), @Notes, @PaidAt,
            @RecordedByUserId, @RecordedByName);

    -- Mark participant as paid if this payment is confirmed
    IF @Status = N'Paid' AND @ParticipantId > 0
    BEGIN
        UPDATE dbo.MeetingParticipants
        SET    IsPaid        = 1,
               PaymentAmount = @Amount,
               PaymentDate   = ISNULL(@PaidAt, sysutcdatetime()),
               PaymentMethod = @Method
        WHERE  ParticipantId = @ParticipantId;
    END

    SELECT SCOPE_IDENTITY() AS PaymentId;
END
