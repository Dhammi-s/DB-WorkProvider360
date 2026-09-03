/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-09-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

/* Replaces the user's shortcuts from JSON such as
   [{"KeyCombo":"Ctrl+Alt+1","ActionKey":"dashboard.clients"}, ...].
   Blank rows and duplicate combos (last one wins) are dropped. */
CREATE   PROCEDURE dbo.usp_UserShortcut_Replace
    @UserId       INT,
    @ShortcutsJson NVARCHAR(MAX) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRANSACTION;

    DELETE FROM dbo.UserShortcuts WHERE UserId = @UserId;

    ;WITH parsed AS (
        SELECT j.KeyCombo, j.ActionKey,
               ROW_NUMBER() OVER (PARTITION BY j.KeyCombo ORDER BY (SELECT 1)) AS rn
        FROM OPENJSON(ISNULL(@ShortcutsJson, N'[]'))
             WITH (KeyCombo NVARCHAR(50) '$.KeyCombo', ActionKey NVARCHAR(100) '$.ActionKey') j
        WHERE j.KeyCombo IS NOT NULL AND LTRIM(RTRIM(j.KeyCombo)) <> N''
          AND j.ActionKey IS NOT NULL AND LTRIM(RTRIM(j.ActionKey)) <> N''
    )
    INSERT INTO dbo.UserShortcuts (UserId, KeyCombo, ActionKey)
    SELECT @UserId, KeyCombo, ActionKey FROM parsed WHERE rn = 1;

    COMMIT TRANSACTION;

    SELECT ShortcutId, UserId, KeyCombo, ActionKey, CreatedOn
    FROM dbo.UserShortcuts
    WHERE UserId = @UserId
    ORDER BY KeyCombo;
END
