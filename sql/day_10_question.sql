-- You're building a data warehouse where historical orders must show the address at the time of order. How do you implement SCD Type 2? 
-- What columns do you add, what is the upsert logic, and how do you query 'what was this customer's address on March 15 2023'?

make sure surrogate key is there in the table then make sure business key is also there

We need to add 3 columns 
1. effective date
2. expiry date
3. current flag

all other task are same as we done in day 10 task

we can check order address history with expiry date and order date
