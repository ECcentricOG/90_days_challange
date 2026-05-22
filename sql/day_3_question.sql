-- You need: 
-- ① days since a customer's PREVIOUS purchase 
-- ② days until their NEXT purchase 
-- ③ compare current spend to their very first purchase. 
-- Which window functions do you use and why is ORDER BY mandatory here?

select 
    customer_id
    ,order_date
    ,amount
    ,LAG(order_date) OVER(partition by customer_id order by order_date) prev_order
    ,order_date - LAG(order_date) OVER(partition by customer_id order by order_date) days_since_prev
    ,LEAD(order_date) OVER(partition by customer_id order by order_date) next_order
    ,LEAD(order_date) OVER(partition by customer_id order by order_date) - order_date days_to_next
    ,FIRST_VALUE(amount) OVER(partition by customer_id order by order_date) first_prchs_amt
    ,amount - FIRST_VALUE(amount) OVER(partition by customer_id order by order_date) diff_fist_prchs
from orders
