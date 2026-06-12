-- Run EXPLAIN ANALYZE on a slow join query. 
-- Add an index, rewrite with filter pushdown, avoid function on indexed column. 
-- Compare execution plans before and after each change.

explain analyze
select 
    c.customer_id
    ,c.customer_name
    ,c.city
    ,c.signup_date
    ,o.order_id
    ,o.amount
    ,o.order_date
from customers c
join orders o
on c.customer_id = o.customer_id
where extract(year from o.order_date) = 2025
and c.city = 'Mumbai';

-- sequence scan is done cause no index on order_date

--  Planning:
--   Buffers: shared hit=249
-- Planning Time: 1.848 ms
-- Execution Time: 0.237 ms
-- (18 rows)

-- After Index applied on order_date

CREATE INDEX idx_orders_date
ON orders(order_date);

-- Execution of same query and using range in order to make index work

explain analyze
select 
    c.customer_id
    ,c.customer_name
    ,c.city
    ,c.signup_date
    ,o.order_id
    ,o.amount
    ,o.order_date
from customers c
join orders o
on c.customer_id = o.customer_id
where o.order_date between '2025-01-01' and '2026-01-01'
and c.city = 'Mumbai';


-- Planning:
--   Buffers: shared hit=275
-- Planning Time: 1.117 ms
-- Execution Time: 0.107 ms
-- (18 rows)

