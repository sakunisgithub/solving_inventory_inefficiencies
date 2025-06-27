-- Which product categories show strong seasonal demand patterns?

USE inventory;

WITH category_added_transactions AS
(
	SELECT transactions.*, products.category
	FROM transactions
    INNER JOIN products
		ON transactions.product_id = products.product_id
)
SELECT category, seasonality, AVG(units_sold) AS demand
FROM category_added_transactions
GROUP BY category, seasonality
ORDER BY category, demand DESC;