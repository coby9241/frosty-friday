CREATE TABLE table1 (id INT,name STRING);

INSERT INTO table1 VALUES (1, 'dummy');

CREATE OR REPLACE DYNAMIC TABLE dynamic_table
TARGET_LAG = '1 minute'
WAREHOUSE = FROSTY_WH
AS
SELECT *
FROM table1;

CREATE OR ALTER TASK my_task
  WAREHOUSE = frosty_wh
  SCHEDULE = '60 MINUTES' AS
CREATE TABLE hourly_dynamic_table CLONE dynamic_table;