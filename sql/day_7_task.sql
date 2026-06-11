-- Deduplicate a customers table using all 4 methods: 
-- DISTINCT, GROUP BY, ROW_NUMBER CTE, and QUALIFY. 
-- Compare which preserves the most recent vs oldest record.

-- distinct
select distinct * from customers;

-- group by
select 
    customer_id
    ,customer_name
from customers
group by customer_id;

-- row_number
select 
    *
from
(
    select 
    customer_id
    ,customer_name
    ,row_number() over(partition by customer_id order by customer_id) as no
    from customers
)
where no = 1;

-- Qualify BQ
SELECT *
FROM customers
QUALIFY ROW_NUMBER() OVER (
           PARTITION BY email
           ORDER BY created_at DESC
       ) = 1;
