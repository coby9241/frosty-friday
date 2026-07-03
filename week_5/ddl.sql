create table FF_week_5 AS SELECT 1 AS start_int;

CREATE OR REPLACE FUNCTION timesthree(i int)
returns int
language python
runtime_version = '3.13'
handler = 'timesthree'
AS
$$
def timesthree(i):
  return i*3
$$;