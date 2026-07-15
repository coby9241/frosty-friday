CREATE JOIN POLICY my_join_policy
  AS () RETURNS JOIN_CONSTRAINT ->
    CASE
      WHEN CURRENT_ROLE() = 'ACCOUNTADMIN'
        THEN JOIN_CONSTRAINT(JOIN_REQUIRED => FALSE)
      ELSE JOIN_CONSTRAINT(JOIN_REQUIRED => TRUE)
    END;

CREATE OR REPLACE TABLE join_table (
    col1 INT,
    col2 VARCHAR,
    col3 NUMBER
)
JOIN POLICY my_join_policy;

-- Insert sample data
INSERT INTO join_table (col1, col2, col3)
VALUES (1, 'Sample Data', 123.45);

-- Create the secondary detail table
CREATE OR REPLACE TABLE join_table_details (
    col1 INT,
    col4 VARCHAR,
    col5 DATE
);

-- Insert additional info
INSERT INTO join_table_details (col1, col4, col5)
VALUES (1, 'Additional Info', '2025-03-07');

USE ROLE SYSADMIN;
select * from join_table