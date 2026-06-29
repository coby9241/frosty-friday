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

-- SELECT $1, $2, $3, $4, $5 FROM @westminster_constituency_points_stage (file_format => 'westminster_constituency_points_file_format')

select $1, $2, $3, $4, $5 from @westminster_constituency_points_stage (file_format => 'westminster_constituency_points_file_format_raw');

SELECT *
FROM TABLE(
    INFER_SCHEMA(
        LOCATION => '@westminster_constituency_points_stage',
        FILE_FORMAT =>'westminster_constituency_points_file_format'
    )
);

CREATE OR REPLACE TABLE westminster_constituency_points (
    constituency string,
    sequence_num int,
    longitude double,
    latitude double,
    part int
);


--CREATE OR REPLACE TABLE westminster_constituency_points (
--    constituency string,
--    sequence_num int,
--    point GEOGRAPHY,
--    part int
--);

COPY INTO westminster_constituency_points FROM @westminster_constituency_points_stage
FILE_FORMAT = (
    FORMAT_NAME= 'westminster_constituency_points_file_format'
)
MATCH_BY_COLUMN_NAME=CASE_INSENSITIVE;

SELECT * FROM westminster_constituency_points;

CREATE TABLE IF NOT EXISTS nations_and_regions_points (
    nation_or_region_name STRING,
    type STRING,
    sequence_num INT,
    longitude DOUBLE,
    latitude DOUBLE,
    part INT
);

CREATE STAGE IF NOT EXISTS nations_and_regions_stage;

CREATE OR REPLACE FILE FORMAT nations_and_regions_file_format
TYPE = CSV PARSE_HEADER = TRUE FIELD_OPTIONALLY_ENCLOSED_BY = '"';

COPY INTO nations_and_regions_points FROM @nations_and_regions_stage
FILE_FORMAT = (
    FORMAT_NAME= 'nations_and_regions_file_format'
)
MATCH_BY_COLUMN_NAME=CASE_INSENSITIVE;

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

WITH joined AS (
    SELECT *
    FROM nations_and_regions_polygons AS nrp
        LEFT JOIN westminster_constituency_polygons AS wcp ON ST_INTERSECTS(nrp.polygon, wcp.polygon)
)

SELECT
    nation_or_region_name AS NATION_OR_REGION,
    COUNT(DISTINCT constituency) AS INTERSECTING_CONSTITUENCIES
FROM joined
GROUP BY 1
ORDER BY 2 DESC;
