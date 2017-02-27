rm -rf data/

hdfs dfs -rm -rf hospital_compare/hospitals
hdfs dfs -rm -rf hospital_compare/effective_care
hdfs dfs -rm -rf hospital_compare/effective_care_state
hdfs dfs -rm -rf hospital_compare/readmissions
hdfs dfs -rm -rf hospital_compare/measures
hdfs dfs -rm -rf hospital_compare/survey_responses
hdfs dfs -rm -rf hospital_compare/payment
hdfs dfs -rm -rf hospital_compare/hcahps

hive -f clean_up/clean_up.sql