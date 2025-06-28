-- How do sales and inventory levels change across different seasons?

USE inventory;

SELECT seasonality, AVG(units_sold) AS sales, AVG(inventory_level) AS inventory
FROM transactions
GROUP BY seasonality
ORDER BY sales DESC;


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



-- Do discounts increase more during certain seasons or weather?

USE inventory;

-- different weather

SELECT weather_condition, AVG(discount) AS avg_discount
FROM transactions
GROUP BY weather_condition;

-- different season

SELECT seasonality, AVG(discount) AS avg_discount
FROM transactions
GROUP BY seasonality;