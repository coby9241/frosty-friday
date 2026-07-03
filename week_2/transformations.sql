INSERT INTO employees
SELECT
    data:city::STRING,
    data:country::STRING,
    data:country_code::STRING,
    data:dept::STRING,
    data:education::STRING,
    data:email::STRING,
    data:employee_id::INT,
    data:first_name::STRING,
    data:job_title::STRING,
    data:last_name::STRING,
    data:payroll_iban::STRING,
    data:postcode::STRING,
    data:street_name::STRING,
    data:street_num::INT,
    data:time_zone::STRING,
    data:title::STRING
FROM stg_employees;