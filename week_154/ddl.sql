USE ROLE SYSADMIN;

CREATE DATABASE IF NOT EXISTS FROSTY_DB;
CREATE SCHEMA IF NOT EXISTS FROSTY_DB.WEEK_154;
USE SCHEMA FROSTY_DB.WEEK_154;

-- Raw staff schedule from shift managers (all VARCHAR — no type safety at all)
CREATE OR REPLACE TABLE STAFF_SCHEDULE_RAW (
    employee_id    VARCHAR,
    employee_name  VARCHAR,
    role           VARCHAR,
    hourly_rate    VARCHAR,
    shift_date     VARCHAR,
    shift_start    VARCHAR,
    shift_end      VARCHAR,
    hours_worked   VARCHAR
);

INSERT INTO STAFF_SCHEDULE_RAW VALUES
    ('E001', 'Yuki Tanaka',      'MANAGER',  '28.50', '2026-04-07', '08:00', '16:00', '8.0'),
    ('E002', 'Bjorn Frostvik',   'SCOOPER',  '16.00', '2026-04-07', '10:00', '18:00', '8.0'),
    ('E003', 'Luna Glacier',     'SCOOPER',  '15.50', '2026-04-07', '12:00', '20:00', '8.0'),
    ('E004', 'Kira Snowden',     'CASHIER',  '14.00', '2026-04-07', '09:00', '17:00', '8.0'),
    ('E005', 'Olaf Berg',        'DRIVER',   '20.00', '2026-04-07', '06:00', '14:00', '8.0'),
    ('E001', 'Yuki Tanaka',      'MANAGER',  '28.50', '2026-04-08', '08:00', '16:00', '8.0'),
    ('E002', 'Bjorn Frostvik',   'SCOOPER',  '16.00', '2026-04-08', '11:00', '19:00', '8.0'),
    ('E003', 'Luna Glacier',     'SCOOPER',  '10.00', '2026-04-08', '14:00', '22:00', '8.0'),
    ('E004', 'Kira Snowden',     'CASHIER',  '14.00', '2026-04-08', '09:00', '17:00', '8.0'),
    ('E005', 'Olaf Berg',        'DRIVER',   '20.00', '2026-04-08', '05:00', '18:00', '13.0'),
    ('E006', 'Freya Isdottir',   'SCOOPER',  '15.00', '2026-04-09', '10:00', '18:00', '8.0'),
    ('E001', 'Yuki Tanaka',      'MANAGER',  '28.50', '2026-04-09', '08:00', '16:00', '8.0'),
    ('E002', 'Bjorn Frostvik',   'SCOOPER',  '16.00', '2026-04-09', '10:00', '14:00', '4.0'),
    ('E007', 'Nils Vansen',      'INTERN',   '8.00',  '2026-04-09', '09:00', '17:00', '8.0'),
    ('E004', 'Kira Snowden',     'CASHIER',  '14.00', '2026-04-09', '09:00', '17:00', '8.0'),
    ('E005', 'Olaf Berg',        'DRIVER',   '20.00', '2026-04-09', '07:00', '15:00', '8.0'),
    ('E003', 'Luna Glacier',     'SCOOPER',  '15.50', '2026-04-10', '12:00', '20:00', '8.0'),
    ('E006', 'Freya Isdottir',   'SCOOPER',  '15.00', '2026-04-10', '10:00', '18:00', '8.0'),
    ('E001', 'Yuki Tanaka',      'MANAGER',  '28.50', '2026-04-10', '07:00', '17:00', '10.0'),
    ('E008', 'Sven Blizzard',    'SCOOPER',  '15.00', '2026-04-10', '20:00', '18:00', '-2.0');



     CREATE OR REPLACE TABLE STAFF_SCHEDULE (
        employee_id VARCHAR(4) NOT NULL,
        employee_name VARCHAR(50) NOT NULL,
        role VARCHAR(10) NOT NULL,
        hourly_rate NUMBER(5, 2) NOT NULL,
        shift_date DATE NOT NULL,
        shift_start TIME NOT NULL,
        shift_end TIME NOT NULL,
        hours_worked NUMBER(3, 1) NOT NULL,
        CONSTRAINT chk_valid_role CHECK (role IN ('MANAGER', 'SCOOPER', 'CASHIER', 'DRIVER')),
        CONSTRAINT chk_minimum_wage CHECK (hourly_rate > 12.0),
        CONSTRAINT chk_hours_valid CHECK(hours_worked BETWEEN 0 AND 12),
        CONSTRAINT chk_shift_order CHECK(shift_start < shift_end)
    );


    INSERT INTO STAFF_SCHEDULE
    SELECT
        employee_id,
        employee_name,
        role,
        hourly_rate::NUMBER(5,2),
        shift_date::DATE,
        shift_start::TIME,
        shift_end::TIME,
        hours_worked::NUMBER(3, 1)
    FROM STAFF_SCHEDULE_RAW;



    INSERT INTO STAFF_SCHEDULE
    SELECT
        employee_id,
        employee_name,
        role,
        hourly_rate::NUMBER(5,2),
        shift_date::DATE,
        shift_start::TIME,
        shift_end::TIME,
        hours_worked::NUMBER(3, 1)
    FROM STAFF_SCHEDULE_RAW
    WHERE role IN ('MANAGER', 'SCOOPER', 'CASHIER', 'DRIVER')
        AND hourly_rate::NUMBER(5,2) > 12.0
        AND hours_worked::NUMBER(3, 1) BETWEEN 0 AND 12
        AND shift_end::TIME > shift_start::TIME;

    SELECT
        employee_id,
        employee_name,
        shift_date,
        CASE
            WHEN NOT (role IN ('MANAGER', 'SCOOPER', 'CASHIER', 'DRIVER')) THEN 'Invalid role: ' || role
            WHEN hourly_rate::NUMBER(5,2) < 12.0 THEN 'Below minimum wage: $' || hourly_rate
            WHEN hours_worked::NUMBER(3, 1) > 12 THEN 'Exceeds 12-hour max: ' || hours_worked
            WHEN hours_worked::NUMBER(3, 1) < 0 THEN 'Non-positive hours: ' || hours_worked
        END AS violation_reason
    FROM STAFF_SCHEDULE_RAW
    WHERE NOT (role IN ('MANAGER', 'SCOOPER', 'CASHIER', 'DRIVER')
        AND hourly_rate::NUMBER(5,2) > 12.0
        AND hours_worked::NUMBER(3, 1) BETWEEN 0 AND 12
        AND shift_end::TIME > shift_start::TIME);

        select constraint_name, check_clause from INFORMATION_SCHEMA.CHECK_CONSTRAINTS;


    WITH X AS (
        select
            count(*) AS ROWS_LOADED,
            NULL AS total_raw_rows
        FROM STAFF_SCHEDULE
        UNION ALL
        SELECT NULL AS ROWS_LOADED,
            COUNT(*) AS total_raw_rows
        FROM STAFF_SCHEDULE_RAW
    ),
    y AS (
    SELECT MAX(ROWS_LOADED) AS ROWS_LOADED,
    MAX(total_raw_rows) AS total_raw_rows
    FROM X
    )
    SELECT ROWS_LOADED, total_raw_rows - ROWS_LOADED AS ROWS_REJECTED, total_raw_rows FROM Y