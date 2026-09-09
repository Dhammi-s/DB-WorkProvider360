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
    @CreatedByName     NVARCHAR (200) = NULL,   -- optional; resolved from Users if not supplied
    @MaxParticipants   INT,
    @Notes             NVARCHAR (MAX),
    @ColorTag          NVARCHAR (20)
AS
BEGIN
    SET NOCOUNT ON;

    -- Resolve creator name from Users if caller did not supply it
    DECLARE @resolvedName NVARCHAR (200) = @CreatedByName;
    IF @resolvedName IS NULL
        SELECT @resolvedName = FullName FROM dbo.Users WHERE UserId = @CreatedByUserId;

    INSERT INTO dbo.Meetings
           (Title, Description, StartUtc, EndUtc, Location, MeetingType,
            IsPaid, FeePerParticipant, CreatedByUserId, CreatedByName,
            MaxParticipants, Notes, ColorTag)
    VALUES (@Title, @Description, @StartUtc, @EndUtc, @Location, @MeetingType,
            @IsPaid, @FeePerParticipant, @CreatedByUserId, @resolvedName,
            @MaxParticipants, @Notes, @ColorTag);

    SELECT SCOPE_IDENTITY() AS MeetingId;
END
