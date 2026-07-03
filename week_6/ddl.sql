CREATE DATABASE IF NOT EXISTS frosty_friday;

USE DATABASE frosty_friday;

CREATE SCHEMA IF NOT EXISTS week_6;

USE SCHEMA week_6;

CREATE STAGE IF NOT EXISTS nations_and_regions_stage;

CREATE OR REPLACE FILE FORMAT nations_and_regions_file_format
    TYPE = CSV;

CREATE STAGE IF NOT EXISTS westminster_constituency_points_stage;

CREATE OR REPLACE FILE FORMAT westminster_constituency_points_file_format
TYPE = CSV PARSE_HEADER = TRUE FIELD_OPTIONALLY_ENCLOSED_BY = '"';

CREATE OR REPLACE FILE FORMAT westminster_constituency_points_file_format_raw
TYPE = CSV SKIP_HEADER = 1 FIELD_OPTIONALLY_ENCLOSED_BY = '"';

CREATE OR REPLACE TABLE westminster_constituency_points (
    constituency string,
    sequence_num int,
    longitude double,
    latitude double,
    part int
);

CREATE TABLE IF NOT EXISTS nations_and_regions_points (
    nation_or_region_name STRING,
    type STRING,
    sequence_num INT,
    longitude DOUBLE,
    latitude DOUBLE,
    PART INT
);

CREATE OR REPLACE TABLE nations_and_regions_polygons AS
SELECT
    nation_or_region_name,
    ST_POLYGON(TO_GEOMETRY('LINESTRING(' || LISTAGG(CONCAT_WS(' ', longitude, latitude), ',') WITHIN GROUP (ORDER BY sequence_num) || ')')) AS polygon
FROM nations_and_regions_points
GROUP BY 1;

CREATE OR REPLACE TABLE westminster_constituency_polygons AS
SELECT
    constituency,
    ST_POLYGON(TO_GEOMETRY('LINESTRING(' || LISTAGG(CONCAT_WS(' ', longitude, latitude), ',') WITHIN GROUP (ORDER BY sequence_num) || ')')) AS polygon
FROM westminster_constituency_points
GROUP BY 1;