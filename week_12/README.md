# Week 12: Window Functions & NULL Handling

Use **window functions with `IGNORE NULLS`** to track inventory stock levels over time, properly handling NULL values that indicate out-of-stock items.

## Challenge

Build a query that shows the most recent stock check date and current stock level for each product, treating NULL stock amounts as "out of stock" and carrying forward the last known non-NULL value.

## Key Concepts

- **`IGNORE NULLS`**: Skip NULL values in window function calculations
- **`LAST_VALUE`**: Get the last non-NULL value in a window frame
- **`RANK() / DENSE_RANK()`**: Identify most recent records per product
- **NULL Semantics**: Use NULL to represent "out of stock" vs. 0 (which means "in stock, 0 units")

## Data Flow

```
DDL:
    CREATE TABLE testing_data (id AUTOINCREMENT, product, stock_amount, date_of_check)

Data:
    Each row = one stock check for one product on one date
    NULL stock_amount → product was out of stock at that check
    Non-NULL stock_amount → product had that many units in stock

Query:
    Partition by product
    → Apply LAST_VALUE IGNORE NULLS
    → Get most recent check date and non-NULL stock level per product
```

## Files

| File | Purpose |
|------|---------|
| `ddl.sql` | Creates database, schema, and inventory tracking table |
| `load_data.sql` | Inserts inventory check records over time with NULL values |
| `transformations.sql` | Not needed — all logic is in the query |
| `queries.sql` | Analyzes stock levels using window functions with IGNORE NULLS |

## Setup & Execution

```sql
-- 1. Create the table
\i week_12/ddl.sql

-- 2. Load inventory data (INSERT statements)
\i week_12/load_data.sql

-- 3. Run the stock analysis query
\i week_12/queries.sql
```

## Expected Result

A table with one row per product showing the most recent stock check date and the current stock level, with NULL values correctly interpreted as "out of stock" rather than treated as missing data.

## What You'll Learn

- Using `IGNORE NULLS` in window functions
- The difference between NULL and 0 in data semantics
- `LAST_VALUE` for carrying forward non-NULL values
- Partitioning data for per-product analysis
