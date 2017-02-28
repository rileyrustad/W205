-- set hive.cli.print.header=true;

-- 1. Unstack the procedures so that each row corresponds to a hospital, 
-- and each column corresponds to a procedure

DROP TABLE unstack_readmissions;
CREATE TABLE unstack_readmissions
ROW FORMAT DELIMITED 
AS SELECT PROVIDER_ID,
1 AS ones, -- This allows me to do an equivilent of a cross join with min_max_readmissions table later
min(CASE WHEN MEASURE_ID = 'MORT_30_AMI' THEN SCORE END) AS MORT_30_AMI,
min(CASE WHEN MEASURE_ID = 'MORT_30_CABG' THEN SCORE END) AS MORT_30_CABG,
min(CASE WHEN MEASURE_ID = 'MORT_30_COPD' THEN SCORE END) AS MORT_30_COPD,
min(CASE WHEN MEASURE_ID = 'MORT_30_HF' THEN SCORE END) AS MORT_30_HF,
min(CASE WHEN MEASURE_ID = 'MORT_30_PN' THEN SCORE END) AS MORT_30_PN,
min(CASE WHEN MEASURE_ID = 'MORT_30_STK' THEN SCORE END) AS MORT_30_STK,
min(CASE WHEN MEASURE_ID = 'READM_30_AMI' THEN SCORE END) AS READM_30_AMI,
min(CASE WHEN MEASURE_ID = 'READM_30_CABG' THEN SCORE END) AS READM_30_CABG,
min(CASE WHEN MEASURE_ID = 'READM_30_COPD' THEN SCORE END) AS READM_30_COPD,
min(CASE WHEN MEASURE_ID = 'READM_30_HF' THEN SCORE END) AS READM_30_HF,
min(CASE WHEN MEASURE_ID = 'READM_30_HIP_KNEE' THEN SCORE END) AS READM_30_HIP_KNEE,
min(CASE WHEN MEASURE_ID = 'READM_30_HOSP_WIDE' THEN SCORE END) AS READM_30_HOSP_WIDE,
min(CASE WHEN MEASURE_ID = 'READM_30_PN' THEN SCORE END) AS READM_30_PN,
min(CASE WHEN MEASURE_ID = 'READM_30_STK' THEN SCORE END) AS READM_30_STK

FROM cleaned_readmissions
GROUP BY PROVIDER_ID;

-- select * from unstack_readmissions limit 10;

-- 2. Find the Min Max and Range of each procedure distribution.

DROP TABLE min_max_readmissions;
CREATE TABLE min_max_readmissions
ROW FORMAT DELIMITED
AS SELECT 
1 as ones, -- This allows me to do an equivilent of a cross join with unstack_readmissions table later
MAX(MORT_30_AMI) AS MaxMORT_30_AMI,
MIN(MORT_30_AMI) AS MinMORT_30_AMI,
MAX(MORT_30_AMI)-MIN(MORT_30_AMI) AS RangeMORT_30_AMI,
MAX(MORT_30_CABG) AS MaxMORT_30_CABG,
MIN(MORT_30_CABG) AS MinMORT_30_CABG,
MAX(MORT_30_CABG)-MIN(MORT_30_CABG) AS RangeMORT_30_CABG,
MAX(MORT_30_COPD) AS MaxMORT_30_COPD,
MIN(MORT_30_COPD) AS MinMORT_30_COPD,
MAX(MORT_30_COPD)-MIN(MORT_30_COPD) AS RangeMORT_30_COPD,
MAX(MORT_30_HF) AS MaxMORT_30_HF,
MIN(MORT_30_HF) AS MinMORT_30_HF,
MAX(MORT_30_HF)-MIN(MORT_30_HF) AS RangeMORT_30_HF,
MAX(MORT_30_PN) AS MaxMORT_30_PN,
MIN(MORT_30_PN) AS MinMORT_30_PN,
MAX(MORT_30_PN)-MIN(MORT_30_PN) AS RangeMORT_30_PN,
MAX(MORT_30_STK) AS MaxMORT_30_STK,
MIN(MORT_30_STK) AS MinMORT_30_STK,
MAX(MORT_30_STK)-MIN(MORT_30_STK) AS RangeMORT_30_STK,
MAX(READM_30_AMI) AS MaxREADM_30_AMI,
MIN(READM_30_AMI) AS MinREADM_30_AMI,
MAX(READM_30_AMI)-MIN(READM_30_AMI) AS RangeREADM_30_AMI,
MAX(READM_30_CABG) AS MaxREADM_30_CABG,
MIN(READM_30_CABG) AS MinREADM_30_CABG,
MAX(READM_30_CABG)-MIN(READM_30_CABG) AS RangeREADM_30_CABG,
MAX(READM_30_COPD) AS MaxREADM_30_COPD,
MIN(READM_30_COPD) AS MinREADM_30_COPD,
MAX(READM_30_COPD)-MIN(READM_30_COPD) AS RangeREADM_30_COPD,
MAX(READM_30_HF) AS MaxREADM_30_HF,
MIN(READM_30_HF) AS MinREADM_30_HF,
MAX(READM_30_HF)-MIN(READM_30_HF) AS RangeREADM_30_HF,
MAX(READM_30_HIP_KNEE) AS MaxREADM_30_HIP_KNEE,
MIN(READM_30_HIP_KNEE) AS MinREADM_30_HIP_KNEE,
MAX(READM_30_HIP_KNEE)-MIN(READM_30_HIP_KNEE) AS RangeREADM_30_HIP_KNEE,
MAX(READM_30_HOSP_WIDE) AS MaxREADM_30_HOSP_WIDE,
MIN(READM_30_HOSP_WIDE) AS MinREADM_30_HOSP_WIDE,
MAX(READM_30_HOSP_WIDE)-MIN(READM_30_HOSP_WIDE) AS RangeREADM_30_HOSP_WIDE,
MAX(READM_30_PN) AS MaxREADM_30_PN,
MIN(READM_30_PN) AS MinREADM_30_PN,
MAX(READM_30_PN)-MIN(READM_30_PN) AS RangeREADM_30_PN,
MAX(READM_30_STK) AS MaxREADM_30_STK,
MIN(READM_30_STK) AS MinREADM_30_STK,
MAX(READM_30_STK)-MIN(READM_30_STK) AS RangeREADM_30_STK
FROM unstack_readmissions;

-- select * from min_max_readmissions limit 10;

-- 3. Normalize each data point between 0 and 1 by it's range (Value - Min) / (Max - Min)

DROP TABLE norm_readmissions;
CREATE TABLE norm_readmissions
ROW FORMAT DELIMITED 
AS SELECT 
PROVIDER_ID,
(unstack.MORT_30_AMI - mm.MinMORT_30_AMI)/mm.RangeMORT_30_AMI As NormMORT_30_AMI,
(unstack.MORT_30_CABG - mm.MinMORT_30_CABG)/mm.RangeMORT_30_CABG As NormMORT_30_CABG,
(unstack.MORT_30_COPD - mm.MinMORT_30_COPD)/mm.RangeMORT_30_COPD As NormMORT_30_COPD,
(unstack.MORT_30_HF - mm.MinMORT_30_HF)/mm.RangeMORT_30_HF As NormMORT_30_HF,
(unstack.MORT_30_PN - mm.MinMORT_30_PN)/mm.RangeMORT_30_PN As NormMORT_30_PN,
(unstack.MORT_30_STK - mm.MinMORT_30_STK)/mm.RangeMORT_30_STK As NormMORT_30_STK,
(unstack.READM_30_AMI - mm.MinREADM_30_AMI)/mm.RangeREADM_30_AMI As NormREADM_30_AMI,
(unstack.READM_30_CABG - mm.MinREADM_30_CABG)/mm.RangeREADM_30_CABG As NormREADM_30_CABG,
(unstack.READM_30_COPD - mm.MinREADM_30_COPD)/mm.RangeREADM_30_COPD As NormREADM_30_COPD,
(unstack.READM_30_HF - mm.MinREADM_30_HF)/mm.RangeREADM_30_HF As NormREADM_30_HF,
(unstack.READM_30_HIP_KNEE - mm.MinREADM_30_HIP_KNEE)/mm.RangeREADM_30_HIP_KNEE As NormREADM_30_HIP_KNEE,
(unstack.READM_30_HOSP_WIDE - mm.MinREADM_30_HOSP_WIDE)/mm.RangeREADM_30_HOSP_WIDE As NormREADM_30_HOSP_WIDE,
(unstack.READM_30_PN - mm.MinREADM_30_PN)/mm.RangeREADM_30_PN As NormREADM_30_PN,
(unstack.READM_30_STK - mm.MinREADM_30_STK)/mm.RangeREADM_30_STK As NormREADM_30_STK

FROM unstack_readmissions unstack, min_max_readmissions mm
WHERE unstack.ones = mm.ones;
 -- This is where the "ones" come in handy.
-- This is basically a cross join, but min_max_readmissions is only one row
-- so there isn't as much computation as you'd think. It allows us to 
-- compare the value with its min/max/range values.

-- select * from norm_readmissions limit 10;

-- 4. Average the values across each row.(This ended up being a huge 
-- sticking point trying to deal with NULL values. The solution ended 
-- up being to use the NVL() function and conditional statments)

DROP TABLE counts_readmissions;
CREATE TABLE counts_readmissions
ROW FORMAT DELIMITED 
AS SELECT 
PROVIDER_ID,
SUM(NVL(NormMORT_30_AMI,0)+NVL(NormMORT_30_CABG,0)+NVL(NormMORT_30_COPD,0)+NVL(NormMORT_30_HF,0)+NVL(NormMORT_30_PN,0)+NVL(NormMORT_30_STK,0)+NVL(NormREADM_30_AMI,0)+NVL(NormREADM_30_CABG,0)+NVL(NormREADM_30_COPD,0)+NVL(NormREADM_30_HF,0)+NVL(NormREADM_30_HIP_KNEE,0)+NVL(NormREADM_30_HOSP_WIDE,0)+NVL(NormREADM_30_PN,0)+NVL(NormREADM_30_STK,0)) AS S,
-- ^NVL returns the value if not null, and 0 if null. The total sum is everything excluding NULLS
SUM(
(CASE WHEN NormMORT_30_AMI is null THEN 0 ELSE 1 END)+
(CASE WHEN NormMORT_30_CABG is null THEN 0 ELSE 1 END)+
(CASE WHEN NormMORT_30_COPD is null THEN 0 ELSE 1 END)+
(CASE WHEN NormMORT_30_HF is null THEN 0 ELSE 1 END)+
(CASE WHEN NormMORT_30_PN is null THEN 0 ELSE 1 END)+
(CASE WHEN NormMORT_30_STK is null THEN 0 ELSE 1 END)+
(CASE WHEN NormREADM_30_AMI is null THEN 0 ELSE 1 END)+
(CASE WHEN NormREADM_30_CABG is null THEN 0 ELSE 1 END)+
(CASE WHEN NormREADM_30_COPD is null THEN 0 ELSE 1 END)+
(CASE WHEN NormREADM_30_HF is null THEN 0 ELSE 1 END)+
(CASE WHEN NormREADM_30_HIP_KNEE is null THEN 0 ELSE 1 END)+
(CASE WHEN NormREADM_30_HOSP_WIDE is null THEN 0 ELSE 1 END)+
(CASE WHEN NormREADM_30_PN is null THEN 0 ELSE 1 END)+
(CASE WHEN NormREADM_30_STK is null THEN 0 ELSE 1 END)) AS T
-- Similar strategy as above. If value is NULL return 0 or else return 1. 
-- Add up all the ones, and we get the total number of Non NULL Values
from norm_readmissions
GROUP BY PROVIDER_ID;

-- select * from counts_readmissions limit 10;


-- 5. Join the Averages with the original table on Provider_ID 
-- to get the readmissions Names. Sort Decending, and you should have 
-- the top 10 unstack readmissionss.

DROP TABLE best_readmissions;
CREATE TABLE best_readmissions
ROW FORMAT DELIMITED 
AS SELECT 
hosp.PROVIDER_ID,
hosp.hospital_name AS readmissions_name,
counts.S/counts.T AS SCORE -- SUM(values)/Count(Values) = Average(Values)
from counts_readmissions counts, hospitals hosp
WHERE counts.PROVIDER_ID = hosp.PROVIDER_ID
AND T > 5 -- To ensure that the hospital has enough scores to be relevant
SORT BY SCORE DESC;

select * from best_readmissions limit 10;














