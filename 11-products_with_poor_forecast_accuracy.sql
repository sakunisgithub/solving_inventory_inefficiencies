-- Find product-wise forecast accuracy.

USE inventory;

SELECT product_id,
		(1 - ABS(SUM(units_sold) - SUM(demand_forecast)) / SUM(demand_forecast))*100 AS `forecast_accuracy%`
FROM transactions
GROUP BY product_id
ORDER BY `forecast_accuracy%` DESC;