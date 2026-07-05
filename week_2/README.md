# Week 2: Streams & Change Data Capture

Track changes to your data using Snowflake **streams** — this challenge introduces change data capture (CDC) for incremental processing.

## Challenge

Load employee data from a CSV in S3, stage it, then use a stream to capture and apply changes to a target table.

## Key Concepts

- **Streams**: Track INSERTs, UPDATEs, DELETEs on a source table
- **Staging Tables**: Landing zone for raw data before transformation
- **Change Data Capture (CDC)**: Process only what changed, not the full dataset
- **`APPEND_ONLY` Streams**: For insert-only workloads

## Data Flow

```
S3 (public bucket)
    │
    ▼
External Stage
    │
    ▼
COPY INTO → Staging Table (raw CSV)
    │
    ▼
Stream on Staging Table (captures new rows)
    │
    ▼
INSERT INTO → Employees Table (transformed, clean data)
    │
    ▼
SELECT from Stream (view CDC records)
```

## Files

| File | Purpose |
|------|---------|
| `ddl.sql` | Creates database, stage, file format, staging table, employees table, and stream |
| `load_data.sql` | `COPY INTO` to load CSV into staging table |
| `transformations.sql` | `INSERT INTO employees` from the staging stream |
| `queries.sql` | `SELECT * FROM employees_stream` to inspect CDC records |

## Setup & Execution

```sql
-- 1. Create all objects (tables, stage, file format, stream)
\i week_2/ddl.sql

-- 2. Load raw data from S3 into staging table
\i week_2/load_data.sql

-- 3. Apply transformations (insert to employees via stream)
\i week_2/transformations.sql

-- 4. Query the stream to see captured changes
\i week_2/queries.sql
```

## Expected Result

The stream shows new rows with metadata columns (`METADATA$ACTION`, `METADATA$ISUPDATE`, `METADATA$ROW_ID`) that track what changed.

## What You'll Learn

- How streams capture changes without triggers
- The difference between source tables, staging tables, and streams
- How to consume a stream and apply changes to a target table
- Stream metadata columns and their purpose
