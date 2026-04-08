-- Whitespaces in ord_num and prd_key
SELECT
*
FROM bronze.crm_sales_details
WHERE sls_ord_num <> TRIM(sls_ord_num)

SELECT
*
FROM bronze.crm_sales_details
WHERE sls_prd_key <> TRIM(sls_prd_key)

--Checking the sls_prd_key relation 
SELECT TOP (1000) [sls_ord_num]
      ,REPLACE(TRIM(sls_prd_key),'-','_') sls_prd_key
      ,[sls_cust_id]
      ,[sls_order_dt]
      ,[sls_ship_dt]
      ,[sls_due_dt]
      ,[sls_sales]
      ,[sls_quantity]
      ,[sls_price]
  FROM [DataWarehouse].[bronze].[crm_sales_details]
  WHERE REPLACE(TRIM(sls_prd_key),'-','_') NOT IN (SELECT prd_key 
FROM silver.crm_prd_info)

SELECT TOP (1000) [sls_ord_num]
      ,REPLACE(TRIM(sls_prd_key),'-','_') sls_prd_key
      ,[sls_cust_id]
      ,[sls_order_dt]
      ,[sls_ship_dt]
      ,[sls_due_dt]
      ,[sls_sales]
      ,[sls_quantity]
      ,[sls_price]
  FROM [DataWarehouse].[bronze].[crm_sales_details]
  WHERE sls_cust_id NOT IN (SELECT cst_id 
FROM silver.crm_cust_info)
