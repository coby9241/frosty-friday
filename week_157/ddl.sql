USE ROLE SYSADMIN;

CREATE DATABASE IF NOT EXISTS FROSTY_DB;
CREATE SCHEMA IF NOT EXISTS FROSTY_DB.WEEK_157;
USE SCHEMA FROSTY_DB.WEEK_157;

CREATE OR REPLACE WAREHOUSE FROSTY_WH
  WAREHOUSE_SIZE = 'XSMALL'
  AUTO_SUSPEND = 60
  AUTO_RESUME = TRUE;

-- Summit sessions catalogue (static dimension)
CREATE OR REPLACE TABLE SESSIONS (
    session_id    VARCHAR(6)   NOT NULL,
    session_title VARCHAR(100) NOT NULL,
    track         VARCHAR(30)  NOT NULL,
    capacity      INT          NOT NULL,
    day           DATE         NOT NULL
);

INSERT INTO SESSIONS VALUES
    ('S001', 'Keynote: The Future of Data',         'General',       5000, '2026-06-03'),
    ('S002', 'Dynamic Tables Deep Dive',            'Engineering',    300, '2026-06-03'),
    ('S003', 'Cortex AI in Production',             'AI/ML',          400, '2026-06-03'),
    ('S004', 'Building Native Apps',                'Apps',           250, '2026-06-04'),
    ('S005', 'Iceberg & Open Formats',              'Engineering',    350, '2026-06-04'),
    ('S006', 'Data Governance at Scale',            'Governance',     200, '2026-06-04'),
    ('S007', 'Snowpark Container Services',         'Engineering',    300, '2026-06-05'),
    ('S008', 'Cost Optimization Masterclass',       'Administration', 250, '2026-06-05'),
    ('S009', 'Streaming & Real-Time Pipelines',     'Engineering',    350, '2026-06-05'),
    ('S010', 'Closing Keynote: Community Awards',   'General',       5000, '2026-06-05');

-- Raw registrations table (change-tracked source)
-- This simulates the CDC feed from the registration platform.
CREATE OR REPLACE TABLE REGISTRATIONS (
    registration_id VARCHAR(8)   NOT NULL,
    attendee_name   VARCHAR(50)  NOT NULL,
    attendee_email  VARCHAR(100) NOT NULL,
    company         VARCHAR(50)  NOT NULL,
    session_id      VARCHAR(6)   NOT NULL,
    status          VARCHAR(12)  NOT NULL,  -- REGISTERED, CANCELLED
    registered_at   TIMESTAMP_NTZ NOT NULL,
    updated_at      TIMESTAMP_NTZ NOT NULL,
    CONSTRAINT pk_registrations PRIMARY KEY (registration_id) RELY
);

-- Enable change tracking on the source
ALTER TABLE REGISTRATIONS SET CHANGE_TRACKING = TRUE;

-- Initial batch of registrations (the "historical" data already in the system)
INSERT INTO REGISTRATIONS VALUES
    ('R001', 'Alice Chen',      'alice@dataflow.io',     'DataFlow Inc',   'S001', 'REGISTERED', '2026-05-01 09:00:00', '2026-05-01 09:00:00'),
    ('R002', 'Bob Martinez',    'bob@snowpros.com',      'SnowPros LLC',   'S002', 'REGISTERED', '2026-05-01 09:15:00', '2026-05-01 09:15:00'),
    ('R003', 'Carol Johansson', 'carol@nordicdata.se',   'Nordic Data AB', 'S003', 'REGISTERED', '2026-05-01 10:00:00', '2026-05-01 10:00:00'),
    ('R004', 'Dave Kim',        'dave@querycraft.kr',    'QueryCraft',     'S005', 'REGISTERED', '2026-05-02 08:30:00', '2026-05-02 08:30:00'),
    ('R005', 'Eve Novak',       'eve@frostbyte.cz',     'FrostByte s.r.o','S001', 'REGISTERED', '2026-05-02 11:00:00', '2026-05-02 11:00:00'),
    ('R006', 'Frank Liu',       'frank@icebreaker.cn',   'Icebreaker Ltd', 'S004', 'REGISTERED', '2026-05-03 14:00:00', '2026-05-03 14:00:00'),
    ('R007', 'Grace Okafor',    'grace@polarpipe.ng',    'PolarPipe',      'S006', 'REGISTERED', '2026-05-03 15:30:00', '2026-05-03 15:30:00'),
    ('R008', 'Hiro Tanaka',     'hiro@blizzardbi.jp',   'BlizzardBI',     'S007', 'REGISTERED', '2026-05-04 09:00:00', '2026-05-04 09:00:00'),
    ('R009', 'Ines Bergmann',   'ines@alpineml.de',      'Alpine ML',      'S003', 'REGISTERED', '2026-05-04 10:30:00', '2026-05-04 10:30:00'),
    ('R010', 'Jake Thompson',   'jake@summitdata.us',    'Summit Data Co', 'S008', 'REGISTERED', '2026-05-05 07:45:00', '2026-05-05 07:45:00'),
    ('R011', 'Kaya Petrov',     'kaya@glacierdb.bg',     'GlacierDB',      'S009', 'REGISTERED', '2026-05-05 13:00:00', '2026-05-05 13:00:00'),
    ('R012', 'Liam Frost',      'liam@tundratech.ca',    'TundraTech',     'S002', 'REGISTERED', '2026-05-06 08:00:00', '2026-05-06 08:00:00'),
    ('R013', 'Mia Santos',      'mia@snowbound.br',      'Snowbound',      'S010', 'REGISTERED', '2026-05-06 09:30:00', '2026-05-06 09:30:00'),
    ('R014', 'Noah Fischer',    'noah@permafrost.at',    'Permafrost GmbH','S005', 'REGISTERED', '2026-05-07 11:00:00', '2026-05-07 11:00:00'),
    ('R015', 'Olivia Park',     'olivia@arcticai.kr',    'Arctic AI',      'S003', 'REGISTERED', '2026-05-07 14:15:00', '2026-05-07 14:15:00');