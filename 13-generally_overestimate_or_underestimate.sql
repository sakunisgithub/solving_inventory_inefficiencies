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