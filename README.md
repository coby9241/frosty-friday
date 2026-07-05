# Frosty Friday 🥶

A collection of weekly SQL and data engineering challenges for **Snowflake**, created by the [Frosty Friday](https://frostyfriday.org/) community.

> **Purpose**: Sharpen your Snowflake skills through hands-on challenges covering everything from basic SQL to advanced concepts like streams, tasks, stored procedures, dynamic tables, and role-based access control.

---

## 📋 Prerequisites

- A **Snowflake** account (free trial works great)
- A SQL client — [SnowSQL](https://docs.snowflake.com/en/user-guide/snowsql), [Snowsight](https://docs.snowflake.com/en/user-guide/ui-snowsight), or any tool that can run `.sql` files
- Basic familiarity with SQL

---

## 🗂️ Repository Structure

Each week is self-contained in its own directory with consistent files:

```
week_X/
├── ddl.sql              # Database, schema, table, stage, file format creation
├── load_data.sql        # COPY INTO / INSERT statements to populate tables
├── transformations.sql  # Data transformation logic (INSERT, UPDATE, MERGE)
├── queries.sql          # Final solution query or analysis queries
└── README.md            # Challenge description, setup instructions, learning objectives
```

### Current Challenges

| Week | Topic | Key Concepts |
|------|-------|-------------|
| [1](week_1) | CSV File Loading | External stages, file formats, querying staged data |
| [2](week_2) | Streams & CDC | Change data capture, staging tables, streams |
| [3](week_3) | Task Scheduling | Scheduled tasks, DAGs, automation |
| [4](week_4) | Data Engineering (Views) | Views, CTEs, aggregation |
| [5](week_5) | Dynamic Tables | Automated data pipelines, incremental refresh |
| [6](week_6) | Geospatial | Geography types, spatial joins, `ST_INTERSECTS` |
| [7](week_7) | Access Control & Tagging | RBAC, tagging, object security |
| [8](week_8) | (Coming soon) | |
| [9](week_9) | Data Engineering (Time Travel / Clone) | `AT`/`BEFORE` clauses, cloning, time travel |
| [10](week_10) | Stored Procedures | Dynamic SQL, looping over stage files |
| [11](week_11) | (Coming soon) | |
| [12](week_12) | NULL Handling & Window Functions | `IGNORE NULLS`, `LAST_VALUE`, inventory tracking |

---

## 🚀 How to Use

1. **Choose a challenge** — start with week 1 if you're new, or jump to a topic that interests you
2. **Read the README** — each week explains the challenge and learning objectives
3. **Set up the environment** — run `ddl.sql` to create all needed objects
4. **Load data** — run `load_data.sql` (if applicable)
5. **Transform** — run `transformations.sql` (if applicable)
6. **Query** — run `queries.sql` to see the solution

**Example** (SnowSQL):
```sql
\i week_1/ddl.sql
\i week_1/load_data.sql
\i week_1/queries.sql
```

> ⚠️ **Note**: Weeks may rely on Snowflake-specific features (streams, tasks, geospatial, etc.). Some DDL includes placeholder values (`<your_warehouse>`, `<your_database>`) — replace these with your environment's names.

---

## 🎯 Learning Path

| Track | Weeks | Description |
|-------|-------|-------------|
| **Fundamentals** | 1, 4 | Stage loading, file formats, views, CTEs |
| **Data Pipelines** | 2, 3, 5 | Streams, tasks, dynamic tables |
| **Advanced SQL** | 6, 9, 12 | Geospatial, time travel, window functions |
| **Administration** | 7, 10 | RBAC, tagging, stored procedures |

---

## 🤝 Contributing

Want to add a week or improve an existing one? Contributions welcome!

- Keep the consistent 5-file structure
- Add comments explaining *why* each SQL pattern is used
- Update the root README's challenge table when adding a new week

---

## 📚 Resources

- [Frosty Friday official site](https://frostyfriday.org/)
- [Snowflake Documentation](https://docs.snowflake.com/)
- [Frosty Friday challenges blog](https://frostyfriday.org/blog/)

---

## 📄 License

This repository is for educational purposes. Challenge content is from Frosty Friday — all credit to the original authors.
