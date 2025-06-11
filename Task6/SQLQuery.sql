Select * from order_products;

--Monthly revenue and order volume.
SELECT
    MONTH(OrderDate) AS OrderMonth,
    SUM(sales) AS TotalRevenue,
    COUNT(DISTINCT order_id) AS OrderVolume
FROM order_products
WHERE OrderDate IS NOT NULL
GROUP BY MONTH(OrderDate)
ORDER BY OrderMonth;

--Query for specific time periods.
SELECT
    MONTH(OrderDate) AS OrderMonth,
    SUM(sales) AS TotalRevenue,
    COUNT(DISTINCT order_id) AS OrderVolume
FROM order_products
WHERE OrderDate BETWEEN '2021-01-01' AND '2022-12-31'
GROUP BY
    MONTH(OrderDate)
ORDER BY
    OrderMonth;

