
CREATE   PROCEDURE dbo.usp_PosTransaction_Create
    @PayerName       NVARCHAR(200),
    @PayerEmail      NVARCHAR(256)  = NULL,
    @Description     NVARCHAR(300)  = NULL,
    @GrossAmount     DECIMAL(10,2),
    @FeePercent      DECIMAL(5,2),
    @FeeFixed        DECIMAL(10,2),
    @PlatformFee     DECIMAL(10,2),
    @NetAmount       DECIMAL(10,2),
    @CardLast4       NVARCHAR(4)    = NULL,
    @Status          NVARCHAR(20),
    @DeclineReason   NVARCHAR(200)  = NULL,
    @Provider        NVARCHAR(40),
    @ProviderRef     NVARCHAR(100)  = NULL,
    @CreatedByUserId INT            = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @NewId UNIQUEIDENTIFIER = NEWID();

    INSERT INTO dbo.PosTransaction
        (PosTransactionId, PayerName, PayerEmail, Description, GrossAmount, FeePercent, FeeFixed,
         PlatformFee, NetAmount, CardLast4, Status, DeclineReason, Provider, ProviderRef, CreatedByUserId)
    VALUES
        (@NewId, @PayerName, @PayerEmail, @Description, @GrossAmount, @FeePercent, @FeeFixed,
         @PlatformFee, @NetAmount, @CardLast4, @Status, @DeclineReason, @Provider, @ProviderRef, @CreatedByUserId);

    SELECT @NewId;
END
