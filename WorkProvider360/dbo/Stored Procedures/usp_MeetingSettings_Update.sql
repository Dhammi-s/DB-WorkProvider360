/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE PROCEDURE dbo.usp_MeetingSettings_Update
    @AdminAccess              NVARCHAR (10),
    @ManagerAccess            NVARCHAR (10),
    @UserCanCreate            BIT,
    @AllowClientParticipants  BIT,
    @AllowPaidMeetings        BIT,
    @DefaultFeePerParticipant DECIMAL (10, 2),
    @RequireApproval          BIT,
    @NotifyOnCreate           BIT,
    @NotifyOnUpdate           BIT,
    @NotifyOnCancel           BIT,
    @MaxParticipantsDefault   INT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM dbo.MeetingSettings WHERE SettingsId = 1)
    BEGIN
        INSERT INTO dbo.MeetingSettings (SettingsId) VALUES (1);
    END

    UPDATE dbo.MeetingSettings
    SET    AdminAccess              = @AdminAccess,
           ManagerAccess            = @ManagerAccess,
           UserCanCreate            = @UserCanCreate,
           AllowClientParticipants  = @AllowClientParticipants,
           AllowPaidMeetings        = @AllowPaidMeetings,
           DefaultFeePerParticipant = @DefaultFeePerParticipant,
           RequireApproval          = @RequireApproval,
           NotifyOnCreate           = @NotifyOnCreate,
           NotifyOnUpdate           = @NotifyOnUpdate,
           NotifyOnCancel           = @NotifyOnCancel,
           MaxParticipantsDefault   = @MaxParticipantsDefault,
           UpdatedOn                = sysutcdatetime()
    WHERE  SettingsId = 1;
END
