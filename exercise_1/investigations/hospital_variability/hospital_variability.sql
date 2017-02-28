-- In order to avoid the complexity of the scores in the 
-- "Timely and Effective Dataset", I used the "Readmissions
-- and Deaths" Dataset.
DROP TABLE variability;
CREATE TABLE variability
SELECT MEASURE_ID, var_samp(counts.SCORE) AS VARIANCE, 
from cleaned_readmissions 
GROUP BY MEASURE_ID
SORT BY VARIANCE DESC;

select * from variablity limit 10;




-- -- I'll start with the normed scores from norm_readmissions
-- DROP TABLE z_score_readmissions;
-- CREATE TABLE z_score_readmissions
-- ROW FORMAT DELIMITED AS 
-- PROVIDER_ID,
-- (norm.NormMORT_30_AMI - avg_read.AvgMORT_30_AMI)/(avg_read.SDMORT_30_AMI) AS ZMORT_30_AMI,
-- (norm.NormMORT_30_CABG - avg_read.AvgMORT_30_CABG)/(avg_read.SDMORT_30_CABG) AS ZMORT_30_CABG,
-- (norm.NormMORT_30_COPD - avg_read.AvgMORT_30_COPD)/(avg_read.SDMORT_30_COPD) AS ZMORT_30_COPD,
-- (norm.NormMORT_30_HF - avg_read.AvgMORT_30_HF)/(avg_read.SDMORT_30_HF) AS ZMORT_30_HF,
-- (norm.NormMORT_30_PN - avg_read.AvgMORT_30_PN)/(avg_read.SDMORT_30_PN) AS ZMORT_30_PN,
-- (norm.NormMORT_30_STK - avg_read.AvgMORT_30_STK)/(avg_read.SDMORT_30_STK) AS ZMORT_30_STK,
-- (norm.NormREADM_30_AMI - avg_read.AvgREADM_30_AMI)/(avg_read.SDREADM_30_AMI) AS ZREADM_30_AMI,
-- (norm.NormREADM_30_CABG - avg_read.AvgREADM_30_CABG)/(avg_read.SDREADM_30_CABG) AS ZREADM_30_CABG,
-- (norm.NormREADM_30_COPD - avg_read.AvgREADM_30_COPD)/(avg_read.SDREADM_30_COPD) AS ZREADM_30_COPD,
-- (norm.NormREADM_30_HF - avg_read.AvgREADM_30_HF)/(avg_read.SDREADM_30_HF) AS ZREADM_30_HF,
-- (norm.NormREADM_30_HIP_KNEE - avg_read.AvgREADM_30_HIP_KNEE)/(avg_read.SDREADM_30_HIP_KNEE) AS ZREADM_30_HIP_KNEE,
-- (norm.NormREADM_30_HOSP_WIDE - avg_read.AvgREADM_30_HOSP_WIDE)/(avg_read.SDREADM_30_HOSP_WIDE) AS ZREADM_30_HOSP_WIDE,
-- (norm.NormREADM_30_PN - avg_read.AvgREADM_30_PN)/(avg_read.SDREADM_30_PN) AS ZREADM_30_PN,
-- (norm.NormREADM_30_STK - avg_read.AvgREADM_30_STK)/(avg_read.SDREADM_30_STK) AS ZREADM_30_STK

-- FROM norm_readmissions norm, 
-- (SELECT PROVIDER_ID,
-- AVG(MORT_30_AMI) AS AvgMORT_30_AMI,
-- STDDEV_SAMP(MORT_30_AMI) AS SDMORT_30_AMI,
-- AVG(MORT_30_CABG) AS AvgMORT_30_CABG,
-- STDDEV_SAMP(MORT_30_CABG) AS SDMORT_30_CABG,
-- AVG(MORT_30_COPD) AS AvgMORT_30_COPD,
-- STDDEV_SAMP(MORT_30_COPD) AS SDMORT_30_COPD,
-- AVG(MORT_30_HF) AS AvgMORT_30_HF,
-- STDDEV_SAMP(MORT_30_HF) AS SDMORT_30_HF,
-- AVG(MORT_30_PN) AS AvgMORT_30_PN,
-- STDDEV_SAMP(MORT_30_PN) AS SDMORT_30_PN,
-- AVG(MORT_30_STK) AS AvgMORT_30_STK,
-- STDDEV_SAMP(MORT_30_STK) AS SDMORT_30_STK,
-- AVG(READM_30_AMI) AS AvgREADM_30_AMI,
-- STDDEV_SAMP(READM_30_AMI) AS SDREADM_30_AMI,
-- AVG(READM_30_CABG) AS AvgREADM_30_CABG,
-- STDDEV_SAMP(READM_30_CABG) AS SDREADM_30_CABG,
-- AVG(READM_30_COPD) AS AvgREADM_30_COPD,
-- STDDEV_SAMP(READM_30_COPD) AS SDREADM_30_COPD,
-- AVG(READM_30_HF) AS AvgREADM_30_HF,
-- STDDEV_SAMP(READM_30_HF) AS SDREADM_30_HF,
-- AVG(READM_30_HIP_KNEE) AS AvgREADM_30_HIP_KNEE,
-- STDDEV_SAMP(READM_30_HIP_KNEE) AS SDREADM_30_HIP_KNEE,
-- AVG(READM_30_HOSP_WIDE) AS AvgREADM_30_HOSP_WIDE,
-- STDDEV_SAMP(READM_30_HOSP_WIDE) AS SDREADM_30_HOSP_WIDE,
-- AVG(READM_30_PN) AS AvgREADM_30_PN,
-- STDDEV_SAMP(READM_30_PN) AS SDREADM_30_PN,
-- AVG(READM_30_STK) AS AvgREADM_30_STK,
-- STDDEV_SAMP(READM_30_STK) AS SDREADM_30_STK
-- from norm_readmissions) avg_read
-- WHERE avg_read.PROVIDER_ID = norm.PROVIDER_ID;



-- DROP TABLE var_score_readmissions;
-- CREATE TABLE var_score_readmissions
-- ROW FORMAT DELIMITED AS 
-- SELECT PROVIDER_ID,
-- VAR_SAMP(ZMORT_30_AMI+ZMORT_30_CABG+ZMORT_30_COPD+ZMORT_30_HF+ZMORT_30_PN+ZMORT_30_STK+ZREADM_30_AMI+ZREADM_30_CABG+ZREADM_30_COPD+ZREADM_30_HF+ZREADM_30_HIP_KNEE+ZREADM_30_HOSP_WIDE+ZREADM_30_PN+ZREADM_30_STK) AS VARIANCE
-- from z_score_readmissions
-- GROUP BY PROVIDER_ID
-- SORT BY VARIANCE DESC;

-- DROP TABLE unstack_readmissions;
-- CREATE TABLE unstack_readmissions
-- ROW FORMAT DELIMITED 
-- AS SELECT 
-- hosp.PROVIDER_ID,
-- hosp.hospital_name AS hospital_name,
-- counts.S/counts.T AS SCORE -- SUM(values)/Count(Values) = Average(Values)
-- from counts_readmissions counts, hospitals hosp
-- WHERE counts.PROVIDER_ID = hosp.PROVIDER_ID
-- AND T > 5 -- To ensure that the hospital has enough scores to be relevant
-- SORT BY SCORE DESC;












