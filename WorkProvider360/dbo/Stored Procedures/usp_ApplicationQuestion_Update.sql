
CREATE   PROCEDURE dbo.usp_ApplicationQuestion_Update
    @QuestionId   INT,
    @QuestionText NVARCHAR(500),
    @IsRequired   BIT,
    @IsActive     BIT,
    @SortOrder    INT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.ApplicationQuestions
    SET QuestionText = @QuestionText,
        IsRequired = @IsRequired,
        IsActive = @IsActive,
        SortOrder = @SortOrder
    WHERE QuestionId = @QuestionId;
END
