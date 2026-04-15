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
SUM(total_sales) OVER(PARTITION BY order_year ORDER BY order_year, order_month) AS running_total,
AVG(total_sales) OVER(PARTITION BY order_year ORDER BY order_year, order_month) AS moving_average
FROM
(
	SELECT
		YEAR(order_date) AS order_year,
		MONTH(order_date) AS order_month,
		SUM(sales_amount) as total_sales,
		AVG(price) AS average_price
	FROM
	gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY YEAR(order_date), MONTH(order_date)
)t

--Performance Analysis
WITH yearly_product_sales AS (
    SELECT
        YEAR(f.order_date) AS order_year,
        p.product_name,
        SUM(f.sales_amount) AS current_sales
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
        ON f.product_key = p.product_key
    WHERE f.order_date IS NOT NULL
    GROUP BY 
        YEAR(f.order_date),
        p.product_name
)
SELECT
    order_year,
    product_name,
    current_sales,
    AVG(current_sales) OVER (PARTITION BY product_name) AS avg_sales,
    current_sales - AVG(current_sales) OVER (PARTITION BY product_name) AS diff_avg,
    CASE 
        WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) > 0 THEN 'Above Avg'
        WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) < 0 THEN 'Below Avg'
        ELSE 'Avg'
    END AS avg_change,
    -- Year-over-Year Analysis
    LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS py_sales,
    current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS diff_py,
    CASE 
        WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) > 0 THEN 'Increase'
        WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) < 0 THEN 'Decrease'
        ELSE 'No Change'
    END AS py_change
FROM yearly_product_sales
ORDER BY product_name, order_year;
