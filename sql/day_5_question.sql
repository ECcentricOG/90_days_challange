-- You have a categories table with parent_category_id (up to 6 levels deep). 
-- Find all leaf-level categories under Electronics and their full path. 
-- Write this as a recursive CTE. What is the termination condition and how do you prevent infinite loops?

WITH RECURSIVE category_tree AS (
    -- Anchor: start at Electronics
    SELECT
        category_id,
        category_name,
        parent_category_id,
        category_name AS full_path,
        1 AS level
    FROM categories
    WHERE category_name = 'Electronics'

    UNION ALL

    -- Recursive step
    SELECT
        c.category_id,
        c.category_name,
        c.parent_category_id,
        ct.full_path || ' > ' || c.category_name,
        ct.level + 1
    FROM categories c
    JOIN category_tree ct
        ON c.parent_category_id = ct.category_id
    WHERE ct.level < 6
)

SELECT
    ct.category_id,
    ct.category_name,
    ct.full_path
FROM category_tree ct
WHERE NOT EXISTS (
    SELECT 1
    FROM categories child
    WHERE child.parent_category_id = ct.category_id
)
ORDER BY ct.full_path;
