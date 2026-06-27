
create table FF_week_5 AS SELECT 1 AS start_int;

SELECT timesthree(start_int)FROM FF_week_5

select * from FF_week_5


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