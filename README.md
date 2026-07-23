WorkProvider360 — Database Project
SQL Server database for WorkProvider360, a multi-tenant SaaS. This is an SSDT database project (.sqlproj, SQL Server 2022) that defines the per-tenant (agency) database schema. It builds to a DACPAC and is published to each tenant database.

Multi-tenant note: this project is the tenant template (one physical database per agency). The shared master database — which holds the Agencies catalog and each tenant's connection string — is managed separately.

Requirements
SQL Server 2022 (or Azure SQL) target
Visual Studio 2022+ with SQL Server Data Tools (SSDT), or MSBuild with SSDT targets
SqlPackage.exe (for command-line publish)
PowerShell (for the multi-tenant deploy script)
Project layout
WorkProvider360/
├─ WorkProvider360.sqlproj        # project file — every object is registered here as <Build>
├─ dbo/
│  ├─ Tables/                     # one CREATE TABLE per .sql file
│  └─ Stored Procedures/          # usp_<Entity>_<Action>.sql
├─ Storage/                       # full-text catalog etc.
├─ Script.PostDeployment.sql      # idempotent reference-data seed (runs after every publish)
Scripts/
└─ Deploy-AllTenants.ps1          # publishes the DACPAC to every active tenant
⚠️ The project is not wildcard-based. When you add a .sql file you must also add a matching <Build Include="..." /> entry in WorkProvider360.sqlproj, or it won't be compiled.

Schema overview (tenant database)
Area	Tables
Identity & auth	                  Roles, Users, RefreshTokens, PasswordResetTokens
Hiring / onboarding             	RoleApplications, ApplicationAnswers, ApplicationQuestions, ApplicationSettings
Offices & time                  	Office, Timezone
Scheduling	                      Schedules, ScheduleNotes, TimeEntries, LocationPings, SchedulingSettings
Comms & ops	                      Announcement, AnnouncementSettings, EmailLog, LogSettings, Branding
Money	                            Invoice, PosTransaction, PosFeeSettings
Each table has matching stored procedures (usp_<Entity>_<Action>) — the application reads/writes only through these procs (no inline SQL, no ORM).

Conventions
Keys: core tables use INT IDENTITY; newer feature tables use UNIQUEIDENTIFIER DEFAULT (newid()).
Stored procedures: named usp_<Entity>_<Action> (e.g. usp_User_Create, usp_Invoice_GetAll). SELECT column names match the app's entity property names so Dapper maps automatically.
Singleton settings tables: a single row keyed SettingsId = 1, managed by an _Upsert proc (ApplicationSettings, SchedulingSettings, LogSettings, AnnouncementSettings, PosFeeSettings, Branding).
Timestamps: DATETIME2(7) with DEFAULT (sysutcdatetime()).
Roles are static across all tenants: 1 SuperAdmin, 2 Admin, 3 Manager, 4 User.
Post-deployment seeding
Script.PostDeployment.sql runs after every publish and is idempotent (WHERE NOT EXISTS / SettingsId = 1 upserts) — safe to run repeatedly. It seeds reference data such as the Timezone list. Add new idempotent seeds here.

Build
Visual Studio: open the solution and Build. Command line (needs VS MSBuild, not dotnet build):

"C:\Program Files\Microsoft Visual Studio\18\Enterprise\MSBuild\Current\Bin\MSBuild.exe" WorkProvider360\WorkProvider360.sqlproj -t:Build
Output: WorkProvider360\bin\Debug\WorkProvider360.dacpac.

Publish / deploy
Single database (SqlPackage):

SqlPackage /Action:Publish ^
  /SourceFile:"bin\Debug\WorkProvider360.dacpac" ^
  /TargetConnectionString:"Server=<server>;Database=<tenantDb>;User Id=<u>;Password=<p>;Encrypt=False" ^
  /p:BlockOnPossibleDataLoss=False
All tenants: run Scripts\Deploy-AllTenants.ps1 — it reads active agencies from the master DB (SELECT ... FROM Agencies WHERE IsActive=1 AND IsArchived=0) and publishes the DACPAC to each tenant database in turn.

Adding a new object (checklist)
Add dbo\Tables\<Name>.sql (and any usp_<Name>_*.sql).
Register each new file as <Build Include="..." /> in WorkProvider360.sqlproj.
Follow the conventions above (GUID vs int, usp_ naming, matching column names).
If it needs seed/reference data, add an idempotent block to Script.PostDeployment.sql.
Build → publish the DACPAC to the tenant DB(s).
Notes
⚠️ Two procs (usp_Agency_GetByDomain, usp_Agency_GetById) reference dbo.Agencies, which lives in the master DB — SSDT will show unresolved-reference warnings (SQL71501). Expected; they run against the master at runtime.
⚠️ Don't name new folders/files logs — the repo's .gitignore has a [Ll]ogs/ rule that would silently exclude them.
Keep real secrets out of any checked-in scripts; use env vars / secure connection strings at deploy time.
