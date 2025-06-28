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



-- What is the average inventory holding period for different categories and regions?

-- avergae inventory holding period = (average inventory level / average units sold) * 30

USE inventory;

-- by category

WITH category_added AS
(
	SELECT transactions.*, products.category
	FROM transactions
    INNER JOIN products
		ON transactions.product_id = products.product_id
)
SELECT category, AVG(inventory_level) / AVG(units_sold) * 30 AS avg_inventory_holding_period
FROM category_added
GROUP BY category;


-- by region

SELECT region, AVG(inventory_level) / AVG(units_sold) * 30 AS avg_inventory_holding_period
FROM transactions
GROUP BY region;



-- What is the average demand forecast vs average inventory level for each product across different regions ?

USE inventory;

SELECT region, product_id, AVG(demand_forecast), AVG(inventory_level)
FROM transactions
GROUP BY region, product_id;




-- What is the average demand forecast vs average inventory level for each product across different regions ?

USE inventory;

SELECT region, product_id, AVG(demand_forecast), AVG(inventory_level)
FROM transactions
GROUP BY region, product_id;



-- Based on past sales, how many units should we ideally reorder for each product ?

-- We rely on sales of last 3 months to get an estimate of how much we should reorder

USE inventory;

SELECT region, store_id, product_id, ROUND(AVG(units_sold)) AS avg_units_sold
FROM transactions
WHERE transaction_date >= (SELECT MAX(transaction_date) FROM transactions) - INTERVAL 90 DAY
GROUP BY region, store_id, product_id;



-- Which categories have the fastest stock movement (stock turnover)?

USE inventory;

WITH category_added AS
(
	SELECT transactions.*, products.category
	FROM transactions
    INNER JOIN products
		ON transactions.product_id = products.product_id
)
SELECT category, AVG(units_sold) / AVG(inventory_level) AS stockout_rate
FROM category_added
GROUP BY category;