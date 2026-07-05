# Week 10: Stored Procedures & Dynamic SQL

Create a **Snowflake stored procedure** that dynamically lists files from an external stage using SQL scripting, and explore dynamic warehouse sizing.

## Challenge

Create two warehouses (X-SMALL and SMALL), a stage pointing to public S3, and a stored procedure that iterates over the files in the stage using a cursor and returns their names. Also demonstrates the `LIST` command within a stored procedure context.

## Key Concepts

- **Stored Procedures**: Server-side logic using Snowflake SQL Scripting
- **Dynamic SQL**: Construct and execute SQL at runtime
- **Cursors (`FOR r IN ls DO`)**: Iterate over result sets
- **`LIST @stage` via `IDENTIFIER`**: Reference objects dynamically
- **`IDENTIFIER()`**: Interpret a string variable as a Snowflake object name
- **Multiple Warehouses**: Create and demonstrate different warehouse sizes

## Data Flow

```
DDL Creates:
    ├── 2 Warehouses (my_xsmall_wh, my_small_wh)
    ├── External Stage (S3)
    ├── Table (example_table: datetime, amount)
    └── Stored Procedure: dynamic_warehouse_data_load(stage, table)
        ├── LIST @stage via IDENTIFIER
        ├── Iterate result set with cursor
        └── Build and return comma-separated file names

Execution:
    CALL dynamic_warehouse_data_load('week_10_frosty_stage', 'example_table')
    → Returns: ', file1.csv, file2.csv, ...'
```

## Files

| File | Purpose |
|------|---------|
| `ddl.sql` | Creates warehouses, table, stage, and stored procedure |
| `load_data.sql` | Not needed — data loading is handled inside the procedure |
| `transformations.sql` | Not needed for this challenge |
| `queries.sql` | Calls the stored procedure to demonstrate dynamic file listing |

## Setup & Execution

```sql
-- 1. Create all objects (warehouses, stage, table, stored procedure)
\i week_10/ddl.sql

-- 2. Execute the stored procedure
\i week_10/queries.sql
```

## Expected Result

The stored procedure returns a comma-separated string listing the files in the S3 stage, demonstrating dynamic object referencing and cursor iteration.

## What You'll Learn

- Writing stored procedures with Snowflake SQL Scripting
- Using `IDENTIFIER()` for dynamic object references
- Cursor-based iteration over query results
- Working with multiple warehouses of different sizes
- Constructing and returning dynamic results from procedures
