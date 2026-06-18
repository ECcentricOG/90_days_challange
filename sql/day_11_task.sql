-- Write 5 analytical patterns: running total, YoY comparison, top-3 per group, 7-day moving avg, 
-- and gaps-and-islands for consecutive active days. Window functions only.

-- Running total

select
    order_id
    ,customer_id
    ,order_date
    ,amount
    ,sum(amount) over(order by order_date 
    range between unbounded preceding and current row) running_total
from orders
order by order_date;

-- YoY Comparison
with year_on_year as(
    select
        extract(year from order_date) order_year
        ,sum(amount)
    from orders
    group by extract(year from order_date)
)

select
    order_year
    ,lag(sum) over(order by order_year) last_year
    ,round(
        (sum - lag(sum) over(order by order_year)) * 100
        /
        nullif(lag(sum) over(order by order_year), 0),
        2
    )
from year_on_year;

-- top 3 
with agg_orders as(
    select
        order_id
        ,payment_method
        ,sum(amount) revenue
    from orders
    group by order_id, payment_method
    order by sum(amount)
)

select *
from 
(
    select
        order_id
        ,payment_method
        ,dense_rank() over(partition by payment_method order by revenue desc) top_rank
    from agg_orders
)
where top_rank <= 3;

-- 7 day moving avg
select
    order_id
    ,order_date
    ,amount
    ,round(avg(amount) over(order by order_date
    rows between 6 preceding and current row), 2) week_avg
from orders
order by order_date;

