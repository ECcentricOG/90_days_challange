from psql_connection import extract_data
import csv

data = extract_data("select * from orders")
headers = [
    "order_id",
    "customer_id",
    "order_date",
    "amount",
    "payment_method",
    "status"
]

with open("requirements/orders.csv", "w", newline="", encoding="utf-8") as file:
    writer = csv.writer(file)
    writer.writerow(headers)
    writer.writerows(data)
    print("Data is written in orders.csv file")
