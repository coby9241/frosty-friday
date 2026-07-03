# Week 6: Frosty Friday Challenge

This directory contains the setup, data loading, transformation, and query for the sixth Frosty Friday challenge.

## Files

- `ddl.sql`: Contains the DDL statements to create the database, schema, stages, file formats, tables, and polygon geometry tables.
- `load_data.sql`: Contains the COPY INTO statements to load data from the stages.
- `transformations.sql`: Contains INSERT/UPDATE statements for data transformation (not used in this week's challenge).
- `queries.sql`: Contains queries for data exploration and the final solution query to find intersecting constituencies.
- `README.md`: This file.

## Setup

Run the `ddl.sql` script to set up the environment:
```sql
-- Contents of ddl.sql
```

## Data Loading

Run the `load_data.sql` script to load data from the stages:
```sql
-- Contents of load_data.sql
```

## Query and Analysis

Run the `queries.sql` script to explore the data and see the final solution:
```sql
-- Contents of queries.sql
```

The solution identifies which Westminster constituencies intersect with geographic regions/nations and counts how many constituencies intersect with each region.