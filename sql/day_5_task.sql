-- Write a CTE to find top 10 customers by revenue. 
-- Then write a recursive CTE to traverse an employee org chart 4 levels deep. Explain when CTEs are materialised vs inline.

-- Top 10 Customers by revenue
with top_customers as(
    select
        customer_id
        ,sum(amount) total_revenue
    from orders 
    group by customer_id
)

select 
    customer_id
    ,total_revenue
from top_customers
order by total_revenue desc
limit 10;


-- Recursive CTE
with recursive org_chart as (
    select
        employee_id
        ,employee_name
        ,job_title
        ,department
        ,manager_id
        ,1 as lvl
    from employees

    union all

    select 
        e.employee_id
        ,e.employee_name
        ,e.job_title
        ,e.department
        ,e.manager_id
        ,o.lvl + 1
    from employees e 
    join org_chart o
    on e.manager_id = o.employee_id
    where o.lvl < 4
)

select * from org_chart;
