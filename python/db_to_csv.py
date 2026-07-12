from psql_connection import extract_data
import csv

data = extract_data("select * from customers")
headers = [
    "customer_id",
    "customer_name",
    "email",
    "city",
    "signup_date"
]

with open("requirements/customers.csv", "w", newline="", encoding="utf-8") as file:
    writer = csv.writer(file)
    writer.writerow(headers)
    writer.writerows(data)
    print("Data is written in customers.csv file")
