-- Countries from where our customers come from
SELECT DISTINCT 
country
FROM gold.dim_customers

--Different Products we SELL
SELECT DISTINCT
category,
subcategory,
product_name
FROM gold.dim_products
ORDER BY 1,2,3

--Date of first and last order
SELECT
	MIN(order_date) AS first_order,
	MAX(order_date) AS latest_order,
	DATEDIFF(year,MIN(order_date),MAX(order_date)) AS diff
from
gold.fact_sales

--Customer age group
SELECT
    DATEDIFF(year,MIN(birthdate),'2026-04-14') AS oldest_customer,
    DATEDIFF(year,MAX(birthdate),'2026-04-14') AS youngest_customer
FROM gold.dim_customers;
