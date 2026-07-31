/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


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
