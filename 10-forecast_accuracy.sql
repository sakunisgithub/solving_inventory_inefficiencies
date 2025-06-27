-- How accurate is the demand forecast across all products?

USE inventory;

SELECT (1 - ABS(SUM(units_sold) - SUM(demand_forecast)) / SUM(demand_forecast))*100 AS `forecast_accuracy%`
FROM transactions;