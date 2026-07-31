/* =============================================================================
   WorkProvider360 - Multi-tenant SaaS platform
   Developed by : Jasmeet Singh  (Full Stack Software Engineer)
   Date         : 2026-07-31
   NOTE TO DEVELOPERS: Do NOT change functionality without full knowledge of the
   SaaS architecture. PLEASE FIRST DISCUSS WITH SOFTWARE ENGINEER JASMEET SINGH.
   ============================================================================= */

/* =============================================================================
   POST-DEPLOYMENT SCRIPT — runs after every publish, against EACH tenant DB.
   Must be idempotent: re-running skips rows that already exist.

   Seeds the shared Timezone reference list. New rows get a GUID via the column
   DEFAULT (newid()); CreatedOn/ModifiedOn/IsActive/IsArchived use their defaults.
   Add more zones to the VALUES list below — existing ones are skipped by name.
   ============================================================================= */

SET NOCOUNT ON;

;WITH src ([Timezone], [Description]) AS (
    SELECT v.[Timezone], v.[Description]
    FROM (VALUES
        (N'UTC',                          N'(UTC) Coordinated Universal Time'),
        (N'Dateline Standard Time',       N'(UTC-12:00) International Date Line West'),
        (N'Hawaiian Standard Time',       N'(UTC-10:00) Hawaii'),
        (N'Alaskan Standard Time',        N'(UTC-09:00) Alaska'),
        (N'Pacific Standard Time',        N'(UTC-08:00) Pacific Time (US & Canada)'),
        (N'US Mountain Standard Time',    N'(UTC-07:00) Arizona'),
        (N'Mountain Standard Time',       N'(UTC-07:00) Mountain Time (US & Canada)'),
        (N'Central Standard Time',        N'(UTC-06:00) Central Time (US & Canada)'),
        (N'Central America Standard Time',N'(UTC-06:00) Central America'),
        (N'Eastern Standard Time',        N'(UTC-05:00) Eastern Time (US & Canada)'),
        (N'US Eastern Standard Time',     N'(UTC-05:00) Indiana (East)'),
        (N'Atlantic Standard Time',       N'(UTC-04:00) Atlantic Time (Canada)'),
        (N'Pacific SA Standard Time',     N'(UTC-04:00) Santiago'),
        (N'E. South America Standard Time',N'(UTC-03:00) Brasilia'),
        (N'Argentina Standard Time',      N'(UTC-03:00) Buenos Aires'),
        (N'Mid-Atlantic Standard Time',   N'(UTC-02:00) Mid-Atlantic'),
        (N'Azores Standard Time',         N'(UTC-01:00) Azores'),
        (N'GMT Standard Time',            N'(UTC+00:00) Dublin, Edinburgh, Lisbon, London'),
        (N'Greenwich Standard Time',      N'(UTC+00:00) Monrovia, Reykjavik'),
        (N'W. Europe Standard Time',      N'(UTC+01:00) Amsterdam, Berlin, Rome, Vienna'),
        (N'Central Europe Standard Time', N'(UTC+01:00) Belgrade, Bratislava, Budapest, Prague'),
        (N'Romance Standard Time',        N'(UTC+01:00) Brussels, Copenhagen, Madrid, Paris'),
        (N'Central European Standard Time',N'(UTC+01:00) Sarajevo, Skopje, Warsaw, Zagreb'),
        (N'W. Central Africa Standard Time',N'(UTC+01:00) West Central Africa'),
        (N'GTB Standard Time',            N'(UTC+02:00) Athens, Bucharest'),
        (N'E. Europe Standard Time',      N'(UTC+02:00) Chisinau'),
        (N'Egypt Standard Time',          N'(UTC+02:00) Cairo'),
        (N'South Africa Standard Time',   N'(UTC+02:00) Harare, Pretoria'),
        (N'Israel Standard Time',         N'(UTC+02:00) Jerusalem'),
        (N'Russian Standard Time',        N'(UTC+03:00) Moscow, St. Petersburg'),
        (N'Arab Standard Time',           N'(UTC+03:00) Kuwait, Riyadh'),
        (N'E. Africa Standard Time',      N'(UTC+03:00) Nairobi'),
        (N'Iran Standard Time',           N'(UTC+03:30) Tehran'),
        (N'Arabian Standard Time',        N'(UTC+04:00) Abu Dhabi, Muscat'),
        (N'India Standard Time',          N'(UTC+05:30) Chennai, Kolkata, Mumbai, New Delhi'),
        (N'Sri Lanka Standard Time',      N'(UTC+05:30) Sri Jayawardenepura'),
        (N'Nepal Standard Time',          N'(UTC+05:45) Kathmandu'),
        (N'Central Asia Standard Time',   N'(UTC+06:00) Astana'),
        (N'SE Asia Standard Time',        N'(UTC+07:00) Bangkok, Hanoi, Jakarta'),
        (N'China Standard Time',          N'(UTC+08:00) Beijing, Chongqing, Hong Kong'),
        (N'Singapore Standard Time',      N'(UTC+08:00) Kuala Lumpur, Singapore'),
        (N'W. Australia Standard Time',   N'(UTC+08:00) Perth'),
        (N'Tokyo Standard Time',          N'(UTC+09:00) Osaka, Sapporo, Tokyo'),
        (N'Korea Standard Time',          N'(UTC+09:00) Seoul'),
        (N'Cen. Australia Standard Time', N'(UTC+09:30) Adelaide'),
        (N'AUS Eastern Standard Time',    N'(UTC+10:00) Canberra, Melbourne, Sydney'),
        (N'E. Australia Standard Time',   N'(UTC+10:00) Brisbane'),
        (N'Sakhalin Standard Time',       N'(UTC+11:00) Sakhalin Standard Time'),
        (N'New Zealand Standard Time',    N'(UTC+12:00) Auckland, Wellington')
    ) AS v ([Timezone], [Description])
)
INSERT INTO dbo.Timezone ([Timezone], [Description])
SELECT s.[Timezone], s.[Description]
FROM src s
WHERE NOT EXISTS (
    SELECT 1 FROM dbo.Timezone t WHERE t.[Timezone] = s.[Timezone]
);


/* ---------------------------------------------------------------------------
   Seed the default login-page content (single row, SettingsId = 1). Idempotent:
   only inserts when the row is missing, so SuperAdmin edits are never overwritten.
   --------------------------------------------------------------------------- */
IF NOT EXISTS (SELECT 1 FROM dbo.LoginPageContent WHERE SettingsId = 1)
BEGIN
    INSERT INTO dbo.LoginPageContent
        (SettingsId, HeadlineLead, HeadlineHighlight, HeadlineTrail, Subtitle,
         Stat1Label, Stat1Value, Stat2Label, Stat2Value, Stat3Label, Stat3Value,
         QuoteText, QuoteAuthor, QuoteRole)
    VALUES
        (1,
         N'Field service', N'reimagined', N'with AI',
         N'Intelligent scheduling, real-time dispatch, and AI-powered insights for modern service businesses.',
         N'Jobs Dispatched', N'1.2M+',
         N'Active Teams',    N'2,400+',
         N'Uptime SLA',      N'99.97%',
         N'WorkProvider360 cut our scheduling time by 70% and increased our first-time fix rate to 94%. It''s transformed how we operate.',
         N'Jordan Rivera',
         N'COO, ClearPath HVAC — Toronto, ON');
END


/* ---------------------------------------------------------------------------
   Seed the fixed role list. Idempotent: only inserts roles that are missing.
   RoleId is a plain INT (not identity), so explicit ids are allowed.
   --------------------------------------------------------------------------- */
INSERT INTO dbo.Roles (RoleId, RoleName, IsActive)
SELECT v.RoleId, v.RoleName, 1
FROM (VALUES
    (1, N'SuperAdmin'),
    (2, N'Admin'),
    (3, N'Manager'),
    (4, N'User')
) AS v (RoleId, RoleName)
WHERE NOT EXISTS (SELECT 1 FROM dbo.Roles r WHERE r.RoleId = v.RoleId);


/* ---------------------------------------------------------------------------
   Seed the initial SuperAdmin so a freshly provisioned tenant can be signed
   into. Idempotent: only inserts when this email is not already present.
   NOTE: this is a shared bootstrap credential baked into the deploy — change
   the password after first login for each tenant.
   --------------------------------------------------------------------------- */
IF NOT EXISTS (SELECT 1 FROM dbo.Users WHERE Email = N'jassadhammi@gmail.com')
BEGIN
    INSERT INTO dbo.Users
        (Email, FullName, PasswordHash, PasswordSalt, RoleId, Phone, AvatarUrl, OfficeId, Salary, IsActive)
    VALUES
    (
        N'jassadhammi@gmail.com',
        N'jasmeet singh',
        N'2gK9tsjzMVOuR+ePC71DXRi9lFVJFLwPo+gZYZiqSdOBRIp66YdC/qbA0qd0cl6FbzAC40sRvSjvzf2Q1MxatA==',
        N'3ONlQRaEW+Bup4SS8k0krnW/hrlleLlGID4hHNg4QKo=',
        1,
        N'8198088924',
        N'https://res.cloudinary.com/lfdxdxyj/image/upload/v1785489946/workprovider360/avatars/pe78vjsjafbvkdljujwl.png',
        NULL,
        NULL,
        1
    );
END
