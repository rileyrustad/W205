rm -rf data/

hdfs dfs -rm -r hospital_compare

hive -f clean_up/clean_up.sql