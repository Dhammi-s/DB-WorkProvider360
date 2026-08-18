/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

CREATE TABLE [dbo].[ChatMessages] (
    [ChatMessageId] INT            IDENTITY (1, 1) NOT NULL,
    [UserId]        INT            NOT NULL,
    [Role]          NVARCHAR (20)  NOT NULL,   -- 'user' | 'assistant'
    [Content]       NVARCHAR (MAX) NOT NULL,
    [CreatedOn]     DATETIME2 (7)  CONSTRAINT [DF_ChatMessages_CreatedOn] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_ChatMessages] PRIMARY KEY CLUSTERED ([ChatMessageId] ASC),
    CONSTRAINT [FK_ChatMessages_Users] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])
);


GO
CREATE NONCLUSTERED INDEX [IX_ChatMessages_User]
    ON [dbo].[ChatMessages]([UserId] ASC, [CreatedOn] ASC);
