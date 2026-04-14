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
    DATEDIFF(year,MIN(birthdate),GETDATE()) AS oldest_customer,
    DATEDIFF(year,MAX(birthdate),GETDATE()) AS youngest_customer
FROM gold.dim_customers;

--Total sales
SELECT
CAST(sum(sales_amount)/1000000 AS VARCHAR)+' Million' AS [sales]
FROM
gold.fact_sales

--Total sold quantity
SELECT
	sum(quantity) AS [sold_quantity]
FROM
gold.fact_sales

--Average Selling Price
SELECT
	AVG(price) AS [sold_quantity]
FROM
gold.fact_sales

--Total Number of orders, products and customers
SELECT
	COUNT(customer_key)
FROM
gold.dim_customers

SELECT
	COUNT(product_key)
FROM
gold.dim_products

SELECT COUNT(order_number)
FROM
(
SELECT DISTINCT
	order_number
FROM
gold.fact_sales
)t
