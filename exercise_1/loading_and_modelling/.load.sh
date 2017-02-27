Download the Dataset
wget -O hospital.zip https://data.medicare.gov/views/bg9k-emty/files/6c902f45-e28b-42f5-9f96-ae9d1e583472?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip

# unzip the data into a temporary directory
mkdir temp_data
unzip hospital.zip -d temp_data