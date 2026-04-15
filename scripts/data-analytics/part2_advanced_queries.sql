--Change over time
SELECT
  YEAR(order_date) AS orders_year,
  SUM(sales_amount) as total_sales
FROM
  gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY YEAR(order_date) DESC
