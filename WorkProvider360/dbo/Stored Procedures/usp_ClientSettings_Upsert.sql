/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-09-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE   PROCEDURE dbo.usp_ClientSettings_Upsert
    @AdminClientAccess                NVARCHAR(10) = N'Write',
    @ManagerClientAccess              NVARCHAR(10) = N'Read',
    @AdminServiceTypeAccess           NVARCHAR(10) = N'Write',
    @ManagerServiceTypeAccess         NVARCHAR(10) = N'Write',
    @AutoClockInEnabled               BIT = 0,
    @AutoClockOutEnabled              BIT = 0,
    @RequireClientSignatureOnClockIn  BIT = 0,
    @RequireClientSignatureOnClockOut BIT = 1,
    @RequireSameOffice                BIT = 1,
    @RequireMatchingSkill             BIT = 0,
    @CaptureClockLocation             BIT = 1,
    @ClientPortalEnabled              BIT = 1,
    @SendClientCredentialsEmail       BIT = 1,
    @NotifyClientOnSchedule           BIT = 1,
    @RequireClientEmail               BIT = 1,
    @RequireClientPhone               BIT = 1,
    @RequireClientDateOfBirth         BIT = 0,
    @RequireEmergencyContact          BIT = 0,
    @RequireClientServiceTypes        BIT = 1
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT 1 FROM dbo.ClientSettings WHERE SettingsId = 1)
    BEGIN
        UPDATE dbo.ClientSettings
        SET AdminClientAccess                = @AdminClientAccess,
            ManagerClientAccess              = @ManagerClientAccess,
            AdminServiceTypeAccess           = @AdminServiceTypeAccess,
            ManagerServiceTypeAccess         = @ManagerServiceTypeAccess,
            AutoClockInEnabled               = @AutoClockInEnabled,
            AutoClockOutEnabled              = @AutoClockOutEnabled,
            RequireClientSignatureOnClockIn  = @RequireClientSignatureOnClockIn,
            RequireClientSignatureOnClockOut = @RequireClientSignatureOnClockOut,
            RequireSameOffice                = @RequireSameOffice,
            RequireMatchingSkill             = @RequireMatchingSkill,
            CaptureClockLocation             = @CaptureClockLocation,
            ClientPortalEnabled              = @ClientPortalEnabled,
            SendClientCredentialsEmail       = @SendClientCredentialsEmail,
            NotifyClientOnSchedule           = @NotifyClientOnSchedule,
            RequireClientEmail               = @RequireClientEmail,
            RequireClientPhone               = @RequireClientPhone,
            RequireClientDateOfBirth         = @RequireClientDateOfBirth,
            RequireEmergencyContact          = @RequireEmergencyContact,
            RequireClientServiceTypes        = @RequireClientServiceTypes,
            UpdatedOn                        = SYSUTCDATETIME()
        WHERE SettingsId = 1;
    END
    ELSE
    BEGIN
        INSERT INTO dbo.ClientSettings
            (SettingsId, AdminClientAccess, ManagerClientAccess, AdminServiceTypeAccess, ManagerServiceTypeAccess,
             AutoClockInEnabled, AutoClockOutEnabled, RequireClientSignatureOnClockIn, RequireClientSignatureOnClockOut,
             RequireSameOffice, RequireMatchingSkill, CaptureClockLocation, ClientPortalEnabled,
             SendClientCredentialsEmail, NotifyClientOnSchedule, RequireClientEmail, RequireClientPhone,
             RequireClientDateOfBirth, RequireEmergencyContact, RequireClientServiceTypes)
        VALUES
            (1, @AdminClientAccess, @ManagerClientAccess, @AdminServiceTypeAccess, @ManagerServiceTypeAccess,
             @AutoClockInEnabled, @AutoClockOutEnabled, @RequireClientSignatureOnClockIn, @RequireClientSignatureOnClockOut,
             @RequireSameOffice, @RequireMatchingSkill, @CaptureClockLocation, @ClientPortalEnabled,
             @SendClientCredentialsEmail, @NotifyClientOnSchedule, @RequireClientEmail, @RequireClientPhone,
             @RequireClientDateOfBirth, @RequireEmergencyContact, @RequireClientServiceTypes);
    END

    EXEC dbo.usp_ClientSettings_Get;
END
