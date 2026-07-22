
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
