
/* --------------------------- ApplicationAnswers -------------------------- */
CREATE   PROCEDURE dbo.usp_ApplicationAnswer_Create
    @ApplicationId INT,
    @QuestionId    INT = NULL,
    @QuestionText  NVARCHAR(500),
    @AnswerText    NVARCHAR(2000) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.ApplicationAnswers (ApplicationId, QuestionId, QuestionText, AnswerText)
    VALUES (@ApplicationId, @QuestionId, @QuestionText, @AnswerText);

    SELECT CAST(SCOPE_IDENTITY() AS INT);
END
