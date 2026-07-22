
/* ------------------------ PasswordResetTokens ---------------------------- */
CREATE   PROCEDURE dbo.usp_PasswordResetToken_Create
    @UserId    INT,
    @Token     NVARCHAR(200),
    @ExpiresOn DATETIME2(7)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.PasswordResetTokens (UserId, Token, ExpiresOn)
    VALUES (@UserId, @Token, @ExpiresOn);

    SELECT CAST(SCOPE_IDENTITY() AS BIGINT);
END
