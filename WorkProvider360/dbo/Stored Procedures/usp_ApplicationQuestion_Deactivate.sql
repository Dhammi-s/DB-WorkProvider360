
CREATE   PROCEDURE dbo.usp_ApplicationQuestion_Deactivate
    @QuestionId INT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.ApplicationQuestions SET IsActive = 0 WHERE QuestionId = @QuestionId;
END
