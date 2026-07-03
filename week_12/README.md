# Week 12: Frosty Friday Challenge

This directory contains the setup, data loading, and querying for the twelfth Frosty Friday challenge, focusing on inventory tracking with NULL values representing out-of-stock items.

## Files

- `ddl.sql`: Contains the DDL statements to create the database, schema, and table.
- `load_data.sql`: Contains the INSERT statements to populate the table with inventory data over time.
- `transformations.sql`: Contains transformation statements (empty)`: No transformation statements required for this week's challenge.
- `queries.sql`: Contains a query to analyze inventory levels and identify current stock status.
- `README.md`: This file.

## Setup

Run the `ddl.sql` script to set up the environment:
```sql
-- Contents of ddl.sql
```

## Data Loading

Run the `load_data.sql` script to load the inventory tracking data:
```sql
-- Contents of load_data.sql
```

## Query and Analysis

Run the `queries.sql` script to analyze inventory levels:
```sql
-- Contents of queries.sql
```

This query shows the most recent stock check date and current stock level for each product, properly handling NULL values (which indicate out-of-stock items).