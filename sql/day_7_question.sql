-- After a batch load, your customers table has duplicates — 
-- same customer_id but different updated_at. 
-- You need only the most recent record per customer. 
-- What if you also need to track which columns changed?

select 
    *
from
(
select 
    employee_name
    ,job_title
    ,hire_date
    ,ROW_NUMBER() OVER(partition by  manager_id order by hire_date desc) no
from employees
)
where no <= 1;

