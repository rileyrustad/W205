# Exercise 1 - Riley Rustad

In this assignment I'll be exploring the Hospital Consumer Assessment of Healthcare Providers and Systems - 2016 Dataset. I'll be evaluating hospitals based on their scores on key measures.

### 0. Log in
``1.`` SSH into your UCB Spring AMI on AWS
``2.`` Mount EBS Volume and get HDFS running

```sh
mount -t ext4 /dev/<your device> /data
/root/start-hadoop.sh
/data/start_postgres.sh
su - w205
/data/start_metastore.sh
```
``3.`` Clone this git repository and navigate to the exercise_1 directory
git clone git@github.com:rileyrustad/W205.git
cd W205/exercise_1
```

### 1. Load the Data
``1.`` Run the load_data_lake script. This downloads the data, cleans it, and loads it into HDFS (See Comments in [Code](TODO) for additional detail)

```sh
loading_and_modelling/load_data_lake.sh
```

``2.`` Run the hive_base_ddl.sql to load the tables in Hive (See Comments in [Code](TODO) for additional detail)

```sh
hive -f loading_and_modelling/hive_base_ddl.sql
```

### 2. Transform the Data. For the most part this is parsing data down to only the columns that we need and casting some columns to new data types.

```sh
hive -f transforming/transform.sql
```
Here is the ER Diagram for the schema that I designed for my tables. 
[](loading_and_modelling/ERDiagram.png)

### 3. Answer the Questions

##### What hospitals are models of high-quality care? That is, which hospitals have the most consistently high scores for a variety of procedures.

Given that we're prompted to look for high scores for a variety or procedures, I would say that the best place to look is the "Timely and Effective - Hospital" data. It measures individual hospitals on 22 different procedures, and gives them a score. That said, the scores aren't uniform some only go up to 100, and others range well beyond 1000. They'll need to be normalized if we want to do anything with them.

My plan of attack is to create normalized values between 0 and 1 for each of these procedures/hospital combinations, and then average them. There were some interesting/hacky things that I had to do to get there, but I was able to score them. (See Comments in [Code](TODO) for additional detail)

Run the Code:

```sh
hive -f investigations/best_hospitals/best_hospitals.sql
```

SPOILER ALERT: I found that the aggregated scores from this step negatively correlated with the survey data, which I found fishy. One would expect higher achievement scores would positively correlate with positive survey data. It makes me think that maybe some of those scores might not all be positively correlated measures, or that there are some really skewed distributions. 

1. Unstack the procedures so that each row corresponds to a hospital, and each column corresponds to a procedure
2. Find the Min Max and Range of each procedure distribution.
3. Normalize each data point between 0 and 1 by it's range (Value - Min) / (Max - Min)
4. Average the values across each row.(This ended up being a huge sticking point trying to deal with NULL values. The solution ended up being to use the NVL() function and conditional statments)
5. Join the Averages with the original table on Provider_ID to get the Hospital Names. Sort Decending, and you should have the top 10 best hospitals.

##### What states are models of high-quality care?

I did the identical Procedure as above just switching to the "Timely and Effective -State" dataset. There were only a few tweaks that I needed to make. Here's the [Code](TODO).

```sh
hive -f investigations/best_states/best_states.sql
```

##### Which procedures have the greatest variability between hospitals?

```sh
hive -f investigations/hospital_variability/hospital_variability.sql
```

##### Are average scores for hospital quality or procedural variability correlated with patient survey responses?

```sh
hive -f investigations/hospitals_and_patients/hospitals_and_patients.sql
```




TODO: Explain your hack around "ones" Which is basically a cross join with no real relationship. Every value crossed with every value. In our case its only one row being crossed against another table, so the size remains the same.



### Further Investigation

Given more time I'd like to incorporate more data besides the timely and effective data. I was set up to include the readmissions data too, but didn't quite make it.

I also noticed that there were footnotes in the "timely and effective" dataset, which gave more information about the sampling for specific measures. Things like "The number of cases/patients is too few to report.", "Data submitted were based on a sample of cases/patients.", and  "Results are based on a shorter time period than required." As of this point, my analysis doesn't take any of those into account. This information could be used to qualify/disqualify or maybe weight data to get a more accurate model.

