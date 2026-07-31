/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


CREATE   PROCEDURE dbo.usp_ApplicationQuestion_GetById
    @QuestionId INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT QuestionId, QuestionText, IsRequired, IsActive, SortOrder, CreatedOn
    FROM dbo.ApplicationQuestions
    WHERE QuestionId = @QuestionId;
END
