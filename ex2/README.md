# Exercise 2

### How to Run the Application:

1. Make sure Postgres is running `/data/start_postgres.sh`
2. Clone the github respository `git clone git@github.com:rileyrustad/W205.git`
3. Navigate to the ex2 directory `cd ex2`
4. Edit the Twittercredentials.py file to us the Secret Key specific to your app.
4. Run the setup sql file `psql -d tcount -U postgres -f setup.sql`
5. Start the application `streamparse run`
6. One enough data is collected press **ctrl-c**
7. To view the full results run `python finalresults.py`
8. To see the results of a specific word, pass a word into our script `python finalresults.py <word>` (insert your specific word instead of <word>)
9. To see the results of all words within a specified range run `python histogram.py <#1>,<#2> 

