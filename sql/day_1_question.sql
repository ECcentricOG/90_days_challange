-- You have customers (10M rows) and orders (500M rows). Write 3 queries: 
-- ① customers who NEVER ordered 
-- ② customers whose LAST order was 90+ days ago 
-- ③ ordered in Jan but NOT Feb. Which join type for each and why? What are the performance implications?

-- 1 customers who never ordered  
select
    c.customer_id,
    c.customer_name,
    o.order_id
from customers c LEFT JOIN orders o
ON c.customer_id = o.customer_id
where o.order_id IS NULL;

-- 2 customers whoese last order was 90+ days aho
select
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.order_date
from customers c LEFT JOIN orders o
ON c.customer_id = o.customer_id
-- where order_date >= CURRENT_DATE - Interval '90 days';  PSQL
-- where order_date >= SYSDATE - 90;  ORACLE SQL

-- 3 ordered in Jan but NOT Feb.

select 
    c.customer_id,
    c.customer_name,
    jan.order_id
from customers c
inner join orders jan
on c.customer_id = jan.customer_id
and jan.order_date >= '2026-01-01'
and jan.order_date < '2026-02-01'
left join orders feb
on c.customer_id = feb.customer_id
and feb.order_date >= '2026-02-01'
and feb.order_date < '2026-03-01'
where feb.order_id is null;
