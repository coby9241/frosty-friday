# Week 9: Dynamic Data Masking

Implement **column-level security with dynamic data masking** — use tags, masking policies, and role-based clearance levels to control who sees sensitive data.

## Challenge

Create a table with superhero/villain data, tag each column with a PII level (PUBLIC, CONFIDENTIAL, RESTRICTED), build a masking policy that checks the user's role against the tag's classification, and verify that different roles see different data.

## Key Concepts

- **Dynamic Data Masking**: Hide sensitive data at query time based on policy rules
- **Object Tags with `ALLOWED_VALUES`**: Restrict tag values to a controlled vocabulary
- **`SYSTEM$GET_TAG_ON_CURRENT_COLUMN`**: Read the tag value on the column being queried
- **`CURRENT_ROLE()`**: Determine who's querying to control what they see
- **`MEMORIZABLE` Functions**: Cache function results for better performance

## Data Flow

```
DDL Creates:
    ├── Table: data_to_be_masked (first_name, last_name, hero_name)
    ├── Tag: pii_level (ALLOWED_VALUES: PUBLIC, CONFIDENTIAL, RESTRICTED)
    ├── Tags applied to each column
    ├── Role Checker table (maps roles → clearance levels)
    ├── Function: get_pii_level() (returns user's clearance)
    └── Masking Policy: PII_MASK (compares tag level vs user's clearance)

Query Time:
    foo1 role → sees masked data for RESTRICTED columns
    foo2 role → may see different masked values
    ACCOUNTADMIN → sees all data unmasked
```

## Files

| File | Purpose |
|------|---------|
| `ddl.sql` | Creates tables, tags, roles, the clearance function, and masking policy |
| `load_data.sql` | Populates the data table and role checker table |
| `transformations.sql` | Not needed for this challenge |
| `queries.sql` | Creates & tests the clearance function, queries through different roles |

## Setup & Execution

```sql
-- 1. Create all objects (tables, tags, roles, function, masking policy)
\i week_9/ddl.sql

-- 2. Load sample data and role mappings
\i week_9/load_data.sql

-- 3. Test masking by switching roles
\i week_9/queries.sql
```

## Expected Result

Different roles see different data:
- `SERVER_ADMIN_ROLE` (if mapped to RESTRICTED) → sees all data
- `foo1` (if mapped to CONFIDENTIAL) → sees PUBLIC and CONFIDENTIAL, but not RESTRICTED
- No role mapping → falls back to PUBLIC visibility

## What You'll Learn

- Creating masking policies with conditional logic
- Combining tags and policies for column-level security
- Using `ALLOWED_VALUES` on tags for governance
- Writing `MEMORIZABLE` functions for policy lookups
- Testing security by querying with different roles
