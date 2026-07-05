# Week 7: Access Control & Tagging

Implement **role-based access control (RBAC)** and **data tagging** in Snowflake — create custom roles, tag sensitive columns, and verify access restrictions by querying as different users.

## Challenge

Create a multi-schema database with villain, monster, and weapon data, tag columns by security classification, assign roles with selective access, and demonstrate that each role can only see the data it's authorized to view.

## Key Concepts

- **RBAC (Role-Based Access Control)**: Create custom roles and grant appropriate privileges
- **Object Tagging**: Apply metadata tags (`security_class`) to columns/tables for classification
- **Tag-Based Governance**: Use tags alongside roles for data access policies
- **`ACCOUNT_USAGE` Views**: Query `TAG_REFERENCES` to audit tag assignments

## Data Flow

```
DDL Creates:
    ├── 3 Schemas (super_villains, super_monsters, super_weapons)
    ├── 3 Tables (one per schema)
    ├── Tags applied with classification levels
    ├── 3 Roles (user1, user2, user3)
    └── Role grants (each role gets SELECT on all tables)

Demonstration:
    user1 → SELECT villain_information ✓
    user2 → SELECT monster_information ✓
    user3 → SELECT weapon_storage_location ✓

Tag Audit:
    Account Usage views → list tags and their assignments
```

## Files

| File | Purpose |
|------|---------|
| `ddl.sql` | Creates database, schemas, tables, tags, roles, and grants |
| `load_data.sql` | Populates tables with sample villain/monster/weapon data |
| `transformations.sql` | Not needed for this challenge |
| `queries.sql` | Tests role-based access and audits tag assignments |

## Setup & Execution

```sql
-- 1. Create all objects (schemas, tables, tags, roles)
\i week_7/ddl.sql

-- 2. Load sample data
\i week_7/load_data.sql

-- 3. Test access control by switching roles
\i week_7/queries.sql
```

## Expected Result

Each role queries the table assigned to it and sees data. The tag audit queries show which tags exist and what they're applied to.

## What You'll Learn

- Creating roles and granting minimal necessary privileges
- Using `CREATE OR REPLACE TAG` for data classification
- Applying tags to columns and using them in governance workflows
- Querying `ACCOUNT_USAGE.TAG_REFERENCES` for auditing
