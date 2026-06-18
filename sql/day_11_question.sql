-- Your analyst asks: show monthly revenue, its % of annual total, 
-- comparison to same month last year, and flag any month with 10%+ drop. Write a single query computing all of this. 
-- What window functions do you combine and in what order?

with monthly_revenue as(
    select
        extract(month from order_date) mon
        ,extract(year from order_date) yr
        ,sum(amount) revenue
    from orders
    group by 1, 2
)

select 
    mon
    ,revenue
    ,round(revenue * 100 / sum(revenue) over(partition by yr), 2) pct_anual
    ,lag(revenue) over(partition by mon order by yr) revenue_last_year
    ,Case
    when(
        revenue - lag(revenue) over(partition by mon order by yr)
    ) * 100 /
    nullif(
        lag(revenue) over(partition by mon order by yr), 0
    ) <= -10 then 'DROP'
    else 'OK'
    end drop_flag
from monthly_revenue
order by mon;

