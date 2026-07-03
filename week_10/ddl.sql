CREATE DATABASE IF NOT EXISTS frosty_friday;

USE DATABASE frosty_friday;

CREATE SCHEMA IF NOT EXISTS week_10;

USE SCHEMA week_10;
-- Create the warehouses
CREATE WAREHOUSE IF NOT EXISTS my_xsmall_wh WITH warehouse_size = XSMALL AUTO_SUSPEND = 120;
CREATE WAREHOUSE IF NOT EXISTS my_small_wh WITH warehouse_size = SMALL AUTO_SUSPEND = 120;
-- Create the table
CREATE OR REPLACE TABLE example_table(
    date_time DATETIME,
    trans_amount DOUBLE
);
-- Create the stage
CREATE OR REPLACE STAGE week_10_frosty_stage
URL = 's3://frostyfridaychallenges/challenge_10/';
-- Create the stored procedure
CREATE OR REPLACE PROCEDURE dynamic_warehouse_data_load(stage_name STRING, table_name STRING)
RETURNS STRING
LANGUAGE SQL
EXECUTE AS CALLER
AS
BEGIN
    LET result STRING DEFAULT '';
    LET ls RESULTSET := (LIST @IDENTIFIER(:stage_name));
    FOR r IN ls DO
        LET result := result || ', ' || r."name";
    END FOR;
    RETURN result;
END;