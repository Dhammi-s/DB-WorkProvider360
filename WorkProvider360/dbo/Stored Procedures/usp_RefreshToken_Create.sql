
/* --------------------------- RefreshTokens ------------------------------- */
CREATE   PROCEDURE dbo.usp_RefreshToken_Create
    @UserId    INT,
    @Token     NVARCHAR(200),
    @ExpiresOn DATETIME2(7)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.RefreshTokens (UserId, Token, ExpiresOn)
    VALUES (@UserId, @Token, @ExpiresOn);

    SELECT CAST(SCOPE_IDENTITY() AS BIGINT);
END
