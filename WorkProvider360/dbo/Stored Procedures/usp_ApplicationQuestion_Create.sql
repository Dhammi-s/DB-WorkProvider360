/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


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
