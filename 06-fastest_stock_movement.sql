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