 -- Your manager wants a leaderboard of top 5 sales reps per region. Some reps have the same revenue. 
 -- Show rank (with gap for ties), dense rank (no gaps), and percentile bucket — without nested subqueries. 

with rep_revenue as (
    select
        rep_name,
        region,
        sum(revenue) total
    from sales
    group by rep_name, region
)

select * 
from
(
select 
    *,
    RANK() OVER(PARTITION BY region ORDER BY total desc) rank_with_gap,
    DENSE_RANK() OVER(PARTITION BY region ORDER BY total desc) rank_no_gap,
    NTILE(4) OVER(PARTITION BY region ORDER BY total desc) percentile_bucket
from rep_revenue
)
where rank_with_gap <= 5
order by region, rank_with_gap;
