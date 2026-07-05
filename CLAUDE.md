# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This repository contains the "Frosty Friday" weekly SQL/data engineering challenges. Each week contains a self-contained challenge focused on Snowflake/SQL concepts, organized in weekly directories (week_1 through week_12, with some weeks potentially missing).

## Weekly Challenge Structure

Each week follows a consistent structure:

- **ddl.sql**: Data Definition Language statements to set up the environment (databases, schemas, stages, file formats, tables, streams, stored procedures, etc.)
- **load_data.sql**: Data loading statements (typically COPY INTO commands to load data from stages into tables)
- **transformations.sql**: Data transformation statements (INSERT/UPDATE statements to transform and move data between tables)
- **queries.sql**: Final query or set of queries to execute/view the solution results
- **README.md**: Detailed explanation of the week's challenge, learning objectives, and setup instructions

## Common Development Commands

Since these are SQL challenges primarily designed for Snowflake, the typical workflow involves:

### Setting up a week's challenge
```sql
-- To set up the environment for any week:
\i week_X/ddl.sql

-- To load data (if applicable):
\i week_X/load_data.sql

-- To apply transformations (if applicable):
\i week_X/transformations.sql

-- To run the solution/query:
\i week_X/queries.sql
```

Note: These commands assume you're using a SQL client that supports the `\i` command (like SnowSQL). Adjust syntax for your specific SQL client as needed.

### Working with the Challenges

1. **Start with the README**: Each week's README.md contains the challenge description and learning objectives
2. **Review DDL first**: Understand the schema objects being created
3. **Examine the flow**: Look at load_data.sql → transformations.sql → queries.sql to understand the data pipeline
4. **Execute in order**: Run the files in the correct sequence to set up, load, transform, and query the data
5. **Experiment**: Modify queries to explore different approaches to the challenge

## Important Notes

- These challenges are designed to be run in a Snowflake environment
- The .env file contains Anthropic API configuration for use with Claude Code
- Some weeks may not use all file types (e.g., some weeks might not require data loading or transformations)
- Challenges build upon concepts introduced in previous weeks, though each can be attempted independently
- Focus on understanding the Snowflake-specific concepts being demonstrated each week

## Navigation

To see what weeks are available:
```bash
ls -d week_*
```

To view a specific week's challenge description:
```bash
cat week_X/README.md
```

Replace X with the week number you want to explore.