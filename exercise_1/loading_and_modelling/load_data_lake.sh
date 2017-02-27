#!/bin/bash
# Script that loads and models Hospital Data
# Run this script as the w205 user

# Download the Dataset
wget -O hospital.zip https://data.medicare.gov/views/bg9k-emty/files/6c902f45-e28b-42f5-9f96-ae9d1e583472?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip

# unzip the data into a temporary directory
mkdir temp_data
unzip hospital.zip -d temp_data


# Move relevant data to data directory. (I recognize that in production, duplicating data may not be wise, but I like to keep my workspace clean)
mkdir data
tail -n +2 temp_data/"Hospital General Information.csv" > data/hospitals.csv
tail -n +2 temp_data/"Timely and Effective Care - Hospital.csv" > data/effective_care.csv
tail -n +2 temp_data/"Timely and Effective Care - State.csv" > data/effective_care_state.csv
tail -n +2 temp_data/"Readmissions and Deaths - Hospital.csv" > data/readmissions.csv
tail -n +2 temp_data/"Payment and Value of Care - Hospital.csv" > data/payment.csv
tail -n +2 temp_data/"HCAHPS - Hospital.csv" > data/hcahps.csv



# Create directory within HDFS to compare hospitals
hdfs dfs -mkdir /user/w205/hospital_compare

# Create subdirectories for each CSV
hdfs dfs -mkdir hospital_compare/hospitals
hdfs dfs -mkdir hospital_compare/effective_care
hdfs dfs -mkdir hospital_compare/effective_care_state
hdfs dfs -mkdir hospital_compare/readmissions
hdfs dfs -mkdir hospital_compare/payment
hdfs dfs -mkdir hospital_compare/hcahps

# Loading files into the new directories

hdfs dfs -put data/hospitals.csv hospital_compare/hospitals
hdfs dfs -put data/effective_care.csv hospital_compare/effective_care
hdfs dfs -put data/effective_care_state.csv hospital_compare/effective_care_state
hdfs dfs -put data/readmissions.csv hospital_compare/readmissions
hdfs dfs -put data/payment.csv hospital_compare/payment
hdfs dfs -put data/hcahps.csv hospital_compare/hcahps


# Delete irrelevant data 
rm -rf temp_data
rm hospital.zip

