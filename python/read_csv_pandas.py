import pandas as pd

chunks = pd.read_csv("requirements/orders.csv", chunksize=5)

# Transformations where credit card is used the amount is deducted by 0.3% as fees
for chunk in chunks:
    chunk = chunk[chunk["payment_method"] == "Credit Card"]
    chunk["amount"] = chunk["amount"] * 0.97
    print(chunk)
