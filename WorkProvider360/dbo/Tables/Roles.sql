CREATE TABLE [dbo].[Roles] (
    [RoleId]   INT           NOT NULL,
    [RoleName] NVARCHAR (50) NOT NULL,
    [IsActive] BIT           CONSTRAINT [DF_Roles_IsActive] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED ([RoleId] ASC),
    CONSTRAINT [UQ_Roles_RoleName] UNIQUE NONCLUSTERED ([RoleName] ASC)
);

