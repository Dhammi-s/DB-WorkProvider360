
/* ------------------------- ApplicationQuestions -------------------------- */
CREATE   PROCEDURE dbo.usp_ApplicationQuestion_GetActive
AS
BEGIN
    SET NOCOUNT ON;
    SELECT QuestionId, QuestionText, IsRequired, IsActive, SortOrder, CreatedOn
    FROM dbo.ApplicationQuestions
    WHERE IsActive = 1
    ORDER BY SortOrder, QuestionId;
END
