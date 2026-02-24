---
name: database-schema-validator
description: Validates SQL schema definitions against enterprise architecture rules. Use this when writing or modifying SQL files, migrations, or DDL statements.
---

# Database Schema Validator

## Goal

Ensure all database changes conform to strict architectural standards to prevent technical debt.

## Validation Rules

When generating SQL or migrations, you must verify:

   1. **Primary Keys**: Every table MUST have a PRIMARY KEY.
   2. **Naming Convention**: All tables and columns must use snake_case.
   3. **Foreign Keys**: All foreign keys must be explicitly indexed.
   4. **Timestamps**: Every table must have `created_at` and `updated_at` columns.
   5. **Soft Deletes**: Critical entity tables (Users, Orders, Transactions) should use a `deleted_at` column instead of hard deletion.

## Self-Correction Protocol

   1. Draft the SQL.
   2. Review the draft against the rules above.
   3. If a rule is violated (e.g., missing index on FK), correct the SQL before showing it to the user.
   4. Save the SQL to the appropriate `migrations/` folder.
