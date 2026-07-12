import pandas as pd

orders_df = pd.read_csv("requirements/orders.csv", chunksize=10)
customers_df = pd.read_csv("requirements/customers.csv", chunksize=10)
