# Week 1: External Stages & File Formats

The first Frosty Friday challenge — a warm-up to get you familiar with Snowflake's external stage and file format concepts.

## Challenge

Load a CSV file from a public S3 bucket using an external stage, then query it directly without loading into a table.

## Key Concepts

- **External Stages**: Point Snowflake to files stored outside Snowflake (S3, GCS, Azure)
- **File Formats**: Define how Snowflake interprets files (CSV delimiter, header handling, etc.)
- **Querying Staged Data**: Use `SELECT` directly against staged files without `COPY INTO`

## Data Flow

```
S3 (public bucket)
    │
    ▼
External Stage (references S3 location)
    │
    ▼
File Format (CSV, comma-delimited)
    │
    ▼
SELECT directly from @stage
```

## Files

| File | Purpose |
|------|---------|
| `ddl.sql` | Creates database, file format, and external stage |
| `load_data.sql` | Not needed — data is queried directly from the stage |
| `transformations.sql` | Not needed for this challenge |
| `queries.sql` | Queries the CSV data directly from the staged file |

## Setup & Execution

```sql
-- 1. Create the stage, database, and file format
\i week_1/ddl.sql

-- 2. Query the data directly from the stage
\i week_1/queries.sql
```

## Expected Result

The query returns all columns from the CSV file using positional references (`$1`, `$2`, `$3`), displaying the raw data as stored in the S3 bucket.

## What You'll Learn

- How to create and use external stages
- How file formats control data interpretation
- That you can query data without loading it first
