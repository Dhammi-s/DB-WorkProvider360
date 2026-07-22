
CREATE   PROCEDURE dbo.usp_ApplicationQuestion_GetAll
AS
BEGIN
    SET NOCOUNT ON;
    SELECT QuestionId, QuestionText, IsRequired, IsActive, SortOrder, CreatedOn
    FROM dbo.ApplicationQuestions
    ORDER BY SortOrder, QuestionId;
END
