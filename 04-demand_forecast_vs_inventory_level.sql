-- What is the average demand forecast vs average inventory level for each product across different regions ?

USE inventory;

SELECT region, product_id, AVG(demand_forecast), AVG(inventory_level)
FROM transactions
GROUP BY region, product_id;