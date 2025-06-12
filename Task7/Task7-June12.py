
import pandas as pd
import matplotlib.pyplot as plt
import sqlite3

# Create & Connect SQLite database
conn = sqlite3.connect("Sales_Data_DB")
cursor = conn.cursor()

# Drop table as Sales table already exists
cursor.execute("DROP TABLE IF EXISTS Sales")

# Create Sales table
cursor.execute("""
CREATE TABLE Sales (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    product TEXT,
    quantity INTEGER,
    price REAL
)
""")

# Sample data to insert
sample_data = [
    ("Keyboard", 10, 29.99),
    ("Mouse", 15, 19.99),
    ("Monitor", 5, 199.99),
    ("Laptop", 3, 899.99),
    ("Webcam", 7, 49.99)
]

# Insert data
cursor.executemany("INSERT INTO Sales (product, quantity, price) VALUES (?, ?, ?)", sample_data)

cursor.execute("SELECT * FROM Sales")  #Select Data from Table
rows = cursor.fetchall()
print(rows)

# Average Price of Products
query = """
SELECT product, AVG(price) AS average_price
FROM Sales
GROUP BY product
"""
df = pd.read_sql_query(query, conn)
print(df)

# Total Quantity Sold by Each Product
query = """
SELECT product, SUM(quantity) AS Total_Quantity
FROM Sales
GROUP BY product
"""
df = pd.read_sql_query(query, conn)
print(df)

#Total Revenue by Each Product
query = """
SELECT product, SUM(quantity*price) AS Total_Revenue
FROM Sales
GROUP BY product
"""
df = pd.read_sql_query(query, conn)
print(df)

#Top Selling Product by Quantity
query = """
SELECT product, SUM(quantity) AS total_quantity
FROM Sales
GROUP BY product
ORDER BY total_quantity DESC
LIMIT 1
"""
df = pd.read_sql_query(query, conn)
print("Top selling product by quantity:")
print(df)

# Bar Chart to show revenue by product
query = """
SELECT product, SUM(quantity * price) AS total_revenue
FROM Sales
GROUP BY product
"""

df = pd.read_sql_query(query, conn)    # Load into DataFrame
print(df.columns)                      # check columns in dataframe

df.plot(kind='bar', x='product', y='total_revenue', legend=False)
plt.title("Revenue by Product")
plt.xlabel("Product")
plt.ylabel("Revenue ($)")
plt.tight_layout()
plt.show()

# Commit and close
#conn.commit()
#conn.close()

