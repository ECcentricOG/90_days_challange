-- Your BI team needs one query returning: 
-- total per region, total per category, total per region+category, and a grand total
-- all in one result set. How? How do you tell the difference between a ROLLUP NULL vs an actual NULL value in the data?

-- total per region
select
    region
    ,sum(price * quantity_sold) total_per_region
from products
group by region;

-- total per category
select
    category
    ,sum(price * quantity_sold) total_per_category
from products
group by category;

-- total region + category
select
    region
    ,sum(price * quantity_sold) total_per_region
    ,category
    ,sum(price * quantity_sold) total_per_category
from products
group by region,category;
