# Lab 2

### 1. List the HDFS contents of /user

```
[root@ip-172-31-21-18 ~]# hdfs dfs -ls /user
Found 8 items
drwxr-xr-x   - mapred  supergroup          0 2017-01-23 15:59 /user/history
drwxrwxrwx   - hive    supergroup          0 2017-01-23 15:59 /user/hive
drwxrwxrwx   - hue     supergroup          0 2017-01-23 15:59 /user/hue
drwxrwxrwx   - jenkins supergroup          0 2017-01-23 15:59 /user/jenkins
drwxrwxrwx   - oozie   supergroup          0 2017-01-23 16:00 /user/oozie
drwxrwxrwx   - root    supergroup          0 2017-01-23 15:59 /user/root
drwxr-xr-x   - hdfs    supergroup          0 2017-01-23 16:01 /user/spark
drwxr-xr-x   - w205    supergroup          0 2017-01-23 16:06 /user/w205
```

### 2. Inspect the output of the HDFS admin report and answer the following questions in a text file.

##### Q1: How many live datanodes are there?

Live datanodes (1):

##### Q2: How much non-DFS storage is used?

Non DFS Used: 5474107392 (5.10 GB)

##### Q3: How much DFS storage is used?

DFS Used: 143515648 (136.87 MB)