CREATE TABLE [dbo].[Users] (
    [UserId]       INT            IDENTITY (1, 1) NOT NULL,
    [Email]        NVARCHAR (256) NOT NULL,
    [FullName]     NVARCHAR (200) NOT NULL,
    [PasswordHash] NVARCHAR (200) NOT NULL,
    [PasswordSalt] NVARCHAR (100) NOT NULL,
    [RoleId]       INT            NOT NULL,
    [Phone]        NVARCHAR (30)  NULL,
    [AvatarUrl]    NVARCHAR (500) NULL,
    [OfficeId]     UNIQUEIDENTIFIER NULL,
    [Salary]       DECIMAL (10, 2) NULL,
    [IsActive]     BIT            CONSTRAINT [DF_Users_IsActive] DEFAULT ((1)) NOT NULL,
    [CreatedOn]    DATETIME2 (7)  CONSTRAINT [DF_Users_CreatedOn] DEFAULT (sysutcdatetime()) NOT NULL,
    [UpdatedOn]    DATETIME2 (7)  NULL,
    CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED ([UserId] ASC),
    CONSTRAINT [FK_Users_Roles] FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Roles] ([RoleId]),
    CONSTRAINT [FK_Users_Office] FOREIGN KEY ([OfficeId]) REFERENCES [dbo].[Office] ([OfficeId]),
    CONSTRAINT [UQ_Users_Email] UNIQUE NONCLUSTERED ([Email] ASC)
);

