CREATE DATABASE IF NOT EXISTS frosty_friday;

USE DATABASE frosty_friday;

CREATE SCHEMA IF NOT EXISTS week_3;

USE SCHEMA week_3;

CREATE STAGE IF NOT EXISTS week_3_stage
URL = 's3://frostyfridaychallenges/challenge_3/';