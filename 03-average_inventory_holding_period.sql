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