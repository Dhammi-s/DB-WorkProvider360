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
    @PaidAt            DATETIME2 (7)   = NULL,    -- defaults to now when paid
    @RecordedByUserId  INT,
    @RecordedByName    NVARCHAR (200)  = NULL     -- resolved from Users if not supplied
AS
BEGIN
    SET NOCOUNT ON;

    -- Resolve recorder name if not supplied
    DECLARE @resolvedName NVARCHAR (200) = @RecordedByName;
    IF @resolvedName IS NULL
        SELECT @resolvedName = FullName FROM dbo.Users WHERE UserId = @RecordedByUserId;

    -- Use now as PaidAt when status is Paid but caller sent NULL
    DECLARE @effectivePaidAt DATETIME2 (7) =
        CASE WHEN @Status = N'Paid' THEN ISNULL(@PaidAt, sysutcdatetime()) ELSE @PaidAt END;

    INSERT INTO dbo.MeetingPayments
           (MeetingId, ParticipantId, Amount, Method, Status,
            TransactionId, Notes, PaidAt, RecordedByUserId, RecordedByName)
    VALUES (@MeetingId, NULLIF(@ParticipantId, 0), @Amount, @Method, @Status,
            NULLIF(@TransactionId, N''), @Notes, @effectivePaidAt,
            @RecordedByUserId, @resolvedName);

    -- Sync participant paid flag when payment is confirmed
    IF @Status = N'Paid' AND @ParticipantId > 0
    BEGIN
        UPDATE dbo.MeetingParticipants
        SET    IsPaid        = 1,
               PaymentAmount = @Amount,
               PaymentDate   = @effectivePaidAt,
               PaymentMethod = @Method
        WHERE  ParticipantId = @ParticipantId;
    END

    SELECT SCOPE_IDENTITY() AS PaymentId;
END
