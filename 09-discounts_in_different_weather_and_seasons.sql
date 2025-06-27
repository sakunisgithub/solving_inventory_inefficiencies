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