/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-09-03
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

/* Client signature captured on the worker device at clock-in / clock-out.
   Kept apart from TimeEntries so list queries never load the image blobs.
   SignatureBase64 holds a pure Base64 PNG (no data-URI prefix). */
CREATE TABLE [dbo].[TimeEntrySignatures] (
    [SignatureId]     INT            IDENTITY (1, 1) NOT NULL,
    [TimeEntryId]     INT            NOT NULL,
    [Phase]           NVARCHAR (10)  NOT NULL,
    [SignatureBase64] NVARCHAR (MAX) NOT NULL,
    [SignedByName]    NVARCHAR (200) NULL,
    [SignedOnUtc]     DATETIME2 (7)  CONSTRAINT [DF_TimeEntrySignatures_SignedOnUtc] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_TimeEntrySignatures] PRIMARY KEY CLUSTERED ([SignatureId] ASC),
    CONSTRAINT [FK_TimeEntrySignatures_TimeEntries] FOREIGN KEY ([TimeEntryId]) REFERENCES [dbo].[TimeEntries] ([TimeEntryId]),
    CONSTRAINT [UQ_TimeEntrySignatures_Entry_Phase] UNIQUE NONCLUSTERED ([TimeEntryId] ASC, [Phase] ASC)
);
