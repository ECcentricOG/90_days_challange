-- A query joining orders (500M rows) to products (1M rows) 
-- filtering by DATE(created_at)='2024-01-01' runs for 45 minutes. 
-- Walk through your optimisation steps. What 3 things do you check first? 
-- How does wrapping a column in a function break index usage?

Execution Plan (EXPLAIN ANALYZE)
    I want to see whether the query is performing a full table scan or using indexes.
    I would check the join strategy (Nested Loop, Hash Join, Merge Join) and identify where most of the time is being spent.

Indexes
    Verify that indexes exist on:
    orders(created_at) for filtering
    orders(product_id) and products(product_id) for the join
    Missing indexes on these columns can significantly increase execution time.

Predicate Sargability
    The filter DATE(created_at) = '2024-01-01' immediately stands out because a function is applied to the indexed column.
    This often prevents the optimizer from using the index efficiently.
