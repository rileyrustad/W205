-- hospitals

DROP TABLE cleaned_hospitals;
CREATE TABLE cleaned_hospitals 
ROW FORMAT DELIMITED
-- ROW FORMAT DELIMITED 
AS SELECT 
CAST(PROVIDER_ID AS INT), 
HOSPITAL_NAME, 
CITY, 
STATE, 
HOSPITAL_TYPE,
HOSPITAL_OWNERSHIP
FROM hospitals;

-- effective_care

DROP TABLE cleaned_effective_care;
CREATE TABLE cleaned_effective_care
ROW FORMAT DELIMITED
AS SELECT 
CAST(PROVIDER_ID AS INT), 
STATE
CONDITION, 
MEASURE_ID, 
MEASURE_NAME, 
CAST(SCORE AS INT), 
SAMPLE, 
FOOTNOTE, 
MEASURE_START_DATE, 
MEASURE_END_DATE
FROM effective_care;

-- effective_care_state

DROP TABLE cleaned_effective_care_state;
CREATE TABLE cleaned_effective_care_state
ROW FORMAT DELIMITED
AS SELECT 
CAST(PROVIDER_ID AS INT), 
STATE,
CONDITION, 
MEASURE_ID, 
MEASURE_NAME, 
CAST(SCORE AS INT)
FROM effective_care;

-- readmissions

DROP TABLE cleaned_readmissions;
CREATE TABLE cleaned_readmissions
ROW FORMAT DELIMITED
AS SELECT
CAST(PROVIDER_ID AS INT),
CAST(MEASURE_ID AS INT),
COMPARED_TO_NATIONAL,
DENOMINATOR,
CAST(SCORE AS INT),
LOWER_ESTIMATE,
HIGHER_ESTIMATE,
FOOTNOTE,
MEASURE_START_DATE,
MEASURE_END_DATE
FROM readmissions;

-- measures

DROP TABLE cleaned_measures;
CREATE TABLE cleaned_measures
ROW FORMAT DELIMITED
AS SELECT
MEASURE_NAME,
CAST(MEASURE_ID AS INT),
MEASURE_START_QUARTER,
MEASURE_START_DATE,
MEASURE_END_QUARTER,
MEASURE_END_DATE,
FOOTNOTE,
FOOTNOTE_TEXT
FROM measures;

-- survey_responses

DROP TABLE cleaned_survey_responses;
CREATE TABLE cleaned_survey_responses
ROW FORMAT DELIMITED
AS SELECT
PROVIDER_ID,
NURSES_DIMENSION_SCORE,
DOCTORS_DIMENSION_SCORE,
STAFF_DIMENSION_SCORE,
PAIN_DIMENSION_SCORE,
MEDS_DIMENSION_SCORE,
CLEAN_DIMENSION_SCORE,
DISCHARGE_DIMENSION_SCORE,
OVERALL_DIMENSION_SCORE,
HCAHPS_BASE_SCORE,
HCAHPS_CONSISTENCY_SCORE
FROM survey_responses;

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