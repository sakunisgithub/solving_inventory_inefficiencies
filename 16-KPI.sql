-- kpi metrics

-- stockout frequency

USE inventory;

select (count(case when inventory_level < units_sold then 1 end )*100)/count(*) as stockout_frequency
from transactions;

-- overstock exposure

select count(case when t.inventory_level > 1.5 * t.demand_forecast then 1 end)/(count(*))*100 as overstock_exposure
from transactions t;


-- regional inventory imbalance index

select round(stddev(avg_inventory), 2)
from (
	select region, avg(inventory_level) as avg_inventory
	from transactions
	group by region) as avg_inventory_table;



-- inventory to sales ratio

select sum(inventory_level)/sum(units_sold) as inventory_to_sales_ratio
from transactions;

-- forecast bias score

select avg(demand_forecast - units_sold) as forcast_bias_score
from transactions;

-- revenue lost due to stockouts

select avg(revenue_lost) as avg_revenue_loss, sum(revenue_lost) as total_revenue_loss
from (select (t.demand_forecast - t.units_sold) * price as revenue_lost
	from transactions t
	where t.inventory_level < t.units_sold 
	having revenue_lost < 0) as new_table;
    


-- sku coverage ratio

select count(case when t.inventory_level != 0 then 1 end )/count(*) as sku_coverage_ratio
from transactions t ;


-- holiday/promo sales contribution

SELECT 
    SUM(CASE
        WHEN holiday_or_promotion = 1 THEN units_sold
    END) * 100 / SUM(units_sold) AS promo_contribution
FROM transactions;