COPY INTO stg_monarchs FROM (SELECT PARSE_JSON($1) FROM @monarchs_stage
(FILE_FORMAT => 'monarchs_file_format'));