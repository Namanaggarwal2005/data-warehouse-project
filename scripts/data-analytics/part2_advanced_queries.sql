--Change over time
SELECT
  YEAR(order_date) AS orders_year,
  SUM(sales_amount) as total_sales,
  COUNT(DISTINCT customer_key) as customers
FROM
  gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY SUM(sales_amount)  DESC


SELECT
  MONTH(order_date) AS orders_month,
  SUM(sales_amount) as total_sales
FROM
  gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY MONTH(order_date)
ORDER BY SUM(sales_amount)  DESC

--Cummulative Analysis
SELECT
*,
SUM(total_sales) OVER(PARTITION BY order_year ORDER BY order_year, order_month) AS running_total
FROM
(
	SELECT
		YEAR(order_date) AS order_year,
		MONTH(order_date) AS order_month,
		SUM(sales_amount) as total_sales
	FROM
	gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY YEAR(order_date), MONTH(order_date)
)t
