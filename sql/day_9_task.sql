-- Create RANGE-partitioned table by date, LIST-partitioned by region, and HASH-partitioned by user_id. 
-- Write queries that trigger partition pruning for each. Verify with EXPLAIN.

-- Create a main table
Create Table ord_tab(
    ord_id Int,
    product_name Varchar(50),
    ord_date Date
) partition by range (ord_date);

CREATE TABLE sales (
    sale_id INT,
    region VARCHAR(20),
    amount NUMERIC(10,2),
    PRIMARY KEY(sale_id, region)
) PARTITION BY LIST(region);


-- Create Partitons 
Create table ord_tab_q1 
partition of ord_tab
for values from ('2026-01-01') to ('2026-03-31');

Create table ord_tab_q2
partition of ord_tab
for values from ('2026-04-01') to ('2026-06-31');

Create table ord_tab_q3
partition of ord_tab
for values from ('2026-07-01') to ('2026-09-31');

Create table ord_tab_q4
partition of ord_tab
for values from ('2026-010-01') to ('2026-12-31');


CREATE TABLE sales_north
PARTITION OF sales
FOR VALUES IN ('North');

CREATE TABLE sales_south
PARTITION OF sales
FOR VALUES IN ('South');

CREATE TABLE sales_east
PARTITION OF sales
FOR VALUES IN ('East');

CREATE TABLE sales_west
PARTITION OF sales
FOR VALUES IN ('West');
