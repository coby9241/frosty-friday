CREATE DATABASE IF NOT EXISTS frosty_friday;

USE DATABASE frosty_friday;

CREATE SCHEMA IF NOT EXISTS week_4;

USE SCHEMA week_4;

CREATE STAGE IF NOT EXISTS monarchs_stage;

CREATE OR REPLACE FILE FORMAT monarchs_file_format
  TYPE = JSON;

CREATE TABLE IF NOT EXISTS stg_monarchs (
    data VARIANT
);

CREATE TABLE monarchs AS
WITH unioned AS (
    SELECT
        stg_monarchs.data[0]:Era::STRING AS ERA,
        stg_monarchs.data[0]:Houses AS HOUSES
    FROM stg_monarchs
    UNION ALL
    SELECT
        stg_monarchs.data[1]:Era::STRING AS ERA,
        stg_monarchs.data[1]:Houses AS HOUSES
    FROM stg_monarchs
), x AS (
    SELECT
        ROW_NUMBER() OVER (ORDER BY monarchs.value:Birth::STRING) AS ID,
        ROW_NUMBER() OVER (PARTITION BY houses.value:House::STRING ORDER BY monarchs.index) AS INTER_HOUSE_ID,
        ERA,
        houses.value:House::STRING AS HOUSE,
        monarchs.value:Name::STRING AS NAME,
        monarchs.value:Nickname::STRING AS NICKNAME_1,
        monarchs.value:Nickname::STRING AS NICKNAME_2,
        monarchs.value:Nickname::STRING AS NICKNAME_3,
        monarchs.value:Birth::STRING AS BIRTH,
        monarchs.value:"Place of Birth" AS PLACE_OF_BIRTH,
        monarchs.value:"Start of Reign" AS START_OF_REIGN,
        monarchs.value:"Consort\/Queen Consort"[0]::STRING AS QUEEN_OR_QUEEN_CONSORT_1,
        monarchs.value:"Consort\/Queen Consort"[1]::STRING AS QUEEN_OR_QUEEN_CONSORT_2,
        monarchs.value:"Consort\/Queen Consort"[2]::STRING AS QUEEN_OR_QUEEN_CONSORT_3,
        monarchs.value:"End of Reign" AS END_OF_REIGN,
        monarchs.value:Duration::STRING AS DURATION,
        monarchs.value:Death::STRING AS DEATH,
        monarchs.value:"Age at Time of Death" AS AGE_AT_TIME_OF_DEATH_YEARS,
        monarchs.value:"Place of Death" AS PLACE_OF_DEATH,
        monarchs.value:"Burial Place" AS BURIAL_PLACE
    FROM unioned,
         LATERAL FLATTEN(input => HOUSES) houses,
         LATERAL FLATTEN(input => houses.value:Monarchs) monarchs
)
SELECT * FROM x
ORDER BY ID;