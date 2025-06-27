-- How do sales and inventory levels change across different seasons?

USE inventory;

SELECT seasonality, AVG(units_sold) AS sales, AVG(inventory_level) AS inventory
FROM transactions
GROUP BY seasonality
ORDER BY sales DESC;