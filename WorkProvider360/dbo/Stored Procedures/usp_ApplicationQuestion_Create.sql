
CREATE   PROCEDURE dbo.usp_ApplicationQuestion_Create
    @QuestionText NVARCHAR(500),
    @IsRequired   BIT,
    @SortOrder    INT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.ApplicationQuestions (QuestionText, IsRequired, IsActive, SortOrder)
    VALUES (@QuestionText, @IsRequired, 1, @SortOrder);

    SELECT CAST(SCOPE_IDENTITY() AS INT);
END
