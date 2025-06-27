-- Based on past sales, how many units should we ideally reorder for each product ?

-- We rely on sales of last 3 months to get an estimate of how much we should reorder

USE inventory;

SELECT region, store_id, product_id, ROUND(AVG(units_sold)) AS avg_units_sold
FROM transactions
WHERE transaction_date >= (SELECT MAX(transaction_date) FROM transactions) - INTERVAL 90 DAY
GROUP BY region, store_id, product_id;