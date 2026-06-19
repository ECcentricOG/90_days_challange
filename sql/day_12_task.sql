-- SQL challenge: write a query finding second highest salary per department, 
-- detect gaps in invoice number sequences, and pivot monthly sales data into columns.

select 
    *
from 
(
select
    employee_id
    ,employee_name
    ,department
    ,dense_rank() over(partition by department order by salary desc) sal_rank
from employees
)
where sal_rank = 2;

-- Pivot Monthly sales

select
    sum(case when extract(month from sale_date) = 1 then revenue end) jan_revenue
    ,sum(case when extract(month from sale_date) = 2 then revenue end) feb_revenue
    ,sum(case when extract(month from sale_date) = 3 then revenue end) mar_revenue
from sales;
