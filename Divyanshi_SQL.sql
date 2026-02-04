create database product_details
use product_details

select * from product_details
select * from product_heirarchy
select * from product_pricing
select * from product_sales

-- Total Revenue for each product category

SELECT 
pd.category_name, SUM(ps.qty * (ps.price - ps.discount)) as total_revenue
from product_sales ps
join product_details pd
on ps.prod_id = pd.product_id
group by pd.category_name
order by total_revenue desc

-- Product with Highest Discount Percentage

select top 1
pd.product_id,pd.product_name as product_name,
pp.price as original_price,
(pp.price - ps.discount) as discounted_price, 
((pp.price - (ps.price - ps.discount)) / cast(pp.price as decimal(10,2))) * 100
as discount_percentage
from product_sales ps
join product_pricing pp on ps.prod_id = pp.product_id
join product_details pd on ps.prod_id = pd.product_id
order by discount_percentage desc

--Category with Highest Average Price

select top 1
category_name, AVG(price) as avg_price
from product_details
group by category_name
order by avg_price desc

--Product with Lowest Price Fluctuation 

select TOP 1 pd.product_id, pd.product_name,
ABS(ps.price - ps.discount) AS price_fluctuation
FROM product_sales ps
join product_details pd
on ps.prod_id = pd.product_id
order by price_fluctuation asc

--Category with Highest Total Revenue Contribution

Select top 1 pd.category_name,
SUM(ps.qty * (ps.price - ps.discount)) AS total_revenue FROM product_sales PS
JOIN product_details pd
on ps.prod_id = pd.product_id
group by pd.category_name
order by total_revenue desc



