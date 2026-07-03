CREATE DATABASE IF NOT EXISTS frosty_friday;

USE DATABASE frosty_friday;

CREATE SCHEMA IF NOT EXISTS week_9;

USE SCHEMA week_9;

CREATE OR REPLACE TABLE data_to_be_masked(
    first_name varchar,
    last_name varchar,
    hero_name varchar
);

CREATE ROLE IF NOT EXISTS foo1;
CREATE ROLE IF NOT EXISTS foo2;
GRANT ROLE foo1 TO USER cloo;
GRANT ROLE foo2 TO USER cloo;

CREATE OR REPLACE TAG pii_level ALLOWED_VALUES 'PUBLIC', 'CONFIDENTIAL', 'RESTRICTED';
ALTER TABLE data_to_be_masked MODIFY COLUMN first_name SET TAG pii_level = 'CONFIDENTIAL';
ALTER TABLE data_to_be_masked MODIFY COLUMN last_name SET TAG pii_level = 'RESTRICTED';
ALTER TABLE data_to_be_masked MODIFY COLUMN hero_name SET TAG pii_level = 'PUBLIC';

CREATE OR REPLACE TABLE role_checker (
    role_name STRING,
    pii_level STRING
);

CREATE OR REPLACE FUNCTION get_pii_level(arg1 VARCHAR)
RETURNS VARCHAR
MEMORIZABLE
AS
$$
  WITH p AS (
      SELECT pii_level, 1 AS priority
      FROM role_checker
      WHERE UPPER(role_name) = UPPER(arg1)
      UNION ALL
      SELECT 'PUBLIC', 0 AS priority
  )
  SELECT pii_level
  FROM p
  ORDER BY priority DESC
  LIMIT 1
$$;

CREATE OR REPLACE MASKING POLICY PII_MASK AS (val varchar) RETURNS varchar ->
CASE
WHEN SYSTEM$GET_TAG_ON_CURRENT_COLUMN('frosty_friday.week_9.pii_level') = 'RESTRICTED'
    AND get_pii_level(CURRENT_ROLE()) = 'RESTRICTED' THEN val
WHEN SYSTEM$GET_TAG_ON_CURRENT_COLUMN('frosty_friday.week_9.pii_level') = 'CONFIDENTIAL'
    AND get_pii_level(CURRENT_ROLE()) IN ('RESTRICTED', 'CONFIDENTIAL') THEN val
WHEN SYSTEM$GET_TAG_ON_CURRENT_COLUMN('frosty_friday.week_9.pii_level') = 'PUBLIC' THEN val
ELSE '***'
END;

ALTER TAG pii_level SET MASKING POLICY PII_MASK;