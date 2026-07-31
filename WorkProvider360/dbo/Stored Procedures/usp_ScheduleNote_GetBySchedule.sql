/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


CREATE   PROCEDURE dbo.usp_ScheduleNote_GetBySchedule
    @ScheduleId INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT n.NoteId, n.ScheduleId, n.AuthorUserId, u.FullName AS AuthorName,
           n.NoteType, n.Message, n.CreatedOn
    FROM dbo.ScheduleNotes n
    INNER JOIN dbo.Users u ON u.UserId = n.AuthorUserId
    WHERE n.ScheduleId = @ScheduleId
    ORDER BY n.CreatedOn;
END
