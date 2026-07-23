CREATE TABLE [dbo].[Announcement] (
    [AnnouncementId]  UNIQUEIDENTIFIER DEFAULT (newid()) NOT NULL,
    [Title]           NVARCHAR (200)   NOT NULL,
    [Message]         NVARCHAR (MAX)   NOT NULL,
    [IsActive]        BIT              CONSTRAINT [DF_Announcement_IsActive] DEFAULT ((1)) NOT NULL,
    [CreatedByUserId] INT              NULL,
    [CreatedOn]       DATETIME2 (7)    CONSTRAINT [DF_Announcement_CreatedOn] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Announcement] PRIMARY KEY CLUSTERED ([AnnouncementId] ASC)
);
GO
CREATE NONCLUSTERED INDEX [IX_Announcement_CreatedOn]
    ON [dbo].[Announcement]([CreatedOn] DESC);
