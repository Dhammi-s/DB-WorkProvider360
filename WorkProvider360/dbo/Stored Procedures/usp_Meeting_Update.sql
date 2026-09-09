/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE PROCEDURE dbo.usp_Meeting_Update
    @MeetingId         INT,
    @Title             NVARCHAR (200),
    @Description       NVARCHAR (MAX),
    @StartUtc          DATETIME2 (7),
    @EndUtc            DATETIME2 (7),
    @Location          NVARCHAR (300),
    @MeetingType       NVARCHAR (20),
    @IsPaid            BIT,
    @FeePerParticipant DECIMAL (10, 2),
    @MaxParticipants   INT,
    @Notes             NVARCHAR (MAX),
    @ColorTag          NVARCHAR (20)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.Meetings
    SET    Title             = @Title,
           Description       = @Description,
           StartUtc          = @StartUtc,
           EndUtc            = @EndUtc,
           Location          = @Location,
           MeetingType       = @MeetingType,
           IsPaid            = @IsPaid,
           FeePerParticipant = @FeePerParticipant,
           MaxParticipants   = @MaxParticipants,
           Notes             = @Notes,
           ColorTag          = @ColorTag,
           UpdatedOn         = sysutcdatetime()
    WHERE  MeetingId = @MeetingId;
END
