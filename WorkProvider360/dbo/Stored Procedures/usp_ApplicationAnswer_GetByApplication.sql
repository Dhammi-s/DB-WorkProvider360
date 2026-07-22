
CREATE   PROCEDURE dbo.usp_ApplicationAnswer_GetByApplication
    @ApplicationId INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT AnswerId, ApplicationId, QuestionId, QuestionText, AnswerText
    FROM dbo.ApplicationAnswers
    WHERE ApplicationId = @ApplicationId
    ORDER BY AnswerId;
END
