import psycopg2
import sys

try:
    k1, k2 = sys.argv[1].split(",")
except ValueError:
    sys.exit()
except IndexError:
    sys.exit()

conn = psycopg2.connect(database="tcount", user="postgres", password="pass", host="localhost", port="5432")

cur = conn.cursor()

cur.execute("SELECT word, count from tweetwordcount WHERE count >= {} AND count <= {} ORDER BY word".format(k1, k2))

records = cur.fetchall()
for record in records:
    print"{}: {}".format(record[0], record[1])

conn.commit()

conn.close()




