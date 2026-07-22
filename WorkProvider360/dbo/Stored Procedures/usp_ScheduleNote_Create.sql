
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
