CREATE DATABASE IF NOT EXISTS frosty_friday;

USE DATABASE frosty_friday;

CREATE SCHEMA IF NOT EXISTS week_9;

USE SCHEMA week_9;

CREATE OR REPLACE TABLE data_to_be_masked(
    first_name varchar,
    last_name varchar,
    hero_name varchar
);

INSERT INTO data_to_be_masked (first_name, last_name, hero_name)
VALUES ('Eveleen', 'Danzelman','The Quiet Antman');
INSERT INTO data_to_be_masked (first_name, last_name, hero_name)
VALUES ('Harlie', 'Filipowicz','The Yellow Vulture');
INSERT INTO data_to_be_masked (first_name, last_name, hero_name)
VALUES ('Mozes', 'McWhin','The Broken Shaman');
INSERT INTO data_to_be_masked (first_name, last_name, hero_name)
VALUES ('Horatio', 'Hamshere','The Quiet Charmer');
INSERT INTO data_to_be_masked (first_name, last_name, hero_name)
VALUES ('Julianna', 'Pellington','Professor Ancient Spectacle');
INSERT INTO data_to_be_masked (first_name, last_name, hero_name)
VALUES ('Grenville', 'Southouse','Fire Wonder');
INSERT INTO data_to_be_masked (first_name, last_name, hero_name)
VALUES ('Analise', 'Beards','Purple Fighter');
INSERT INTO data_to_be_masked (first_name, last_name, hero_name)
VALUES ('Darnell', 'Bims','Mister Majestic Mothman');
INSERT INTO data_to_be_masked (first_name, last_name, hero_name)
VALUES ('Micky', 'Shillan','Switcher');
INSERT INTO data_to_be_masked (first_name, last_name, hero_name)
VALUES ('Ware', 'Ledstone','Optimo');

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

INSERT INTO role_checker (role_name, pii_level) VALUES ('ACCOUNTADMIN', 'PUBLIC');
INSERT INTO role_checker (role_name, pii_level) VALUES ('foo2', 'RESTRICTED');
INSERT INTO role_checker (role_name, pii_level) VALUES ('foo1', 'CONFIDENTIAL');

SELECT * FROM role_checker;

CREATE OR REPLACE FUNCTION get_pii_level(arg1 VARCHAR)
RETURNS VARCHAR
MEMOIZABLE
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

SELECT get_pii_level(CURRENT_ROLE())


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

USE ROLE foo1;
SELECT CURRENT_ROLE();
SELECT * FROM data_to_be_masked;

USE ROLE foo2;
select * from data_to_be_maskedCREATE DATABASE IF NOT EXISTS frosty_friday;

USE DATABASE frosty_friday;

CREATE SCHEMA IF NOT EXISTS week_9;

USE SCHEMA week_9;

CREATE OR REPLACE TABLE data_to_be_masked(
    first_name varchar,
    last_name varchar,
    hero_name varchar
);

INSERT INTO data_to_be_masked (first_name, last_name, hero_name)
VALUES ('Eveleen', 'Danzelman','The Quiet Antman');
INSERT INTO data_to_be_masked (first_name, last_name, hero_name)
VALUES ('Harlie', 'Filipowicz','The Yellow Vulture');
INSERT INTO data_to_be_masked (first_name, last_name, hero_name)
VALUES ('Mozes', 'McWhin','The Broken Shaman');
INSERT INTO data_to_be_masked (first_name, last_name, hero_name)
VALUES ('Horatio', 'Hamshere','The Quiet Charmer');
INSERT INTO data_to_be_masked (first_name, last_name, hero_name)
VALUES ('Julianna', 'Pellington','Professor Ancient Spectacle');
INSERT INTO data_to_be_masked (first_name, last_name, hero_name)
VALUES ('Grenville', 'Southouse','Fire Wonder');
INSERT INTO data_to_be_masked (first_name, last_name, hero_name)
VALUES ('Analise', 'Beards','Purple Fighter');
INSERT INTO data_to_be_masked (first_name, last_name, hero_name)
VALUES ('Darnell', 'Bims','Mister Majestic Mothman');
INSERT INTO data_to_be_masked (first_name, last_name, hero_name)
VALUES ('Micky', 'Shillan','Switcher');
INSERT INTO data_to_be_masked (first_name, last_name, hero_name)
VALUES ('Ware', 'Ledstone','Optimo');

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

INSERT INTO role_checker (role_name, pii_level) VALUES ('ACCOUNTADMIN', 'PUBLIC');
INSERT INTO role_checker (role_name, pii_level) VALUES ('foo2', 'RESTRICTED');
INSERT INTO role_checker (role_name, pii_level) VALUES ('foo1', 'CONFIDENTIAL');

SELECT * FROM role_checker;

CREATE OR REPLACE FUNCTION get_pii_level(arg1 VARCHAR)
RETURNS VARCHAR
MEMOIZABLE
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

SELECT get_pii_level(CURRENT_ROLE())


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

USE ROLE foo1;
SELECT CURRENT_ROLE();
SELECT * FROM data_to_be_masked;

USE ROLE foo2;
select * from data_to_be_masked;