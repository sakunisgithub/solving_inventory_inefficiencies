-- Which regions have the highest forecast error?

USE inventory;

SELECT region, ABS(SUM(units_sold) - SUM(demand_forecast)) / SUM(demand_forecast) AS forecast_error
FROM transactions
GROUP BY region
ORDER BY forecast_error DESC;