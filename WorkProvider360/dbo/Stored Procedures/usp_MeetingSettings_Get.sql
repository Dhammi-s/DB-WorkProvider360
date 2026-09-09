/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE PROCEDURE dbo.usp_MeetingSettings_Get
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM dbo.MeetingSettings WHERE SettingsId = 1)
    BEGIN
        INSERT INTO dbo.MeetingSettings (SettingsId) VALUES (1);
    END

    SELECT SettingsId, AdminAccess, ManagerAccess, UserCanCreate,
           AllowClientParticipants, AllowPaidMeetings, DefaultFeePerParticipant,
           RequireApproval, NotifyOnCreate, NotifyOnUpdate, NotifyOnCancel,
           MaxParticipantsDefault, UpdatedOn
    FROM   dbo.MeetingSettings
    WHERE  SettingsId = 1;
END
