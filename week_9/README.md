# Week 9: Frosty Friday Challenge

This directory contains the setup, data loading, querying, and masking policy demonstration for the ninth Frosty Friday challenge.

## Files

- `ddl.sql`: Contains the DDL statements to create the database, schema, tables, roles, tags, function, and masking policy.
- `load_data.sql`: Contains the INSERT statements to populate the tables with sample data.
- `transformations.sql`: Contains transformation statements (not used in this week's challenge).
- `queries.sql`: Contains queries to demonstrate the masking policy functionality with different roles.
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

## Query and Masking Demonstration

Run the `queries.sql` script to see how the masking policy works with different roles:
```sql
-- Contents of queries.sql
```

This demonstrates:
1. Column-level tagging with PII levels (PUBLIC, CONFIDENTIAL, RESTRICTED)
2. A function to determine user's clearance level based on role
3. A masking policy that shows or hides data based on the comparison of column tag and user clearance
4. Querying the data as different roles to see the masking in action