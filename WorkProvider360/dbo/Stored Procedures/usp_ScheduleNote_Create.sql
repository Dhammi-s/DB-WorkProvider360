/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */


/* ----------------------------- ScheduleNotes ----------------------------- */
CREATE   PROCEDURE dbo.usp_ScheduleNote_Create
    @ScheduleId   INT,
    @AuthorUserId INT,
    @NoteType     NVARCHAR(20),
    @Message      NVARCHAR(2000)
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.ScheduleNotes (ScheduleId, AuthorUserId, NoteType, Message)
    VALUES (@ScheduleId, @AuthorUserId, @NoteType, @Message);

    SELECT CAST(SCOPE_IDENTITY() AS INT);
END
