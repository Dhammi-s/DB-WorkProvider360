# WorkProvider360 Database

Enterprise-grade SQL Server database project powering the **WorkProvider360** multi-tenant SaaS platform.

This repository contains the complete tenant database definition built with **SQL Server Data Tools (SSDT)**. The project compiles into a **DACPAC**, enabling repeatable, version-controlled deployments across every tenant database while maintaining a consistent schema.

The architecture follows a **database-per-tenant** model, where every agency owns an isolated SQL Server database for maximum security, scalability, and data isolation.

> **Tenant Database:** This repository
> **Master Database:** Managed separately (stores agency catalog, tenant connection strings, and tenant discovery)

---

## 🚀 Key Features

* SQL Server 2022 SSDT Database Project
* DACPAC-based CI/CD deployment
* Database-per-tenant SaaS architecture
* Version-controlled schema management
* Automated multi-tenant deployment
* Idempotent post-deployment data seeding
* Dapper-optimized stored procedures
* Enterprise naming conventions
* SQL Server & Azure SQL compatible

---

## 🏗 Architecture

```
                   Master Database
        +----------------------------------+
        | Agencies                         |
        | Tenant Connection Strings        |
        | Domain Mapping                   |
        +----------------+-----------------+
                         |
        -----------------------------------------
        |               |               |
        ▼               ▼               ▼
+----------------+ +----------------+ +----------------+
| Agency DB 1    | | Agency DB 2    | | Agency DB N    |
| (Tenant)       | | (Tenant)       | | (Tenant)       |
+----------------+ +----------------+ +----------------+
```

Each tenant database is generated from this SSDT project, ensuring every agency runs an identical, fully version-controlled schema.

---

## 📦 Technology Stack

* SQL Server 2022
* SQL Server Data Tools (SSDT)
* Visual Studio 2022
* MSBuild
* SqlPackage
* PowerShell
* Dapper

---

## 📁 Project Structure

```
WorkProvider360
│
├── WorkProvider360.sqlproj
├── dbo
│   ├── Tables
│   ├── Stored Procedures
│   ├── Views
│   └── Functions
│
├── Storage
├── Script.PostDeployment.sql
│
└── Scripts
    └── Deploy-AllTenants.ps1
```

> **Important:** SSDT does not automatically include new SQL objects. Every new `.sql` file **must** be registered inside `WorkProvider360.sqlproj`; otherwise it will not be compiled into the DACPAC.

---

## 🛠 Design Principles

* Database-first development
* Stored procedure–only data access
* Zero inline SQL from the application
* Dapper-friendly result sets
* Idempotent deployments
* Version-controlled database changes
* Automated tenant provisioning
* Enterprise deployment workflow

---

## 📊 Database Modules

| Module              | Components                                        |
| ------------------- | ------------------------------------------------- |
| Identity & Security | Roles, Users, Refresh Tokens, Password Reset      |
| Hiring & Onboarding | Applications, Questions, Answers                  |
| Scheduling          | Schedules, Notes, Time Entries, Location Tracking |
| Office Management   | Offices, Timezones                                |
| Communication       | Announcements, Branding, Email Logs               |
| Financial           | Invoices, POS Transactions, Fee Settings          |
| System Settings     | Application, Scheduling, Logging, Branding        |

---

## 🚀 Deployment Workflow

```
Developer
      │
      ▼
Modify SQL Objects
      │
      ▼
Build SSDT Project
      │
      ▼
Generate DACPAC
      │
      ▼
Deploy via SqlPackage
      │
      ▼
Deploy-AllTenants.ps1
      │
      ▼
All Active Tenant Databases
```

Every deployment is repeatable, version-controlled, and safe for production environments.

---

## 🔒 Database Standards

* INT IDENTITY for core entities
* UNIQUEIDENTIFIER for modern feature modules
* DATETIME2(7) UTC timestamps
* Idempotent reference data seeding
* Singleton configuration tables
* Consistent stored procedure naming (`usp_*`)
* Column names aligned with Dapper entity mapping
* Safe post-deployment execution

---

## ⚠ Important Notes

* `usp_Agency_GetByDomain` and `usp_Agency_GetById` reference the master database and may generate expected SSDT unresolved-reference warnings.
* Avoid naming folders **Logs**, as repository ignore rules exclude them.
* Never commit production credentials or secrets. Use secure deployment variables or environment-specific configuration.
