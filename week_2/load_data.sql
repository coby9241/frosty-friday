COPY INTO stg_employees FROM @week_2_employee_stage
FILE_FORMAT = 'week_2_parquet';