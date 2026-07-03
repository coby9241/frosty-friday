# Week 4: Frosty Friday Challenge

This directory contains the setup, data loading, and query for the fourth Frosty Friday challenge.

## Files

- `ddl.sql`: Contains the DDL statements to create the database, schema, stage, file format, staging table, and the final monarchs table.
- `load_data.sql`: Contains the COPY INTO statement to load and parse JSON data from the stage.
- `transformations.sql`: Contains INSERT/UPDATE statements for data transformation (not used in this week's challenge).
- `queries.sql`: Contains the initial test query to verify data loading.
- `README.md`: This file.

## Setup

Run the `ddl.sql` script to set up the environment:
```sql
-- Contents of ddl.sql (excluding the COPY INTO statement which is in load_data.sql)
```

## Data Loading

Run the `load_data.sql` script to load data from the stage:
```sql
-- Contents of load_data.sql
```

## Query

Run the `queries.sql` script to verify the data was loaded correctly:
```sql
-- Contents of queries.sql
```

The main result is the `monarchs` table created by the ddl.sql script, which contains the processed monarch data.