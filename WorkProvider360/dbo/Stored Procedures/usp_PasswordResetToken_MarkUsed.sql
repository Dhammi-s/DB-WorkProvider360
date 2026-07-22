
CREATE   PROCEDURE dbo.usp_PasswordResetToken_MarkUsed
    @PasswordResetTokenId BIGINT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.PasswordResetTokens SET IsUsed = 1 WHERE PasswordResetTokenId = @PasswordResetTokenId;
END
