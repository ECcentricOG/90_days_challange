-- Write a 3-month rolling average, a running total, and a 7-day moving sum using ROWS BETWEEN. 
-- Then write the same using RANGE BETWEEN and compare on duplicate dates.

-- 3 month rolling average
select 
    order_id
    ,order_date
    ,amount
    ,avg(amount) over(order by order_date 
    range between interval '2 month'preceding  
    and current row) as three_months_rolling_avg
from orders;

-- running total
select
    order_id
    ,order_date
    ,amount
    ,sum(amount) over(order by order_date
    range between unbounded preceding and current row)
from orders;

-- 7 day moving sum
select
    order_id
    ,order_date
    ,amount
    ,sum(amount) over(order by order_date
    range between interval '6 day' preceding and current row)
from orders;

