select * from customers;
select * from orders;
select * from products;

select * from orders where total_amount>=500
order by order_date desc;

--TOTAL REVENUE AND ORDER COUNT BY ORDER DATE
SELECT YEAR(order_date) AS order_year,	COUNT(DISTINCT order_id)AS order_count,
	   SUM(total_amount) AS total_revenue FROM orders
GROUP BY YEAR(order_date)
ORDER BY order_year DESC;

--INNER JOIN FOR List OF order ID, order date, customer name, and product name.
SELECT o.order_id, o.order_date, c.customer_name, p.product_name
FROM Orders o
INNER JOIN customers c on o.customer_id = c.customer_id
INNER JOIN products p on o.product_id = p.product_id;

-- LEFT JOIN FOR Showing all customers, even those who haven't placed orders.
SELECT c.customer_id, c.customer_name, o.order_id FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
ORDER BY c.customer_name;

--RIGHT JOIN TO Find orders with missing customer info
SELECT o.order_id, o.order_date FROM customers c
RIGHT JOIN orders o ON c.customer_id = o.customer_id
WHERE c.customer_id IS NULL;

--SUBQUERY Products Above Average Price
SELECT product_id, product_name, price FROM products
WHERE price > (SELECT AVG(price) FROM products);

 --Create a View for Monthly Sales Summary
CREATE VIEW monthly_sales_summary AS
SELECT 
    YEAR(order_date) AS sales_year,
    MONTH(order_date) AS sales_month,
    SUM(total_amount) AS total_sales,
    SUM(quantity) AS total_quantity FROM orders
GROUP BY YEAR(order_date), MONTH(order_date);

SELECT * FROM monthly_sales_summary ORDER BY sales_year, sales_month;

-- Create a index on customer_id,order_date,product_id
CREATE INDEX idx_customer_id ON orders(customer_id);
CREATE INDEX idx_order_date ON orders(order_date);
CREATE INDEX idx_product_id ON orders(product_id);
