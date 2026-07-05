create or replace database FF_WEEK_7;
create or replace warehouse compute_wh with warehouse_size='X-SMALL';
use database FF_WEEK_7;
create schema super_weapons;
create schema super_monsters;
create schema super_villains;
create or replace table super_villains.villain_information (id INT,first_name VARCHAR(50),last_name VARCHAR(50),email VARCHAR(50),Alter_Ego VARCHAR(50));
create or replace table super_monsters.monster_information (id INT,monster VARCHAR(50),hideout_location VARCHAR(50));
create table super_weapons.weapon_storage_location (id INT,created_by VARCHAR(50),location VARCHAR(50),catch_phrase VARCHAR(50),weapon VARCHAR(50));
--Create Tags
create or replace tag security_class comment = 'sensitive data';
--Apply tags
alter table super_villains.villain_information set tag security_class = 'Level Super Secret A+++++++';
alter table super_monsters.monster_information set tag security_class = 'Level B';
alter table super_weapons.weapon_storage_location set tag security_class = 'Level Super Secret A+++++++';
--Create Roles
create role user1;
create role user2;
create role user3;
--Assign Roles to yourself with all needed privileges
grant role user1 to role accountadmin;
grant USAGE  on warehouse compute_wh to role user1;
grant usage on database ff_week_7 to role user1;
grant usage on all schemas in database ff_week_7 to role user1;
grant select on all tables in database ff_week_7 to role user1;
grant role user2 to role accountadmin;
grant USAGE  on warehouse compute_wh to role user2;
grant usage on database ff_week_7 to role user2;
grant usage on all schemas in database ff_week_7 to role user2;
grant select on all tables in database ff_week_7 to role user2;
grant role user3 to role accountadmin;
grant USAGE  on warehouse compute_wh to role user3;
grant usage on database ff_week_7 to role user3;
grant usage on all schemas in database ff_week_7 to role user3;
grant select on all tables in database ff_week_7 to role user3;
-- Note: The above covers the core challenge requirements.
-- Below is an alternative, simpler setup that uses a single 'challenges' schema
-- instead of the three separate schemas. Skip this section if you already ran
-- the setup above.
--
-- === Alternative Setup (single schema approach) ===
-- Uncomment and adjust the warehouse/database names below for your environment:

-- USE WAREHOUSE compute_wh;
-- USE DATABASE FF_WEEK_7;
-- CREATE SCHEMA IF NOT EXISTS challenges;
-- USE SCHEMA challenges;
--
-- create or replace table week7_villain_information (id INT,first_name VARCHAR(50),last_name VARCHAR(50),email VARCHAR(50),Alter_Ego VARCHAR(50));
-- create or replace table week7_monster_information (id INT,monster VARCHAR(50),hideout_location VARCHAR(50));
-- create table week7_weapon_storage_location (id INT,created_by VARCHAR(50),location VARCHAR(50),catch_phrase VARCHAR(50),weapon VARCHAR(50));
--
-- -- Create Tags
-- create or replace tag security_class comment = 'sensitive data';
--
-- -- Apply tags
-- alter table week7_villain_information set tag security_class = 'Level Super Secret A+++++++';
-- alter table week7_monster_information set tag security_class = 'Level B';
-- alter table week7_weapon_storage_location set tag security_class = 'Level Super Secret A+++++++';
--
-- -- Create Roles (skip if already created in the section above)
-- create role if not exists user1;
-- create role if not exists user2;
-- create role if not exists user3;
--
-- -- Assign Roles (adjust warehouse and database names for your environment)
-- grant role user1 to role accountadmin;
-- grant usage on warehouse <your_warehouse> to role user1;
-- grant usage on database <your_database> to role user1;
-- grant usage on schema <your_database>.challenges to role user1;
-- grant select on all tables in schema <your_database>.challenges to role user1;
-- grant role user2 to role accountadmin;
-- grant usage on warehouse <your_warehouse> to role user2;
-- grant usage on database <your_database> to role user2;
-- grant usage on schema <your_database>.challenges to role user2;
-- grant select on all tables in schema <your_database>.challenges to role user2;
-- grant role user3 to role accountadmin;
-- grant usage on warehouse <your_warehouse> to role user3;
-- grant usage on database <your_database> to role user3;
-- grant usage on schema <your_database>.challenges to role user3;
-- grant select on all tables in schema <your_database>.challenges to role user3;