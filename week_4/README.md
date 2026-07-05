# Week 4: JSON Loading & Semi-Structured Data

Parse and query **JSON data** in Snowflake — this challenge introduces loading semi-structured data and extracting values using Snowflake's VARIANT type.

## Challenge

Load a JSON file from a public S3 stage, parse the semi-structured data, and extract specific fields to populate a relational table.

## Key Concepts

- **VARIANT Type**: Snowflake's flexible column type for semi-structured data
- **JSON Parsing**: Extract values from nested JSON structures
- **`COPY INTO` with JSON**: Handling JSON file formatting and parsing during load
- **Bracket Notation**: `data[0]:Era` syntax for accessing JSON paths

## Data Flow

```
S3 (public bucket)
    │
    ▼
External Stage
    │
    ▼
COPY INTO → Staging Table (raw JSON in VARIANT column)
    │
    ▼
Transformations (extract fields)
    │
    ▼
Monarchs Table (relational, clean data)
```

## Files

| File | Purpose |
|------|---------|
| `ddl.sql` | Creates database, stage, file format, staging table, and final monarchs table |
| `load_data.sql` | `COPY INTO` to load and parse JSON from stage |
| `transformations.sql` | Not needed — table transformations are built into the DDL |
| `queries.sql` | Test query to extract JSON fields (e.g., `data[0]:Era`) |

## Setup & Execution

```sql
-- 1. Create all objects
\i week_4/ddl.sql

-- 2. Load JSON data
\i week_4/load_data.sql

-- 3. Verify data extraction
\i week_4/queries.sql
```

## Expected Result

The query extracts the `Era` field from the JSON array stored in the staging table, confirming the data was loaded and parsed correctly.

## What You'll Learn

- Loading JSON files into Snowflake
- The VARIANT data type and when to use it
- Accessing nested JSON using bracket and colon notation
- Handling arrays within JSON (`data[0]`)
