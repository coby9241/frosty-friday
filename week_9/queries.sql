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

SELECT get_pii_level(CURRENT_ROLE());

USE ROLE foo1;
SELECT CURRENT_ROLE();
SELECT * FROM data_to_be_masked;

USE ROLE foo2;
select * from data_to_be_masked;