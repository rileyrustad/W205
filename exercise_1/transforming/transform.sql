-- hospitals

DROP TABLE cleaned_hospitals;
CREATE TABLE cleaned_hospitals 
ROW FORMAT DELIMITED
-- ROW FORMAT DELIMITED 
AS SELECT 
CAST(PROVIDER_ID AS INT), 
HOSPITAL_NAME
FROM hospitals;

-- effective_care

DROP TABLE cleaned_effective_care;
CREATE TABLE cleaned_effective_care
ROW FORMAT DELIMITED
AS SELECT 
CAST(PROVIDER_ID AS INT), 
MEASURE_ID,
CAST(SCORE AS INT)
FROM effective_care;

-- readmissions

DROP TABLE cleaned_readmissions;
CREATE TABLE cleaned_readmissions
ROW FORMAT DELIMITED
AS SELECT
CAST(PROVIDER_ID AS INT),
MEASURE_ID,
CAST(SCORE AS FLOAT),
CAST(LOWER_ESTIMATE AS FLOAT), -- Unused, but could be used for future investigation
CAST(HIGHER_ESTIMATE AS FLOAT) -- Unused, but could be used for future investigation
FROM readmissions;

-- readmissions_state

DROP TABLE cleaned_readmissions_state;
CREATE TABLE cleaned_readmissions_state
ROW FORMAT DELIMITED
AS SELECT
STATE,
MEASURE_ID,
CAST(NUMBER_OF_HOSPITALS_WORSE AS FLOAT), 
CAST(NUMBER_OF_HOSPITALS_SAME AS FLOAT), 
CAST(NUMBER_OF_HOSPITALS_BETTER AS FLOAT)
FROM readmissions_state;

-- hcahps

DROP TABLE cleaned_hcahps;
CREATE TABLE cleaned_hcahps
ROW FORMAT DELIMITED
AS SELECT
CAST(PROVIDER_ID AS INT),
HOSPITAL_NAME,
HCAHPS_MEASURE_ID,
HCAHPS_QUESTION,
CAST(HCAHPS_LINEAR_MEAN_VALUE AS INT)
FROM hcahps;
