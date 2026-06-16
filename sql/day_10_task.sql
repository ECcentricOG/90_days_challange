-- Build a full SCD Type 2 table for dim_customer. 
-- Implement close+insert logic for an address change. Write a point-in-time query. Add a surrogate key sequence.

-- Create a table in which we'll perform the operations 2 type means new row insert

Create Sequence sk_incr
Start 1
Increment 1;

Create table dia_customers(
    sk_customer_id bigint primary key default nextval('sk_incr'),
    customer_id int not null,
    customer_name varchar(20),
    address varchar(50),
    current_flag char(1),
    created_at timestamp default current_timestamp
);

-- Inital load data 

Insert into dia_customers(
    customer_id,
    customer_name,
    address,
    current_flag
) values(
    1001,
    "Umesh Unde",
    "Pune, Hinjewadi",
    "Y"
);

-- Now Adress is updated and using type 2 of SDC by Upsert 

update dia_customers
set current_flag = 'N'
where customer_id = 1001 and current_flag = 'Y';

-- Insert a new record for that same customer with updated info

Insert into dia_customers(
    customer_id,
    customer_name,
    address,
    current_flag
) values(
    1001,
    "Umesh Unde",
    "Pune, Magarpatta",
    "Y"
);
