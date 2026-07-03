# Week 2: Frosty Friday Challenge

This directory contains the setup, data loading, transformation, and query for the second Frosty Friday challenge.

## Files

- `ddl.sql`: Contains the DDL statements to create the database, schema, stage, file format, tables, and stream.
- `load_data.sql`: Contains the COPY INTO statement to load data from the stage into the staging table.
- `transformations.sql`: Contains the INSERT INTO statement to transform data from the staging table to the employees table.
- `queries.sql`: Contains the final SELECT statement to query the employees stream.
- `README.md`: This file.

## Setup

Run the `ddl.sql` script to set up the environment:
```sql
-- Contents of ddl.sql
```

## Data Loading

Run the `load_data.sql` script to load data from the stage:
```sql
-- Contents of load_data.sql
```

## Transformation

Run the `transformations.sql` script to transform the loaded data:
```sql
-- Contents of transformations.sql
```

## Query

Run the `queries.sql` script to view the final result:
```sql
-- Contents of queries.sql
```