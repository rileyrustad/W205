-- set hive.cli.print.header=true;

-- 1. Unstack the procedures so that each row corresponds to a hospital, 
-- and each column corresponds to a procedure

DROP TABLE unstack_hospital;
CREATE TABLE unstack_hospital
ROW FORMAT DELIMITED 
AS SELECT PROVIDER_ID,
1 AS ones, -- This allows me to do an equivilent of a cross join with min_max_hospital table later
min(CASE WHEN MEASURE_ID = 'ED_1b' THEN SCORE END) AS ED_1b,
min(CASE WHEN MEASURE_ID = 'ED_2b' THEN SCORE END) AS ED_2b,
min(CASE WHEN MEASURE_ID = 'EDV' THEN SCORE END) AS EDV,
min(CASE WHEN MEASURE_ID = 'IMM_2' THEN SCORE END) AS IMM_2,
min(CASE WHEN MEASURE_ID = 'IMM_3_OP_27_FAC_ADHPCT' THEN SCORE END) AS IMM_3_OP_27_FAC_ADHPCT,
min(CASE WHEN MEASURE_ID = 'OP_1' THEN SCORE END) AS OP_1,
min(CASE WHEN MEASURE_ID = 'OP_18b' THEN SCORE END) AS OP_18b,
min(CASE WHEN MEASURE_ID = 'OP_2' THEN SCORE END) AS OP_2,
min(CASE WHEN MEASURE_ID = 'OP_20' THEN SCORE END) AS OP_20,
min(CASE WHEN MEASURE_ID = 'OP_21' THEN SCORE END) AS OP_21,
min(CASE WHEN MEASURE_ID = 'OP_22' THEN SCORE END) AS OP_22,
min(CASE WHEN MEASURE_ID = 'OP_23' THEN SCORE END) AS OP_23,
min(CASE WHEN MEASURE_ID = 'OP_29' THEN SCORE END) AS OP_29,
min(CASE WHEN MEASURE_ID = 'OP_30' THEN SCORE END) AS OP_30,
min(CASE WHEN MEASURE_ID = 'OP_31' THEN SCORE END) AS OP_31,
min(CASE WHEN MEASURE_ID = 'OP_3b' THEN SCORE END) AS OP_3b,
min(CASE WHEN MEASURE_ID = 'OP_4' THEN SCORE END) AS OP_4,
min(CASE WHEN MEASURE_ID = 'OP_5' THEN SCORE END) AS OP_5,
min(CASE WHEN MEASURE_ID = 'PC_01' THEN SCORE END) AS PC_01,
min(CASE WHEN MEASURE_ID = 'STK_4' THEN SCORE END) AS STK_4,
min(CASE WHEN MEASURE_ID = 'VTE_5' THEN SCORE END) AS VTE_5,
min(CASE WHEN MEASURE_ID = 'VTE_6' THEN SCORE END) AS VTE_6
FROM cleaned_effective_care
GROUP BY PROVIDER_ID;

-- select * from unstack_hospital limit 10;

-- 2. Find the Min Max and Range of each procedure distribution.

DROP TABLE min_max_hospital;
CREATE TABLE min_max_hospital
ROW FORMAT DELIMITED
AS SELECT 
1 as ones, -- This allows me to do an equivilent of a cross join with unstack_hospital table later
MAX(ED_1b) AS MaxED_1b,
MIN(ED_1b) AS MinED_1b,
MAX(ED_1b)-MIN(ED_1b) AS RangeED_1b,
MAX(ED_2b) AS MaxED_2b,
MIN(ED_2b) AS MinED_2b,
MAX(ED_2b)-MIN(ED_2b) AS RangeED_2b,
MAX(EDV) AS MaxEDV,
MIN(EDV) AS MinEDV,
MAX(EDV)-MIN(EDV) AS RangeEDV,
MAX(IMM_2) AS MaxIMM_2,
MIN(IMM_2) AS MinIMM_2,
MAX(IMM_2)-MIN(IMM_2) AS RangeIMM_2,
MAX(IMM_3_OP_27_FAC_ADHPCT) AS MaxIMM_3_OP_27_FAC_ADHPCT,
MIN(IMM_3_OP_27_FAC_ADHPCT) AS MinIMM_3_OP_27_FAC_ADHPCT,
MAX(IMM_3_OP_27_FAC_ADHPCT)-MIN(IMM_3_OP_27_FAC_ADHPCT) AS RangeIMM_3_OP_27_FAC_ADHPCT,
MAX(OP_1) AS MaxOP_1,
MIN(OP_1) AS MinOP_1,
MAX(OP_1)-MIN(OP_1) AS RangeOP_1,
MAX(OP_18b) AS MaxOP_18b,
MIN(OP_18b) AS MinOP_18b,
MAX(OP_18b)-MIN(OP_18b) AS RangeOP_18b,
MAX(OP_2) AS MaxOP_2,
MIN(OP_2) AS MinOP_2,
MAX(OP_2)-MIN(OP_2) AS RangeOP_2,
MAX(OP_20) AS MaxOP_20,
MIN(OP_20) AS MinOP_20,
MAX(OP_20)-MIN(OP_20) AS RangeOP_20,
MAX(OP_21) AS MaxOP_21,
MIN(OP_21) AS MinOP_21,
MAX(OP_21)-MIN(OP_21) AS RangeOP_21,
MAX(OP_22) AS MaxOP_22,
MIN(OP_22) AS MinOP_22,
MAX(OP_22)-MIN(OP_22) AS RangeOP_22,
MAX(OP_23) AS MaxOP_23,
MIN(OP_23) AS MinOP_23,
MAX(OP_23)-MIN(OP_23) AS RangeOP_23,
MAX(OP_29) AS MaxOP_29,
MIN(OP_29) AS MinOP_29,
MAX(OP_29)-MIN(OP_29) AS RangeOP_29,
MAX(OP_30) AS MaxOP_30,
MIN(OP_30) AS MinOP_30,
MAX(OP_30)-MIN(OP_30) AS RangeOP_30,
MAX(OP_31) AS MaxOP_31,
MIN(OP_31) AS MinOP_31,
MAX(OP_31)-MIN(OP_31) AS RangeOP_31,
MAX(OP_3b) AS MaxOP_3b,
MIN(OP_3b) AS MinOP_3b,
MAX(OP_3b)-MIN(OP_3b) AS RangeOP_3b,
MAX(OP_4) AS MaxOP_4,
MIN(OP_4) AS MinOP_4,
MAX(OP_4)-MIN(OP_4) AS RangeOP_4,
MAX(OP_5) AS MaxOP_5,
MIN(OP_5) AS MinOP_5,
MAX(OP_5)-MIN(OP_5) AS RangeOP_5,
MAX(PC_01) AS MaxPC_01,
MIN(PC_01) AS MinPC_01,
MAX(PC_01)-MIN(PC_01) AS RangePC_01,
MAX(STK_4) AS MaxSTK_4,
MIN(STK_4) AS MinSTK_4,
MAX(STK_4)-MIN(STK_4) AS RangeSTK_4,
MAX(VTE_5) AS MaxVTE_5,
MIN(VTE_5) AS MinVTE_5,
MAX(VTE_5)-MIN(VTE_5) AS RangeVTE_5,
MAX(VTE_6) AS MaxVTE_6,
MIN(VTE_6) AS MinVTE_6,
MAX(VTE_6)-MIN(VTE_6) AS RangeVTE_6
FROM unstack_hospital;

-- select * from min_max_hospital limit 10;


-- 3. Normalize each data point between 0 and 1 by it's range (Value - Min) / (Max - Min)

DROP TABLE norm_hospital;
CREATE TABLE norm_hospital
ROW FORMAT DELIMITED 
AS SELECT 
PROVIDER_ID,
(best.ED_1b - mm.MinED_1b)/mm.RangeED_1b AS NormED_1b,
(best.ED_2b - mm.MinED_2b)/mm.RangeED_2b AS NormED_2b,
(best.EDV - mm.MinEDV)/mm.RangeEDV AS NormEDV,
(best.IMM_2 - mm.MinIMM_2)/mm.RangeIMM_2 AS NormIMM_2,
(best.IMM_3_OP_27_FAC_ADHPCT - mm.MinIMM_3_OP_27_FAC_ADHPCT)/mm.RangeIMM_3_OP_27_FAC_ADHPCT AS NormIMM_3_OP_27_FAC_ADHPCT,
(best.OP_1 - mm.MinOP_1)/mm.RangeOP_1 AS NormOP_1,
(best.OP_18b - mm.MinOP_18b)/mm.RangeOP_18b AS NormOP_18b,
(best.OP_2 - mm.MinOP_2)/mm.RangeOP_2 AS NormOP_2,
(best.OP_20 - mm.MinOP_20)/mm.RangeOP_20 AS NormOP_20,
(best.OP_21 - mm.MinOP_21)/mm.RangeOP_21 AS NormOP_21,
(best.OP_22 - mm.MinOP_22)/mm.RangeOP_22 AS NormOP_22,
(best.OP_23 - mm.MinOP_23)/mm.RangeOP_23 AS NormOP_23,
(best.OP_29 - mm.MinOP_29)/mm.RangeOP_29 AS NormOP_29,
(best.OP_30 - mm.MinOP_30)/mm.RangeOP_30 AS NormOP_30,
(best.OP_31 - mm.MinOP_31)/mm.RangeOP_31 AS NormOP_31,
(best.OP_3b - mm.MinOP_3b)/mm.RangeOP_3b AS NormOP_3b,
(best.OP_4 - mm.MinOP_4)/mm.RangeOP_4 AS NormOP_4,
(best.OP_5 - mm.MinOP_5)/mm.RangeOP_5 AS NormOP_5,
(best.PC_01 - mm.MinPC_01)/mm.RangePC_01 AS NormPC_01,
(best.STK_4 - mm.MinSTK_4)/mm.RangeSTK_4 AS NormSTK_4,
(best.VTE_5 - mm.MinVTE_5)/mm.RangeVTE_5 AS NormVTE_5,
(best.VTE_6 - mm.MinVTE_6)/mm.RangeVTE_6 AS NormVTE_6
FROM unstack_hospital best, min_max_hospital mm;
WHERE best.ones = mm.ones; 
-- This is where the "ones" come in handy.
-- This is basically a cross join, but min_max_hospital is only one row
-- so there isn't as much computation as you'd think. It allows us to 
-- compare the value with its min/max/range values.

-- select * from norm_hospital limit 10;


-- 4. Average the values across each row.(This ended up being a huge 
-- sticking point trying to deal with NULL values. The solution ended 
-- up being to use the NVL() function and conditional statments)

DROP TABLE counts_hospital;
CREATE TABLE counts_hospital
ROW FORMAT DELIMITED 
AS SELECT 
PROVIDER_ID,
(SUM(NVL(NormED_1b,0)+NVL(NormED_2b,0)+NVL(NormEDV,0)+NVL(NormIMM_2,0)+NVL(NormIMM_3_OP_27_FAC_ADHPCT,0)+NVL(NormOP_1,0)+NVL(NormOP_18b,0)+NVL(NormOP_2,0)+NVL(NormOP_20,0)+NVL(NormOP_21,0)+NVL(NormOP_22,0)+NVL(NormOP_23,0)+NVL(NormOP_29,0)+NVL(NormOP_30,0)+NVL(NormOP_31,0)+NVL(NormOP_3b,0)+NVL(NormOP_4,0)+NVL(NormOP_5,0)+NVL(NormPC_01,0)+NVL(NormSTK_4,0)+NVL(NormVTE_5,0)+NVL(NormVTE_6,0))) AS S,
-- ^NVL returns the value if not null, and 0 if null. The total sum is everything excluding NULLS
SUM(
(CASE WHEN NormED_1b is null THEN 0 ELSE 1 END)+
(CASE WHEN NormED_2b is null THEN 0 ELSE 1 END)+
(CASE WHEN NormEDV is null THEN 0 ELSE 1 END)+
(CASE WHEN NormIMM_2 is null THEN 0 ELSE 1 END)+
(CASE WHEN NormIMM_3_OP_27_FAC_ADHPCT is null THEN 0 ELSE 1 END)+
(CASE WHEN NormOP_1 is null THEN 0 ELSE 1 END)+
(CASE WHEN NormOP_18b is null THEN 0 ELSE 1 END)+
(CASE WHEN NormOP_2 is null THEN 0 ELSE 1 END)+
(CASE WHEN NormOP_20 is null THEN 0 ELSE 1 END)+
(CASE WHEN NormOP_21 is null THEN 0 ELSE 1 END)+
(CASE WHEN NormOP_22 is null THEN 0 ELSE 1 END)+
(CASE WHEN NormOP_23 is null THEN 0 ELSE 1 END)+
(CASE WHEN NormOP_29 is null THEN 0 ELSE 1 END)+
(CASE WHEN NormOP_30 is null THEN 0 ELSE 1 END)+
(CASE WHEN NormOP_31 is null THEN 0 ELSE 1 END)+
(CASE WHEN NormOP_3b is null THEN 0 ELSE 1 END)+
(CASE WHEN NormOP_4 is null THEN 0 ELSE 1 END)+
(CASE WHEN NormOP_5 is null THEN 0 ELSE 1 END)+
(CASE WHEN NormPC_01 is null THEN 0 ELSE 1 END)+
(CASE WHEN NormSTK_4 is null THEN 0 ELSE 1 END)+
(CASE WHEN NormVTE_5 is null THEN 0 ELSE 1 END)+
(CASE WHEN NormVTE_6 is null THEN 0 ELSE 1 END)) AS T
-- Similar strategy as above. If value is NULL return 0 or else return 1. 
-- Add up all the ones, and we get the total count of Non NULL Values
from norm_hospital
GROUP BY PROVIDER_ID;

-- select * from counts_hospital limit 10;


-- 5. Join the Averages with the original table on Provider_ID 
-- to get the Hospital Names. Sort Decending, and you should have 
-- the top 10 best hospitals.

DROP TABLE best_hospital;
CREATE TABLE best_hospital
ROW FORMAT DELIMITED 
AS SELECT 
hosp.PROVIDER_ID,
hosp.hospital_name AS hospital_name,
counts.S/counts.T AS SCORE -- SUM(values)/Count(Values) = Average(Values)
from counts_hospital counts, hospitals hosp
WHERE counts.PROVIDER_ID = hosp.PROVIDER_ID
AND T > 5 --make sure hospitals have high enough number of scores to be relevant
SORT BY SCORE DESC;

select * from best_hospital limit 10;


