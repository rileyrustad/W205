# Lab 4

### SUBMISSION 1:

**Create an RDD with tuples were the there is a key and a value. But in contrast to the example above the key is removed from the value portion of the key-value tuple. Submit the code and a print out of the first tuple.

You can perform many operations once you have a key value tuple. You can join, reduce, map, and so on. You can read about the operations in the RDD Spark Programming Guide. One operation you can do is to sort by key:**

```
>>> narcoticsCrimeTuples = narcoticsCrimes.map(lambda x:(x.split(",")[0], ','.join((x.split(",")[1:]))))

>>> narcoticsCrimeTuples.first()
(u'10184515', u'HY372204,08/06/2015 11:55:00 PM,033XX W DIVERSEY AVE,2027,NARCOTICS,POSS: CRACK,STREET,true,false,1412,014,35,22,18,1153440,1918377,2015,08/13/2015 12:57:42 PM,41.931870591,-87.711546895,"(41.931870591, -87.711546895)"')
```

### SUBMISSION 2: 

**Submit the the code for executing the above query as a Spark SQL python call. Also submit the number of rows in the result**

```
>>> results = sqlContext.sql('select count(*) from Web_Session_Log where REFERERURL= "http://www.ebay.com"')

>>> results.show()
+----+
| _c0|
+----+
|3943|
+----+

>>> 
```