-- Extract the Era field from the semi-structured JSON data in the staging table
SELECT data[0]:Era FROM stg_monarchs;