/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-09-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

/* ------------------------------ ServiceTypes ----------------------------- */
CREATE   PROCEDURE dbo.usp_ServiceType_Create
    @Name            NVARCHAR(100),
    @Description     NVARCHAR(500) = NULL,
    @Category        NVARCHAR(50)  = NULL,
    @ColorTag        NVARCHAR(20)  = NULL,
    @SortOrder       INT           = 0,
    @CreatedByUserId INT           = NULL
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO dbo.ServiceTypes (Name, Description, Category, ColorTag, SortOrder, IsActive, CreatedByUserId)
    VALUES (@Name, @Description, @Category, @ColorTag, @SortOrder, 1, @CreatedByUserId);

    SELECT CAST(SCOPE_IDENTITY() AS INT);
END
