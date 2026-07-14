create or replace schema week_146;

create table week_146.data_table (id int);

INSERT INTO week_146.data_table (id)
VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);


ALTER TABLE data_table
  ADD DATA METRIC FUNCTION SNOWFLAKE.CORE.MAX ON (id)
  EXPECTATION max_value_eight (VALUE <= 8);

  select * from SNOWFLAKE.LOCAL.DATA_QUALITY_MONITORING_RESULTS;

  ALTER TABLE data_table SET
  DATA_METRIC_SCHEDULE = 'TRIGGER_ON_CHANGES';

SHOW PARAMETERS LIKE 'DATA_METRIC_SCHEDULE' IN TABLE data_table;


  ALTER TABLE data_table SET
  DATA_METRIC_SCHEDULE = '5 MINUTE';

  select SNOWFLAKE.CORE.MAX(select id from data_table)

INSERT INTO data_table (id)
VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);
