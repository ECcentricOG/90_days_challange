-- Use LAG, LEAD, FIRST_VALUE, LAST_VALUE on a monthly_sales table. 
-- Calculate MoM change, next-month value, and compare each month to first/last month of the year.

with monthly_sales as(
    select 
        extract(month from sale_date) as month,
        sum(revenue) as revenue
    from sales
    group by extract(month from sale_date)
)

select 
    *,
    LAG(revenue) OVER(order by month) as prev_month_sales,
    revenue - LAG(revenue) OVER(order by month) as mom_change,
    LEAD(revenue) OVER(order by month) as next_month_sales,
    FIRST_VALUE(revenue) OVER(order by month) as first_month,
    LAST_VALUE(revenue) OVER(order by month 
        rows between unbounded preceding and unbounded following
    ) as last_month
from monthly_sales;

