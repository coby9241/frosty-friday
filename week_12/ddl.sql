CREATE DATABASE IF NOT EXISTS frosty_friday;

USE DATABASE frosty_friday;

CREATE SCHEMA IF NOT EXISTS week_12;

USE SCHEMA week_12;

create or replace table testing_data(id int autoincrement start 1 increment 1, product string, stock_amount int,date_of_check date);