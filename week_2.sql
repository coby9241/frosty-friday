CREATE OR REPLACE DATABASE frosty_friday;

USE DATABASE frosty_friday;

CREATE OR REPLACE SCHEMA week_2;

USE SCHEMA week_2;

-- load stage via Snowflake Web UI
CREATE OR REPLACE stage frosty_friday.week_2.week_2_employee_stage;

CREATE OR REPLACE file format week_2_parquet type = PARQUET;

SELECT $1 FROM @frosty_friday.week_2.week_2_employee_stage (file_format => 'week_2_parquet')

CREATE OR REPLACE TABLE stg_employees (
    data VARIANT
);

COPY INTO stg_employees FROM @week_2_employee_stage
FILE_FORMAT = 'week_2_parquet';

SELECT * FROM stg_employees;

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

INSERT INTO employees
SELECT
    data:city::STRING,
    data:country::STRING,
    data:country_code::STRING,
    data:dept::STRING,
    data:education::STRING,
    data:email::STRING,
    data:employee_id::INT,
    data:first_name::STRING,
    data:job_title::STRING,
    data:last_name::STRING,
    data:payroll_iban::STRING,
    data:postcode::STRING,
    data:street_name::STRING,
    data:street_num::INT,
    data:time_zone::STRING,
    data:title::STRING
FROM stg_employees;

CREATE OR REPLACE STREAM employees_stream
ON TABLE employees;

UPDATE employees SET COUNTRY = 'Japan' WHERE EMPLOYEE_ID = 8;
UPDATE employees SET LAST_NAME = 'Forester' WHERE EMPLOYEE_ID = 22;
UPDATE employees SET DEPT = 'Marketing' WHERE EMPLOYEE_ID = 25;
UPDATE employees SET TITLE = 'Ms' WHERE EMPLOYEE_ID = 32;
UPDATE employees SET JOB_TITLE = 'Senior Financial Analyst' WHERE EMPLOYEE_ID = 68;

SELECT * FROM employees_stream
