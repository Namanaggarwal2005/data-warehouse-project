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

--Total customers by country
SELECT
country,
COUNT(country) [Total Customers]
FROM
gold.dim_customers
GROUP BY country


--Total customers by gender
SELECT
gender,
COUNT(gender) [Total Customers]
FROM
gold.dim_customers
GROUP BY gender

--Total products by category
SELECT
category,
COUNT(category) [Total Products]
FROM
gold.dim_products
GROUP BY category

--Average Cost in each category
SELECT
category,
AVG(cost) [Average Cost]
FROM
gold.dim_products
GROUP BY category

--Total revenue genrated for each country
SELECT
pr.category,
SUM(sl.sales_amount) [Sales]
FROM 
gold.dim_products pr
INNER JOIN
gold.fact_sales sl
ON pr.product_key = sl.product_key
GROUP BY pr.category

--TOP SPENDERS
SELECT
    c.customer_key,
    c.first_name,
    c.last_name,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
    ON c.customer_key = f.customer_key
GROUP BY
    c.customer_key,
    c.first_name,
    c.last_name
ORDER BY total_revenue DESC;

--Top 5 Highest Revenue generating products
SELECT TOP 5
RANK() OVER(ORDER BY SUM(sl.sales_amount) DESC) RANKINGS,
pd.product_name,
SUM(sl.sales_amount) Sales
FROM
gold.fact_sales sl
LEFT JOIN
gold.dim_products pd
ON sl.product_key = pd.product_key
GROUP BY pd.product_name
ORDER BY SUM(sl.sales_amount) DESC
