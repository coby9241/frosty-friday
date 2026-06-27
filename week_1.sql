CREATE DATABASE IF NOT EXISTS frosty_friday_challenge_1;

CREATE OR REPLACE FILE FORMAT frosty_friday_challenge_1_file_format
  TYPE = CSV FIELD_DELIMITER = ',';

CREATE OR REPLACE STAGE frosty_friday_challenge_1_stage
  URL = 's3://frostyfridaychallenges/challenge_1/';

SELECT $1, $2, $3 FROM @frosty_friday_challenge_1_stage (file_format => 'frosty_friday_challenge_1_file_format');
