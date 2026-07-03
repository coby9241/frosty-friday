# Week 10: Frosty Friday Challenge

This directory contains the setup and demonstration for the tenth Frosty Friday challenge, focusing on dynamic warehouse selection and data loading using stored procedures.

## Files

- `ddl.sql`: Contains the DDL statements to create the database, schema, warehouses, table, stage, and stored procedure.
- `load_data.sql`: Contains data loading statements (none - data loading is handled within the stored procedure.
- `transformations.sql`: Contains transformation statements (not used in this week's challenge).
- `queries.sql`: Contains the CALL statement to execute the stored procedure and demonstrate the solution.
- `README.md`: This file.

## Setup

Run the `ddl.sql` script to set up the environment:
```sql
-- Contents of ddl.sql
```

## Execution

Run the `queries.sql` script to execute the stored procedure:
```sql
-- Contents of queries.sql

This calls the stored procedure which lists files from the specified stage
```

The stored procedure demonstrates how to dynamically work with different warehouses and process staged files.