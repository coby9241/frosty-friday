CREATE OR REPLACE DYNAMIC TABLE SUMMIT_DASHBOARD (
    registration_id VARCHAR(8),
    attendee_name VARCHAR(50),
    company VARCHAR(50),
    session_id VARCHAR(6),
    session_title VARCHAR(100),
    track VARCHAR(30),
    day DATE,
    status VARCHAR(12),
    registered_at TIMESTAMP_NTZ,
    updated_at TIMESTAMP_NTZ
)
  TARGET_LAG = '1 MINUTE'
  WAREHOUSE = FROSTY_WH
  REFRESH_MODE = CUSTOM_INCREMENTAL
  INITIALIZE = ON_SCHEDULE
  REFRESH USING (
      MERGE INTO SELF AS tgt
      USING (
        SELECT
            regr.registration_id,
            regr.attendee_name,
            regr.company,
            sess.session_id,
            sess.session_title,
            sess.track,
            sess.day,
            regr.status,
            regr.registered_at,
            regr.updated_at,
            METADATA$ACTION,
            METADATA$ISUPDATE
        FROM REGISTRATIONS CHANGES() AS regr
            LEfT JOIN SESSIONS AS sess ON regr.session_id = sess.session_id
      ) AS src
      ON tgt.registration_id = src.registration_id
      WHEN MATCHED AND METADATA$ISUPDATE = TRUE THEN UPDATE SET
        tgt.attendee_name = src.attendee_name,
        tgt.company = src.company,
        tgt.session_id = src.session_id,
        tgt.session_title = src.session_title,
        tgt.track = src.track,
        tgt.day = src.day,
        tgt.status = src.status,
        tgt.registered_at = src.registered_at,
        tgt.updated_at = src.updated_at
      WHEN MATCHED AND METADATA$ACTION = 'DELETE' AND METADATA$ISUPDATE = FALSE THEN DELETE
      WHEN NOT MATCHED THEN INSERT (
        registration_id,
        attendee_name,
        company,
        session_id,
        session_title,
        track,
        day,
        status,
        registered_at,
        updated_at
      ) VALUES (
        src.registration_id,
        src.attendee_name,
        src.company,
        src.session_id,
        src.session_title,
        src.track,
        src.day,
        src.status,
        src.registered_at,
        src.updated_at
      )
  );

CREATE OR REPLACE DYNAMIC TABLE SESSION_HEADCOUNT (
    session_id VARCHAR(6),
    session_title VARCHAR(100),
    track VARCHAR(30),
    day DATE,
    registered INT,
    capacity INT,
    fill_pct NUMBER(5,1)
)
  TARGET_LAG = '1 MINUTE'
  WAREHOUSE = FROSTY_WH
  REFRESH USING (
    INSERT INTO SELF
    WITH X AS (
        SELECT
            sd.session_id,
            sd.session_title,
            sd.track,
            sd.day,
            SUM(CASE WHEN sd.status = 'REGISTERED' THEN 1 ELSE 0 END)::DOUBLE AS registered,
            sess.capacity
        FROM SUMMIT_DASHBOARD AS sd
            JOIN SESSIONS AS sess ON sd.session_id = sess.session_id
        GROUP BY 1, 2, 3, 4, 6
    )
    SELECT
        *,
        ROUND((registered / capacity) * 100, 1) AS fill_pct
    FROM X
  );



WITH X AS (
  SELECT DISTINCT
    sd.registration_id AS sri,
    regr.registration_id AS rri,
    sd.status
  FROM SUMMIT_DASHBOARD AS sd
    RIGHT JOIN REGISTRATIONS AS regr ON sd.registration_id = regr.registration_id
)
SELECT
    COUNT_IF(sri IS NOT NULL) AS total_in_dashboard,
    COUNT_IF(status = 'REGISTERED') AS active_registrations,
    COUNT_IF(status = 'CANCELLED') AS cancelled,
    COUNT_IF(rri IS NOT NULL) AS source_rows
FROM X;