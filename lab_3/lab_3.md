# Lab 3

### List the execution time of the weblog aggregation query for Hive, SparkSQL, and SparkSQL on Parquet.

Hive - Total MapReduce CPU Time Spent: 10 seconds 80 msec
Spark - Time taken: 10.507 seconds, Fetched 50 row(s)
Parquet - Time taken: 3.288 seconds, Fetched 50 row(s)

### How many jobs does Hive launch? Does SparkSQL launch jobs?

Hive launched 2 jobs. If spark launched jobs, then it wasn't apparent from the command line output.

### Write a query which joins weblogs_parquet to user_info and counts the top 5 locations. List the locations.

input:

```
SELECT user_info.location, count(*) as count
FROM weblogs_parquet 
JOIN user_info 
ON (weblogs_parquet.user_id = user_info.user_id)
GROUP BY user_info.location
ORDER By count desc
LIMIT 5;
```

output:

```
La Fayette      49                                                              
Leeds	47
Blountsville	46
Hayden	45
Hamilton	45
Time taken: 2.692 seconds, Fetched 5 row(s)
```