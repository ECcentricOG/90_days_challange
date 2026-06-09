-- Write GROUP BY with HAVING, then ROLLUP (subtotals), CUBE (all combinations), 
-- and GROUPING SETS (custom combos). Verify the NULL grouping markers in each output.

-- 1. Group By with Having
select
    sum(amount)
    ,payment_method
    ,order_status
from orders
group by payment_method, order_status
having order_status = 'Cancelled';

-- 2.RollUp : hirarchical subtotals progressively removing columns from right to left it is like 3 col then 2 col then 1 col then null
select
    count(1)
    ,payment_method
    ,order_status
from orders
group by rollup(payment_method, order_status);

-- 3.Cube : All possible combinations betwenn columns like all combination for 3 col then for 2 col then for 1 col then for null
select
    count(1)
    ,payment_method
    ,order_status
from orders
group by cube(payment_method, order_status);

