-- Whitespaces in ord_num and prd_key
SELECT
*
FROM bronze.crm_sales_details
WHERE sls_ord_num <> TRIM(sls_ord_num)

SELECT
*
FROM bronze.crm_sales_details
WHERE sls_prd_key <> TRIM(sls_prd_key)
