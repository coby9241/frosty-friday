COPY INTO nations_and_regions_points FROM @nations_and_regions_stage
FILE_FORMAT = '(FORMAT => ''NATIONS_AND_REGIONS_FILE_FORMAT'')';

COPY INTO westminster_constituency_points FROM @westminster_constituency_points_stage
FILE_FORMAT = '(FORMAT => ''WESTMINSTER_CONSTITUENCY_POINTS_FILE_FORMAT'')';