/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-09-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

/* Per-user keyboard shortcuts. Each user maps a key combo (e.g. "Ctrl+Alt+1")
   to an action key resolved to an in-app route on the client. Applies to every
   role, including portal clients. */
CREATE TABLE [dbo].[UserShortcuts] (
    [ShortcutId] INT            IDENTITY (1, 1) NOT NULL,
    [UserId]     INT            NOT NULL,
    [KeyCombo]   NVARCHAR (50)  NOT NULL,
    [ActionKey]  NVARCHAR (100) NOT NULL,
    [CreatedOn]  DATETIME2 (7)  CONSTRAINT [DF_UserShortcuts_CreatedOn] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_UserShortcuts] PRIMARY KEY CLUSTERED ([ShortcutId] ASC),
    CONSTRAINT [FK_UserShortcuts_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId]),
    CONSTRAINT [UQ_UserShortcuts_User_Combo] UNIQUE NONCLUSTERED ([UserId] ASC, [KeyCombo] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_UserShortcuts_UserId]
    ON [dbo].[UserShortcuts]([UserId] ASC);
