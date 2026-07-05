# Week 6: Geospatial Queries

Work with **geospatial data** in Snowflake — load polygon geometry, perform spatial joins, and identify which geographic regions intersect with Westminster constituencies.

## Challenge

Load point and polygon data from S3, infer the schema, create proper geometry tables, then join them using Snowflake's spatial functions to count intersecting constituencies per region.

## Key Concepts

- **GEOGRAPHY Type**: Store and query spatial data natively in Snowflake
- **`ST_INTERSECTS`**: Spatial join predicate — which polygons overlap?
- **`INFER_SCHEMA`**: Automatically detect column types from staged files
- **Spatial Joins**: Joining tables based on geographic relationships, not key columns

## Data Flow

```
S3 (public bucket)
    │
    ▼
External Stages (points + polygons)
    │
    ▼
COPY INTO → Raw tables
    │
    ▼
Transform → Polygon geometry tables
    │
    ▼
Spatial JOIN (ST_INTERSECTS)
    │
    ▼
Count intersecting constituencies per region
```

## Files

| File | Purpose |
|------|---------|
| `ddl.sql` | Creates stages, file formats, raw tables, and polygon geometry tables |
| `load_data.sql` | `COPY INTO` to load both point and polygon data from stages |
| `transformations.sql` | Not needed for this challenge |
| `queries.sql` | Data exploration and final spatial query solution |

## Setup & Execution

```sql
-- 1. Create all objects
\i week_6/ddl.sql

-- 2. Load spatial data from stages
\i week_6/load_data.sql

-- 3. Run the spatial analysis
\i week_6/queries.sql
```

## Expected Result

A table showing each nation/region and the count of Westminster constituencies that geographically intersect with it, sorted descending.

## What You'll Learn

- Loading and storing geospatial data in Snowflake
- Using `ST_INTERSECTS` for spatial joins
- How `INFER_SCHEMA` can simplify working with unknown file structures
- The difference between point and polygon geography types
