-- sales and stock performance

USE inventory;

-- Which product categories have the highest total sales?

select p.category as category , sum(t.units_sold) as total_sales
from transactions t
join products p
on p.product_id = t.product_id
group by p.category
ORDER BY total_sales DESC;

-- Which products sold well despite offering little or no discount?

select p.product_id , p.category , sum(t.units_sold) as total_units_sold, avg(t.discount) as avg_discount
from transactions t
join products p
on t.product_id = p.product_id
where t.discount < 10
group by p.product_id , p.category
having sum(t.units_sold) > (select avg(t.units_sold) from transactions t);

-- What is the average discount given per category, and how does it relate to sales volume?

select p.category , avg(t.discount) as avg_discount, sum(t.units_sold) as total_units_sold
from transactions t
join products p
on p.product_id = t.product_id
group by p.category;


-- Which products are fast-moving SKUs (high sales, low inventory)?

select  p.product_id , sum(t.units_sold) , sum(t.inventory_level)  
from transactions t
join products p
on p.product_id = t.product_id
where t.units_sold > (select avg(t.units_sold) from transactions t)
           and
          t.inventory_level < (select avg(t.inventory_level) from transactions t)
group by p.product_id;


-- Which products are slow-moving SKUs (low sales, high inventory)?

select  p.product_id , sum(t.units_sold) , sum(t.inventory_level)
from transactions t
join products p
on p.product_id = t.product_id
where t.units_sold < (select avg(t.units_sold) from transactions t)
           and
          t.inventory_level > (select avg(t.inventory_level) from transactions t)
group by p.product_id;


SELECT price_comparison, AVG(units_sold)
FROM (SELECT (CASE WHEN price <= competitor_price THEN 'less_or_equal' ELSE 'greater' END) AS price_comparison, units_sold
		FROM transactions) as comparison
GROUP BY price_comparison;