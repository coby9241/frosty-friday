-- Queries to build history and demonstrate row-level security
use role user1;
select * from week7_villain_information;
use role user2;
select * from week7_monster_information;
use role user3;
select * from week7_weapon_storage_location;

-- Additional queries for audit/tag information
select query_tag from account_usage.query_history
where query_tag is not null and query_tag != '';
select * from account_usage.tag_references
WHERE tag_value = 'Level Super Secret A+++++++';