
-- hospitals

DROP TABLE hospitals;

CREATE EXTERNAL TABLE hospitals (
PROVIDER_ID string, 
HOSPITAL_NAME string, 
ADDRESS string, 
CITY string, 
STATE string, 
ZIP_CODE string, 
COUNTY_NAME string, 
PHONE_NUMBER string, 
HOSPITAL_TYPE string, 
HOSPITAL_OWNERSHIP string, 
EMERGENCY_SERVICES string,
MEETS_CRITERIA_FOR_MEANINGFUL_USE_OF_EHRS string,
HOSPITAL_OVERALL_RATING string,
HOSPITAL_OVERALL_RATING_FOOTNOTE string,
MORTALITY_NATIONAL_COMPARISON string,
MORTALITY_NATIONAL_COMPARISON_FOOTNOTE string,
SAFETY_OF_CARE_NATIONAL_COMPARISON string,
SAFETY_OF_CARE_NATIONAL_COMPARISON_FOOTNOTE string,
READMISSION_NATIONAL_COMPARISON string,
READMISSION_NATIONAL_COMPARISON_FOOTNOTE string,
PATIENT_EXPERIENCE_NATIONAL_COMPARISON string,
PATIENT_EXPERIENCE_NATIONAL_COMPARISON_FOOTNOTE string,
EFFECTIVENESS_OF_CARE_NATIONAL_COMPARISON string,
EFFECTIVENESS_OF_CARE_NATIONAL_COMPARISON_FOOTNOTE string,
TIMELINESS_OF_CARE_NATIONAL_COMPARISON string,
TIMELINESS_OF_CARE_NATIONAL_COMPARISON_FOOTNOTE string,
EFFICIENT_USE_OF_MEDICAL_IMAGING_NATIONAL_COMPARISON string,
EFFICIENT_USE_OF_MEDICAL_IMAGING_NATIONAL_COMPARISON_FOOTNOTE string
)

ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
   "separatorChar" = ",",
   "quoteChar"     = '"',
   "escapeChar"    = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/hospitals';

-- effective_care

DROP TABLE effective_care;

CREATE EXTERNAL TABLE effective_care (
PROVIDER_ID string, 
HOSPITAL_NAME string, 
ADDRESS string, 
CITY string, 
STATE string, 
ZIP_CODE string, 
COUNTY_NAME string, 
PHONE_NUMBER string, 
CONDITION string, 
MEASURE_ID string, 
MEASURE_NAME string, 
SCORE string, 
SAMPLE string, 
FOOTNOTE string, 
MEASURE_START_DATE string,
MEASURE_END_DATE string
)

ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
   "separatorChar" = ",",
   "quoteChar"     = '"',
   "escapeChar"    = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/effective_care';

-- effective_care_state

DROP TABLE effective_care_state;

CREATE EXTERNAL TABLE effective_care_state (
STATE string, 
CONDITION string, 
MEASURE_NAME string, 
MEASURE_ID string, 
SCORE string, 
FOOTNOTE string, 
MEASURE_START_DATE string,
MEASURE_END_DATE string
)

ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
   "separatorChar" = ",",
   "quoteChar"     = '"',
   "escapeChar"    = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/effective_care_state';

-- readmissions

DROP TABLE readmissions;

CREATE EXTERNAL TABLE readmissions (
PROVIDER_ID string,
HOSPITAL_NAME string, 
ADDRESS string, 
CITY string, 
STATE string, 
ZIP_CODE string, 
COUNTY_NAME string, 
PHONE_NUMBER string, 
MEASURE_NAME string, 
MEASURE_ID string, 
COMPARED_TO_NATIONAL string, 
DENOMINATOR string, 
SCORE string, 
LOWER_ESTIMATE string, 
HIGHER_ESTIMATE string, 
FOOTNOTE string, 
MEASURE_START_DATE string,
MEASURE_END_DATE string
)

ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
   "separatorChar" = ",",
   "quoteChar"     = '"',
   "escapeChar"    = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/readmissions';


DROP TABLE hcahps;
CREATE EXTERNAL TABLE hcahps (
PROVIDER_ID string, 
HOSPITAL_NAME string, 
ADDRESS string, 
CITY string, 
STATE string, 
ZIP_CODE string, 
COUNTY_NAME string,
PHONE_NUMBER string,
HCAHPS_MEASURE_ID string,
HCAHPS_QUESTION string,
HCAHPS_ANSWER_DESCRIPTION string,
PATIENT_SURVEY_STAR_RATING string,
PATIENT_SURVEY_STAR_RATING_FOOTNOTE string,
HCAHPS_ANSWER_PERCENT string,
HCAHPS_ANSWER_PERCENT_FOOTNOTE string,
HCAHPS_LINEAR_MEAN_VALUE string,
NUMBER_OF_COMPLETED_SURVEYS string,
NUMBER_OF_COMPLETED_SURVEYS_FOOTNOTE string,
SURVEY_RESPONSE_RATE_PERCENT string,
SURVEY_RESPONSE_RATE_PERCENT_FOOTNOTE string,
MEASURE_START_DATE string,
MEASURE_END_DATE string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
   "separatorChar" = ",",
   "quoteChar"     = '"',
   "escapeChar"    = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/hcahps';





