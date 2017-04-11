import psycopg2
import sys

try:
    word = sys.argv[1]
except IndexError:
    word = None

conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")

cur = conn.cursor()

if word:
    cur.execute("SELECT word, count from tweetwordcount WHERE word = '{}'".format(word))
    records = cur.fetchall()
    if records:
        for record in records:
            print "{} occurs {} times".format(record[0], record[1])
    else:
        "{} doesn't occur in these tweets".format(word)
    conn.commit()

else:
    cur.execute("SELECT word, count from tweetwordcount ORDER BY word")
    records = cur.fetchall()
    for record in records:
        print "({}, {}),".format(record[0], record[1])
    conn.commit()

conn.close()

