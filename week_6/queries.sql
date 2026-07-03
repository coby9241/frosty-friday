-- Initial data exploration
select $1, $2, $3, $4, $5 from @westminster_constituency_points_stage (file_format => 'westminster_constituency_points_file_format_raw');

SELECT *
FROM TABLE(
    INFER_SCHEMA(
        LOCATION => '@westminster_constituency_points_stage',
        FILE_FORMAT =>'westminster_constituency_points_file_format'
    )
);

SELECT * FROM westminster_constituency_points;

-- Final query to find intersecting constituencies
WITH joined AS (
    SELECT *
    FROM nations_and_regions_polygons AS nrp
        LEFT JOIN westminster_constituency_polygons AS wcp ON ST_INTERSECTS(nrp.polygon, wcp.polygon)
)

SELECT
    nation_or_region_name AS NATION_OR_REGION,
    COUNT(DISTINCT constituency) AS INTERSECTING_CONSTITUENCIES
FROM joined
GROUP BY 1
ORDER BY 2 DESC;