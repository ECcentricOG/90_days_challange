import pandas as pd

orders_df = pd.read_csv("requirements/orders.csv")
customers_df = pd.read_csv("requirements/customers.csv")

result = orders_df.groupby("payment_method")["amount"].mean()

piv_tab = orders_df.pivot_table(
    values="amount",
    index="order_date",
    columns="order_id",
    aggfunc="sum"
)

inner = orders_df.merge(customers_df, on="customer_id", how="inner")
left = orders_df.merge(customers_df, on="customer_id", how="left")
outer = orders_df.merge(customers_df, on="customer_id", how="outer")
cross = orders_df.merge(customers_df, how="cross")

def remove_tax(amount):
    return amount * 0.94

orders_df["after_tax"] = orders_df["amount"].apply(remove_tax)

#Finding Null Values
print(orders_df.isnull().sum()) # check for null value in all columns in df
orders_df["amount"] = orders_df["amount"].fillna(orders_df["amount"].mean()) #Filling null values with average
orders_df.drop_duplicates()
orders_df.dropna()

orders_df.to_parquet("requirements/processed_pd_orders.parquet")

# Fast compare to iterrow()
orders_df["order_id"] = orders_df["order_id"] + 100
#slow compare to vectorized version
for i, row in orders_df.iterrows():
    row["customer_id"] = row["customer_id"] + 100
customers_df["customer_id"] = customers_df["customer_id"] + 100

#Chained functions
result = (
    orders_df
    .drop_duplicates()
    .dropna(subset=["amount"])
    .query("amount > 2300")
    .assign(
        bonus=lambda x: x.amount * 0.10,
        total= lambda x: x.amount + x.bonus
    )
    .sort_values("total",ascending=False)
    .reset_index(drop=True)
)

print(result)
