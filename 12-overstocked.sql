-- Which products are being overstocked due to poor demand forecasting?

USE inventory;

SELECT store_id, product_id, inventory_level, units_sold
FROM transactions
WHERE units_sold <= inventory_level / 10;