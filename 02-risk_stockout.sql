-- What products are currently at low inventory levels and risk stockout?

USE inventory;

WITH last_transaction_dates AS
(
	SELECT region, store_id, product_id, MAX(transaction_date) AS last_transaction
	FROM transactions
	GROUP BY region, store_id, product_id
),
risk_stockout AS
(
	SELECT a.*, b.inventory_level, b.demand_forecast
	FROM (SELECT *
			FROM transactions 
			WHERE inventory_level < demand_forecast) AS b
	INNER JOIN last_transaction_dates AS a
		ON a.region = b.region
		AND a.store_id = b.store_id
		AND a.product_id = b.product_id
		AND a.last_transaction = b.transaction_date
)
SELECT region, product_id, COUNT(1) AS no_of_stockouts
FROM risk_stockout
GROUP BY region, product_id
ORDER BY region;