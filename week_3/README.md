# Week 3: External Stages & Semi-Structured Data

This challenge focuses on querying semi-structured data (JSON/Parquet) directly from an external stage using Snowflake's `LIST` and other stage operations.

## Challenge

Set up an external stage pointing to a public S3 bucket and explore what's inside using Snowflake's stage inspection commands.

## Key Concepts

- **External Stages**: Revisited from week 1, but with a different bucket/format
- **`LIST` Command**: List files in a stage without loading them
- **Stage Metadata**: Understand file structure before designing tables

## Data Flow

```
S3 (public bucket)
    │
    ▼
External Stage
    │
    ▼
LIST @stage (inspect available files)
```

## Files

| File | Purpose |
|------|---------|
| `ddl.sql` | Creates database, schema, and external stage |
| `load_data.sql` | Not needed for this challenge |
| `transformations.sql` | Not needed for this challenge |
| `queries.sql` | `LIST @week_3_stage` to view staged files |

## Setup & Execution

```sql
-- 1. Create the stage and database
\i week_3/ddl.sql

-- 2. List files in the stage
\i week_3/queries.sql
```

## Expected Result

The `LIST` command returns metadata about the files in the stage: file name, size, last modified date, etc.

## What You'll Learn

- How to inspect staged files before loading them
- Using `LIST` to preview available data
- That not every challenge requires data loading or transformations
