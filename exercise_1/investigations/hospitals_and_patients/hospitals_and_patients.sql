-- set hive.cli.print.header=true;

-- select * from avg_hospital limit 10;


DROP TABLE unstack_hcahps;
CREATE TABLE unstack_hcahps
ROW FORMAT DELIMITED 
AS SELECT PROVIDER_ID,
1 AS ones,
MAX(CASE WHEN HCAHPS_MEASURE_ID = 'H_CLEAN_LINEAR_SCORE' THEN HCAHPS_LINEAR_MEAN_VALUE END) AS H_CLEAN_LINEAR_SCORE,
MAX(CASE WHEN HCAHPS_MEASURE_ID = 'H_COMP_1_LINEAR_SCORE' THEN HCAHPS_LINEAR_MEAN_VALUE END) AS H_COMP_1_LINEAR_SCORE,
MAX(CASE WHEN HCAHPS_MEASURE_ID = 'H_COMP_2_LINEAR_SCORE' THEN HCAHPS_LINEAR_MEAN_VALUE END) AS H_COMP_2_LINEAR_SCORE,
MAX(CASE WHEN HCAHPS_MEASURE_ID = 'H_COMP_3_LINEAR_SCORE' THEN HCAHPS_LINEAR_MEAN_VALUE END) AS H_COMP_3_LINEAR_SCORE,
MAX(CASE WHEN HCAHPS_MEASURE_ID = 'H_COMP_4_LINEAR_SCORE' THEN HCAHPS_LINEAR_MEAN_VALUE END) AS H_COMP_4_LINEAR_SCORE,
MAX(CASE WHEN HCAHPS_MEASURE_ID = 'H_COMP_5_LINEAR_SCORE' THEN HCAHPS_LINEAR_MEAN_VALUE END) AS H_COMP_5_LINEAR_SCORE,
MAX(CASE WHEN HCAHPS_MEASURE_ID = 'H_COMP_7_LINEAR_SCORE' THEN HCAHPS_LINEAR_MEAN_VALUE END) AS H_COMP_7_LINEAR_SCORE,
MAX(CASE WHEN HCAHPS_MEASURE_ID = 'H_HSP_RATING_LINEAR_SCORE' THEN HCAHPS_LINEAR_MEAN_VALUE END) AS H_HSP_RATING_LINEAR_SCORE,
MAX(CASE WHEN HCAHPS_MEASURE_ID = 'H_QUIET_LINEAR_SCORE' THEN HCAHPS_LINEAR_MEAN_VALUE END) AS H_QUIET_LINEAR_SCORE,
MAX(CASE WHEN HCAHPS_MEASURE_ID = 'H_RECMND_LINEAR_SCORE' THEN HCAHPS_LINEAR_MEAN_VALUE END) AS H_RECMND_LINEAR_SCORE
FROM cleaned_hcahps
GROUP BY PROVIDER_ID;


-- select HCAHPS_MEASURE_ID from cleaned_hcahps limit 10;
-- select * from unstack_hcahps limit 5;


DROP TABLE min_max_hcahps;
CREATE TABLE min_max_hcahps
ROW FORMAT DELIMITED
AS SELECT
1 as ones,
MAX(H_CLEAN_LINEAR_SCORE) as MaxH_CLEAN_LINEAR_SCORE,
MIN(H_CLEAN_LINEAR_SCORE) as MinH_CLEAN_LINEAR_SCORE,
MAX(H_CLEAN_LINEAR_SCORE)-MIN(H_CLEAN_LINEAR_SCORE) as RangeH_CLEAN_LINEAR_SCORE,
MAX(H_COMP_1_LINEAR_SCORE) as MaxH_COMP_1_LINEAR_SCORE,
MIN(H_COMP_1_LINEAR_SCORE) as MinH_COMP_1_LINEAR_SCORE,
MAX(H_COMP_1_LINEAR_SCORE)-MIN(H_COMP_1_LINEAR_SCORE) as RangeH_COMP_1_LINEAR_SCORE,
MAX(H_COMP_2_LINEAR_SCORE) as MaxH_COMP_2_LINEAR_SCORE,
MIN(H_COMP_2_LINEAR_SCORE) as MinH_COMP_2_LINEAR_SCORE,
MAX(H_COMP_2_LINEAR_SCORE)-MIN(H_COMP_2_LINEAR_SCORE) as RangeH_COMP_2_LINEAR_SCORE,
MAX(H_COMP_3_LINEAR_SCORE) as MaxH_COMP_3_LINEAR_SCORE,
MIN(H_COMP_3_LINEAR_SCORE) as MinH_COMP_3_LINEAR_SCORE,
MAX(H_COMP_3_LINEAR_SCORE)-MIN(H_COMP_3_LINEAR_SCORE) as RangeH_COMP_3_LINEAR_SCORE,
MAX(H_COMP_4_LINEAR_SCORE) as MaxH_COMP_4_LINEAR_SCORE,
MIN(H_COMP_4_LINEAR_SCORE) as MinH_COMP_4_LINEAR_SCORE,
MAX(H_COMP_4_LINEAR_SCORE)-MIN(H_COMP_4_LINEAR_SCORE) as RangeH_COMP_4_LINEAR_SCORE,
MAX(H_COMP_5_LINEAR_SCORE) as MaxH_COMP_5_LINEAR_SCORE,
MIN(H_COMP_5_LINEAR_SCORE) as MinH_COMP_5_LINEAR_SCORE,
MAX(H_COMP_5_LINEAR_SCORE)-MIN(H_COMP_5_LINEAR_SCORE) as RangeH_COMP_5_LINEAR_SCORE,
MAX(H_COMP_7_LINEAR_SCORE) as MaxH_COMP_7_LINEAR_SCORE,
MIN(H_COMP_7_LINEAR_SCORE) as MinH_COMP_7_LINEAR_SCORE,
MAX(H_COMP_7_LINEAR_SCORE)-MIN(H_COMP_7_LINEAR_SCORE) as RangeH_COMP_7_LINEAR_SCORE,
MAX(H_HSP_RATING_LINEAR_SCORE) as MaxH_HSP_RATING_LINEAR_SCORE,
MIN(H_HSP_RATING_LINEAR_SCORE) as MinH_HSP_RATING_LINEAR_SCORE,
MAX(H_HSP_RATING_LINEAR_SCORE)-MIN(H_HSP_RATING_LINEAR_SCORE) as RangeH_HSP_RATING_LINEAR_SCORE,
MAX(H_QUIET_LINEAR_SCORE) as MaxH_QUIET_LINEAR_SCORE,
MIN(H_QUIET_LINEAR_SCORE) as MinH_QUIET_LINEAR_SCORE,
MAX(H_QUIET_LINEAR_SCORE)-MIN(H_QUIET_LINEAR_SCORE) as RangeH_QUIET_LINEAR_SCORE,
MAX(H_RECMND_LINEAR_SCORE) as MaxH_RECMND_LINEAR_SCORE,
MIN(H_RECMND_LINEAR_SCORE) as MinH_RECMND_LINEAR_SCORE,
MAX(H_RECMND_LINEAR_SCORE)-MIN(H_RECMND_LINEAR_SCORE) as RangeH_RECMND_LINEAR_SCORE
from unstack_hcahps;

-- select * from min_max_hcahps limit 5;



DROP TABLE norm_hcahps;
CREATE TABLE norm_hcahps
ROW FORMAT DELIMITED 
AS SELECT 
PROVIDER_ID,

(unstack.H_CLEAN_LINEAR_SCORE - mm.MinH_CLEAN_LINEAR_SCORE)/mm.RangeH_CLEAN_LINEAR_SCORE as NormH_CLEAN_LINEAR_SCORE,
(unstack.H_COMP_1_LINEAR_SCORE - mm.MinH_COMP_1_LINEAR_SCORE)/mm.RangeH_COMP_1_LINEAR_SCORE as NormH_COMP_1_LINEAR_SCORE,
(unstack.H_COMP_2_LINEAR_SCORE - mm.MinH_COMP_2_LINEAR_SCORE)/mm.RangeH_COMP_2_LINEAR_SCORE as NormH_COMP_2_LINEAR_SCORE,
(unstack.H_COMP_3_LINEAR_SCORE - mm.MinH_COMP_3_LINEAR_SCORE)/mm.RangeH_COMP_3_LINEAR_SCORE as NormH_COMP_3_LINEAR_SCORE,
(unstack.H_COMP_4_LINEAR_SCORE - mm.MinH_COMP_4_LINEAR_SCORE)/mm.RangeH_COMP_4_LINEAR_SCORE as NormH_COMP_4_LINEAR_SCORE,
(unstack.H_COMP_5_LINEAR_SCORE - mm.MinH_COMP_5_LINEAR_SCORE)/mm.RangeH_COMP_5_LINEAR_SCORE as NormH_COMP_5_LINEAR_SCORE,
(unstack.H_COMP_7_LINEAR_SCORE - mm.MinH_COMP_7_LINEAR_SCORE)/mm.RangeH_COMP_7_LINEAR_SCORE as NormH_COMP_7_LINEAR_SCORE,
(unstack.H_HSP_RATING_LINEAR_SCORE - mm.MinH_HSP_RATING_LINEAR_SCORE)/mm.RangeH_HSP_RATING_LINEAR_SCORE as NormH_HSP_RATING_LINEAR_SCORE,
(unstack.H_QUIET_LINEAR_SCORE - mm.MinH_QUIET_LINEAR_SCORE)/mm.RangeH_QUIET_LINEAR_SCORE as NormH_QUIET_LINEAR_SCORE,
(unstack.H_RECMND_LINEAR_SCORE - mm.MinH_RECMND_LINEAR_SCORE)/mm.RangeH_RECMND_LINEAR_SCORE as NormH_RECMND_LINEAR_SCORE

FROM unstack_hcahps unstack, min_max_hcahps mm
WHERE unstack.ones = mm.ones;

-- select * from norm_hcahps limit 5;

DROP TABLE counts_hcahps;
CREATE TABLE counts_hcahps
ROW FORMAT DELIMITED 
AS SELECT 
PROVIDER_ID,
SUM(NVL(NormH_CLEAN_LINEAR_SCORE,0)+NVL(NormH_COMP_1_LINEAR_SCORE,0)+NVL(NormH_COMP_2_LINEAR_SCORE,0)+NVL(NormH_COMP_3_LINEAR_SCORE,0)+NVL(NormH_COMP_4_LINEAR_SCORE,0)+NVL(NormH_COMP_5_LINEAR_SCORE,0)+NVL(NormH_COMP_7_LINEAR_SCORE,0)+NVL(NormH_HSP_RATING_LINEAR_SCORE,0)+NVL(NormH_QUIET_LINEAR_SCORE,0)+NVL(NormH_RECMND_LINEAR_SCORE,0)) AS S,
SUM(
(CASE WHEN NormH_CLEAN_LINEAR_SCORE is null THEN 0 ELSE 1 END)+
(CASE WHEN NormH_COMP_1_LINEAR_SCORE is null THEN 0 ELSE 1 END)+
(CASE WHEN NormH_COMP_2_LINEAR_SCORE is null THEN 0 ELSE 1 END)+
(CASE WHEN NormH_COMP_3_LINEAR_SCORE is null THEN 0 ELSE 1 END)+
(CASE WHEN NormH_COMP_4_LINEAR_SCORE is null THEN 0 ELSE 1 END)+
(CASE WHEN NormH_COMP_5_LINEAR_SCORE is null THEN 0 ELSE 1 END)+
(CASE WHEN NormH_COMP_7_LINEAR_SCORE is null THEN 0 ELSE 1 END)+
(CASE WHEN NormH_HSP_RATING_LINEAR_SCORE is null THEN 0 ELSE 1 END)+
(CASE WHEN NormH_QUIET_LINEAR_SCORE is null THEN 0 ELSE 1 END)+
(CASE WHEN NormH_RECMND_LINEAR_SCORE is null THEN 0 ELSE 1 END)) AS T
from norm_hcahps
GROUP BY PROVIDER_ID;

-- select * from counts_hcahps limit 5;

DROP TABLE best_hcahps;
CREATE TABLE best_hcahps
ROW FORMAT DELIMITED 
AS SELECT 
PROVIDER_ID,
counts.S/counts.T AS SCORE
from counts_hcahps counts
SORT BY SCORE DESC;


-- Other analysis, recheck with more uniform readmissions data

-- "Correlation between survey responses and readmissions scores"
-- I expect to get a negative correlation since the data dictionary
-- specifies "Lower percentages for readmission and mortality are better."

SELECT corr(a.SCORE, b.SCORE)
FROM best_hcahps a INNER JOIN best_readmissions b 
on a.PROVIDER_ID = b.PROVIDER_ID;

