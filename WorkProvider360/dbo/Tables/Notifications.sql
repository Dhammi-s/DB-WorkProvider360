/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-08-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE TABLE [dbo].[Notifications] (
    [NotificationId]  INT            IDENTITY (1, 1) NOT NULL,
    [UserId]          INT            NOT NULL,   -- recipient
    [Title]           NVARCHAR (150) NULL,
    [Message]         NVARCHAR (1000) NOT NULL,
    [IsRead]          BIT            CONSTRAINT [DF_Notifications_IsRead] DEFAULT ((0)) NOT NULL,
    [CreatedByUserId] INT            NULL,       -- sender
    [CreatedOn]       DATETIME2 (7)  CONSTRAINT [DF_Notifications_CreatedOn] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Notifications] PRIMARY KEY CLUSTERED ([NotificationId] ASC),
    CONSTRAINT [FK_Notifications_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])
);


GO
CREATE NONCLUSTERED INDEX [IX_Notifications_User]
    ON [dbo].[Notifications]([UserId] ASC, [CreatedOn] DESC);
