
CREATE   PROCEDURE dbo.usp_ApplicationQuestion_GetById
    @QuestionId INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT QuestionId, QuestionText, IsRequired, IsActive, SortOrder, CreatedOn
    FROM dbo.ApplicationQuestions
    WHERE QuestionId = @QuestionId;
END
