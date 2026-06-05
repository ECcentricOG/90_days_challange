-- Finance wants a cumulative revenue report that resets every year (partitioned by year), 
-- shows a 3-month rolling avg alongside running total, and flags any month where revenue dropped 20%+ vs the previous month. 
-- Write the full query.

select
    order_id
    ,order_date
    ,extract(month from order_date) as month
    ,amount
    ,sum(amount) over(partition by extract(year from order_date)
    order by order_date) as running_avg
    ,avg(amount) over(partition by extract(year from order_date)
    order by order_date range between '2 month' preceding and current row
    ) as three_month_rolling_avg
from orders;

