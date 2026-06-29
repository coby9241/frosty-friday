CREATE DATABASE IF NOT EXISTS frosty_friday;

USE DATABASE frosty_friday;

CREATE SCHEMA IF NOT EXISTS week_10;

USE SCHEMA week_10;
-- Create the warehouses
CREATE WAREHOUSE IF NOT EXISTS my_xsmall_whwith warehouse_size = XSMALLauto_suspend = 120;
CREATE WAREHOUSE IF NOT EXISTS my_small_whwith warehouse_size = SMALLauto_suspend = 120;
-- Create the table
CREATE OR REPLACE TABLE example_table(
    date_time datetime,
    trans_amount double
);
-- Create the stage
CREATE OR REPLACE STAGE week_10_frosty_stageurl = 's3://frostyfridaychallenges/challenge_10/'
file_format = <enter_file_format>;
-- Create the stored procedure
CREATE OR REPLACE PROCEDURE dynamic_warehouse_data_load(stage_name string, table_name string)
RETURNS string
AS
BEGIN
    LIST @my_stage;
    SELECT
        $1 AS file_name,
        $2 AS file_size_bytes
    FROM TABLE(RESULT_SCAN(LAST_QUERY_ID()));
END;
-- Call the stored procedure.
call dynamic_warehouse_data_load('week_10_frosty_friday_stage', 'example_table');