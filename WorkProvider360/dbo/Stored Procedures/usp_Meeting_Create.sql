/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE PROCEDURE dbo.usp_Meeting_Create
    @Title             NVARCHAR (200),
    @Description       NVARCHAR (MAX),
    @StartUtc          DATETIME2 (7),
    @EndUtc            DATETIME2 (7),
    @Location          NVARCHAR (300),
    @MeetingType       NVARCHAR (20),
    @IsPaid            BIT,
    @FeePerParticipant DECIMAL (10, 2),
    @CreatedByUserId   INT,
    @CreatedByName     NVARCHAR (200),
    @MaxParticipants   INT,
    @Notes             NVARCHAR (MAX),
    @ColorTag          NVARCHAR (20)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.Meetings
           (Title, Description, StartUtc, EndUtc, Location, MeetingType,
            IsPaid, FeePerParticipant, CreatedByUserId, CreatedByName,
            MaxParticipants, Notes, ColorTag)
    VALUES (@Title, @Description, @StartUtc, @EndUtc, @Location, @MeetingType,
            @IsPaid, @FeePerParticipant, @CreatedByUserId, @CreatedByName,
            @MaxParticipants, @Notes, @ColorTag);

    SELECT SCOPE_IDENTITY() AS MeetingId;
END
