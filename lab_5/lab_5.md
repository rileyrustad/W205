# Lab 5

### Question 1: What is the output of \dt?

```
dvdrental-# \dt
              List of relations
 Schema |       Name       | Type  |  Owner   
--------+------------------+-------+----------
 public | actor            | table | postgres
 public | address          | table | postgres
 public | category         | table | postgres
 public | city             | table | postgres
 public | country          | table | postgres
 public | customer         | table | postgres
 public | film             | table | postgres
 public | film_actor       | table | postgres
 public | film_category    | table | postgres
 public | inventory        | table | postgres
 public | language         | table | postgres
 public | payment          | table | postgres
 public | payment_p2007_01 | table | postgres
 public | payment_p2007_02 | table | postgres
 public | payment_p2007_03 | table | postgres
 public | payment_p2007_04 | table | postgres
 public | payment_p2007_05 | table | postgres
 public | payment_p2007_06 | table | postgres
 public | rental           | table | postgres
 public | staff            | table | postgres
 public | store            | table | postgres
(21 rows)
```

### Question 2: What is the schema for the customer table?

```
                                          Table "public.customer"
   Column    |            Type             |                           Modifiers                            
-------------+-----------------------------+----------------------------------------------------------------
 customer_id | integer                     | not null default nextval('customer_customer_id_seq'::regclass)
 store_id    | smallint                    | not null
 first_name  | character varying(45)       | not null
 last_name   | character varying(45)       | not null
 email       | character varying(50)       | 
 address_id  | smallint                    | not null
 activebool  | boolean                     | not null default true
 create_date | date                        | not null default ('now'::text)::date
 last_update | timestamp without time zone | default now()
 active      | integer                     | 
Indexes:
    "customer_pkey" PRIMARY KEY, btree (customer_id)
    "idx_fk_address_id" btree (address_id)
    "idx_fk_store_id" btree (store_id)
    "idx_last_name" btree (last_name)
Foreign-key constraints:
    "customer_address_id_fkey" FOREIGN KEY (address_id) REFERENCES address(address_id) ON UPDATE CASCADE ON DELETE RESTRICT
    "customer_store_id_fkey" FOREIGN KEY (store_id) REFERENCES store(store_id) ON UPDATE CASCADE ON DELETE RESTRICT
Referenced by:
    TABLE "payment" CONSTRAINT "payment_customer_id_fkey" FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON UPDATE CASCADE ON DELETE RESTRICT
    TABLE "payment_p2007_01" CONSTRAINT "payment_p2007_01_customer_id_fkey" FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
    TABLE "payment_p2007_02" CONSTRAINT "payment_p2007_02_customer_id_fkey" FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
    TABLE "payment_p2007_03" CONSTRAINT "payment_p2007_03_customer_id_fkey" FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
    TABLE "payment_p2007_04" CONSTRAINT "payment_p2007_04_customer_id_fkey" FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
    TABLE "payment_p2007_05" CONSTRAINT "payment_p2007_05_customer_id_fkey" FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
    TABLE "payment_p2007_06" CONSTRAINT "payment_p2007_06_customer_id_fkey" FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
    TABLE "rental" CONSTRAINT "rental_customer_id_fkey" FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON UPDATE CASCADE ON DELETE RESTRICT
Triggers:
    last_updated BEFORE UPDATE ON customer FOR EACH ROW EXECUTE PROCEDURE last_updated()
```

### Question 3: What similarities do you see in the explain plains for these 3 queries?

I noticed that they all involve scanning through the data, and the last two involve filtering. I also noticed that when I specify the "payment" table, that it also parses through the payment_p2007_0x tables too. I'm thinking that maybe the smaller payment tables are partitions of a larger payment table?

### Question 4: What is the difference between the plans for the Partitioned table and the union query? Why do you think this difference exists?

In the Union plan, the there are two hash aggregates versus only the one in the partitioned plan. I'd assume that the union plan includes combining the tables together as the first aggregation, and the partition can skip that step since it's already been done. I did notice that the partition plan only filters through the two tables that could contain the value we're searching for, and not all of the partitioned tables. 

### Question 5: What join algorithm is used for the inner join?

The inner join used the "hash join" algorithm.
