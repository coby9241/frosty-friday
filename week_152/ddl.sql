USE ROLE SYSADMIN;

CREATE DATABASE IF NOT EXISTS FROSTY_DB;
CREATE SCHEMA IF NOT EXISTS FROSTY_DB.WEEK_152;
USE SCHEMA FROSTY_DB.WEEK_152;

-- Raw shipment manifest from partner warehouses (everything is VARCHAR — the wild west)
CREATE OR REPLACE TABLE RAW_SHIPMENTS (
    shipment_id    VARCHAR,
    sender         VARCHAR,
    recipient      VARCHAR,
    weight_kg      VARCHAR,
    destination    VARCHAR,
    priority       VARCHAR,
    delivery_date  VARCHAR
);

INSERT INTO RAW_SHIPMENTS VALUES
    ('SH-001', 'Polar Provisions',    'Ice Hotel Tromsoe',       '12.5',   'Tromsoe',         'STANDARD', '2026-04-01'),
    ('SH-002', 'Arctic Apothecary',   'Glacier General Store',  '3.2',    'Reykjavik',      'EXPRESS',  '2026-04-01'),
    ('SH-003', 'Tundra Tech',         'FrostByte Data Centre',  'heavy',  'Longyearbyen',   'EXPRESS',  '2026-04-02'),
    ('SH-004', 'Snowdrift Supplies',  'Camp Basecamp',          '45.0',   'Nuuk',           'STANDARD', '2026-04-02'),
    (NULL,     'Penguin Post',        'McMurdo Station',        '8.7',    'Antarctica',     'EXPRESS',  '2026-04-03'),
    ('SH-006', 'Blizzard Books',      'Library of the North',   '2.1',    'Murmansk',       'STANDARD', '2026-04-03'),
    ('SH-007', 'Icicle Instruments',  'Northern Philharmonic',  '67.3',   'Fairbanks',      'OVERNIGHT','2026-04-03'),
    ('SH-008', 'Frostbite Fashion',   'Aurora Boutique',        '1.8',    'Rovaniemi',      'EXPRESS',  '2026-04-04'),
    ('SH-009', 'Glacier Gourmet',     'Polar Bear Bistro',      '25.0',   'Hammerfest',     'STANDARD', '2026-04-04'),
    ('SH-010', 'Permafrost Parts',    'Snowmobile Central',     '120.5',  'Yellowknife',    'STANDARD', '2026-04-04'),
    ('SH-011', 'Chill Chemicals',     'Ice Core Lab',           '5.5',    'Summit Station', 'EXPRESS',  '2026-04-05'),
    ('SH-012', 'Arctic Apothecary',   'Glacier General Store',  '-3.0',   'Reykjavik',      'STANDARD', '2026-04-05'),
    ('SH-013', 'Snowdrift Supplies',  'Camp Basecamp',          '15.0',   'Nuuk',           'STANDARD', 'next tuesday'),
    ('SH-014', 'Tundra Tech',         'FrostByte Data Centre',  '9.9',    'Longyearbyen',   'EXPRESS',  '2026-04-06'),
    ('SH-015', 'Polar Provisions',    'Ice Hotel Tromsoe',       '7.7',    'Tromsoe',         'STANDARD', '2026-04-06'),
    ('SH-016', 'Blizzard Books',      'Library of the North',   '4.3',    'Murmansk',       'EXPRESS',  '2026-04-07'),
    ('SH-017', 'Icicle Instruments',  NULL,                     '22.0',   'Fairbanks',      'STANDARD', '2026-04-07'),
    ('SH-018', 'Glacier Gourmet',     'Polar Bear Bistro',      '11.1',   'Hammerfest',     'EXPRESS',  '2026-04-07');

CREATE OR REPLACE TABLE ERROR_LOGGING = TRUE (
    shipment_id VARCHAR(6) NOT NULL,
    sender VARCHAR(50),
    recipient VARCHAR(50) NOT NULL,
    weight_kg NUMBER(5, 1),
    destination VARCHAR(50),
    priority VARCHAR(8),
    delivery_date DATE
) ERROR_LOGGING = TRUE;


INSERT INTO DELIVERIES
SELECT
    shipment_id,
    sender,
    recipient,
    weight_kg::NUMBER(5, 1) AS weight_kg,
    destination,
    priority,
    delivery_date::DATE AS delivery_date
FROM RAW_SHIPMENTS;

SELECT
    ERROR_DATA:SHIPMENT_ID::VARCHAR AS SHIPMENT_ID,
    ERROR_DATA:SENDER::VARCHAR AS SENDER,
    ERROR_METADATA:error_source::VARCHAR AS PROBLEM_COLUMN,
    ERROR_METADATA:error_message::VARCHAR AS ERROR_MESSAGE
FROM ERROR_TABLE(DELIVERIES)
ORDER BY 1;


SELECT
    (SELECT COUNT(*) FROM DELIVERIES) AS rows_loaded,
    (SELECT COUNT(*) FROM ERROR_TABLE(DELIVERIES)) AS rows_rejected,
    (SELECT COUNT(*) FROM RAW_SHIPMENTS) AS total_raw_rows;