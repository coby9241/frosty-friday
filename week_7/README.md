# Week 7: Frosty Friday Challenge

This directory contains the setup, data loading, and querying for the seventh Frosty Friday challenge, focusing on role-based access control and tagging.

## Files

- `ddl.sql`: Contains the DDL statements to create the database, warehouse, schemas, tables, tags, and roles.
- `load_data.sql`: Contains the INSERT statements to populate the tables with sample data.
- `transformations.sql`: Contains transformation statements (not used in this week's challenge).
- `queries.sql`: Contains queries to demonstrate data access with different roles and to audit tag usage.
- `README.md`: This file.

## Setup

Run the `ddl.sql` script to set up the environment:
```sql
-- Contents of ddl.sql
```

## Data Loading

Run the `load_data.sql` script to load sample data:
```sql
-- Contents of load_data.sql
```

## Query and Analysis

Run the `queries.sql` script to see how different roles can access data and to audit tag usage:
```sql
-- Contents of queries.sql
```

This challenge demonstrates:
- Role-based access control (RBAC) using custom roles
- Data tagging for security classification
- Querying data through different roles to show access restrictions
- Using account usage views to monitor query tags and tag associations