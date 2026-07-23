
CREATE   PROCEDURE dbo.usp_EmailLog_Create
    @ToAddress    NVARCHAR(256),
    @Subject      NVARCHAR(300)  = NULL,
    @Body         NVARCHAR(MAX)  = NULL,
    @Status       NVARCHAR(20),
    @ErrorMessage NVARCHAR(2000) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.EmailLog (ToAddress, Subject, Body, Status, ErrorMessage)
    VALUES (@ToAddress, @Subject, @Body, @Status, @ErrorMessage);
END
