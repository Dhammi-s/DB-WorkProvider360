/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-09-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

/* ------------------------------ UserShortcuts ---------------------------- */
CREATE   PROCEDURE dbo.usp_UserShortcut_GetByUser
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT ShortcutId, UserId, KeyCombo, ActionKey, CreatedOn
    FROM dbo.UserShortcuts
    WHERE UserId = @UserId
    ORDER BY KeyCombo;
END
