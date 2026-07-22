
CREATE   PROCEDURE dbo.usp_RoleApplication_UpdateStatus
    @ApplicationId    INT,
    @Status           NVARCHAR(20),
    @RejectionReason  NVARCHAR(1000) = NULL,
    @ReviewedByUserId INT
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.RoleApplications
    SET Status = @Status,
        RejectionReason = @RejectionReason,
        ReviewedByUserId = @ReviewedByUserId,
        ReviewedOn = SYSUTCDATETIME()
    WHERE ApplicationId = @ApplicationId;
END
