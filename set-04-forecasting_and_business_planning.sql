-- How accurate is the demand forecast across all products?

USE inventory;

SELECT (1 - ABS(SUM(units_sold) - SUM(demand_forecast)) / SUM(demand_forecast))*100 AS `forecast_accuracy%`
FROM transactions;


-- Find product-wise forecast accuracy.

USE inventory;

SELECT product_id,
		(1 - ABS(SUM(units_sold) - SUM(demand_forecast)) / SUM(demand_forecast))*100 AS `forecast_accuracy%`
FROM transactions
GROUP BY product_id
ORDER BY `forecast_accuracy%` DESC;



-- Which products are being overstocked due to poor demand forecasting?

USE inventory;

SELECT store_id, product_id, inventory_level, units_sold
FROM transactions
WHERE units_sold <= inventory_level / 10;



-- Are we generally overestimating or underestimating demand?

USE inventory;

SELECT COUNT(1) AS total,
        SUM(CASE WHEN units_sold > demand_forecast THEN 1 ELSE 0 END) AS underestimates,
        SUM(CASE WHEN units_sold = demand_forecast THEN 1 ELSE 0 END) AS perfect_estimates,
        SUM(CASE WHEN units_sold < demand_forecast THEN 1 ELSE 0 END) AS overestimates
FROM transactions;


SELECT (SUM(CASE WHEN units_sold > demand_forecast THEN 1 ELSE 0 END) / COUNT(1)) * 100 AS `underestimate%`,
       (SUM(CASE WHEN units_sold = demand_forecast THEN 1 ELSE 0 END) / COUNT(1)) * 100 AS `perfect_estimate%`,
       (SUM(CASE WHEN units_sold < demand_forecast THEN 1 ELSE 0 END) / COUNT(1)) * 100 AS `overestimate%`
FROM transactions;



-- Which regions have the highest forecast error?

USE inventory;

SELECT region, ABS(SUM(units_sold) - SUM(demand_forecast)) / SUM(demand_forecast) AS forecast_error
FROM transactions
GROUP BY region
ORDER BY forecast_error DESC;