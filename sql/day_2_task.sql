-- Write ROW_NUMBER, RANK, DENSE_RANK, NTILE(4) in one query on a sales table. Explain the output difference when two rows tie in value.

select 
    customer_id,
    amount,
    ROW_NUMBER() OVER() as row_num_amount,
    RANK() OVER(order by amount desc) as rank_amount,
    DENSE_RANK() OVER(order by amount desc) dense_rank_amount,
    NTILE(4) OVER(order by amount desc)
from orders;

