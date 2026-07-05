# Week 5: Python UDFs

Create a **Python User-Defined Function (UDF)** in Snowflake — using Snowflake's built-in Python runtime to write custom logic.

## Challenge

Create a Python UDF that multiplies an integer by 3, then query it to verify the result. Also explores creating tables with CTAS (Create Table As Select).

## Key Concepts

- **Python UDFs**: Write functions in Python (vs. SQL) within Snowflake
- **`CREATE TABLE AS SELECT`**: Create and populate a table in one statement
- **`CREATE OR REPLACE FUNCTION`**: Define reusable logic
- **Handler Functions**: The Python function Snowflake calls

## Data Flow

```
DDL Creates (two independent objects)
    ├── Table: FF_week_5 (created via CTAS, value 1)
    └── Python UDF: timesthree(i) → returns i * 3

Usage:
    SELECT timesthree(column) FROM FF_week_5
```

## Files

| File | Purpose |
|------|---------|
| `ddl.sql` | Creates a simple table and a Python UDF `timesthree` |
| `load_data.sql` | Not needed for this challenge |
| `transformations.sql` | Not needed for this challenge |
| `queries.sql` | Calls the UDF to demonstrate it works |

## Setup & Execution

```sql
-- 1. Create the table and Python UDF
\i week_5/ddl.sql

-- 2. Test the UDF
\i week_5/queries.sql
```

## Expected Result

Calling `timesthree(3)` returns `9`. Calling it against the table column multiplies the stored value.

## What You'll Learn

- How to define Python UDFs in Snowflake
- Specifying runtime versions and handler functions
- Writing multi-language logic alongside SQL
- CTAS (Create Table As Select) syntax
