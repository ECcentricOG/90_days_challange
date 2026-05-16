-- 8 types of joins
-- Inner Join
select 
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.amount
from customers c INNER JOIN orders o

-- Left Join
select 
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.amount
from customers c LEFT JOIN orders o
ON c.customer_id = o.customer_id;

-- Right Join
select 
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.amount
from customers c RIGHT JOIN orders o
ON c.customer_id = o.customer_id;

-- FULL JOIN
select 
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.amount
from customers c full join orders o
on c.customer_id = o.customer_id;

-- LEFT ANTI JOIN
select 
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.amount
from customers c left join orders o
on c.customer_id = o.customer_id
where o.order_id is null;

-- RIGHT ANTI JOIN
select 
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.amount
from customers c right join orders o
on c.customer_id = o.customer_id
where c.customer_id is null;

-- FULL ANTI JOIN
SELECT c.customer_id
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL

UNION

SELECT o.customer_id
FROM orders o
LEFT JOIN customers c
ON c.customer_id = o.customer_id
WHERE c.customer_id IS NULL;

