/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-09-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE   PROCEDURE dbo.usp_ServiceType_Update
    @ServiceTypeId INT,
    @Name          NVARCHAR(100),
    @Description   NVARCHAR(500) = NULL,
    @Category      NVARCHAR(50)  = NULL,
    @ColorTag      NVARCHAR(20)  = NULL,
    @SortOrder     INT           = 0,
    @IsActive      BIT           = 1
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE dbo.ServiceTypes
    SET Name = @Name,
        Description = @Description,
        Category = @Category,
        ColorTag = @ColorTag,
        SortOrder = @SortOrder,
        IsActive = @IsActive,
        UpdatedOn = SYSUTCDATETIME()
    WHERE ServiceTypeId = @ServiceTypeId;
END
