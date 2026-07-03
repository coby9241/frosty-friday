CREATE OR REPLACE DATABASE frosty_friday;

USE DATABASE frosty_friday;

CREATE OR REPLACE SCHEMA week_2;

USE SCHEMA week_2;

-- load stage via Snowflake Web UI
CREATE OR REPLACE stage frosty_friday.week_2.week_2_employee_stage;

CREATE OR REPLACE file format week_2_parquet type = PARQUET;

CREATE OR REPLACE TABLE stg_employees (
    data VARIANT
);

CREATE OR REPLACE TABLE employees (
    city STRING,
    country STRING,
    country_code STRING,
    dept STRING,
    education STRING,
    email STRING,
    employee_id INT,
    first_name STRING,
    job_title STRING,
    last_name STRING,
    payroll_iban STRING,
    postcode STRING,
    street_name STRING,
    street_num INT,
    time_zone STRING,
    title STRING
);

CREATE OR REPLACE STREAM employees_stream
ON TABLE employees;