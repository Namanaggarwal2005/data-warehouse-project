CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
	
	TRUNCATE TABLE silver.crm_cust_info;
	INSERT INTO 
		silver.crm_cust_info
	(
		cst_id,
		cst_key,
		cst_firstname,
		cst_lastname,
		cst_marital_status,
		cst_gndr,
		cst_create_date
	)
		SELECT
		cst_id,
		cst_key,
		TRIM(cst_firstname) AS cst_firstname,
		TRIM(cst_lastname) AS cst_lastname,
		CASE WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
			WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
			ELSE 'n/a'
		END AS cst_marital_status,
		CASE WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
			WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
			ELSE 'n/a'
		END AS cst_gndr,
		TRY_CONVERT(DATE, TRIM(cst_create_date), 103) AS cst_create_date
		FROM (
			SELECT
			*,
			ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) flag
			FROM bronze.crm_cust_info
			WHERE cst_id IS NOT NULL
		)t
		WHERE flag = 1;
	
	----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	TRUNCATE TABLE silver.crm_prod_info;
	INSERT INTO silver.crm_prod_info (
		prd_id,
		cat_id ,
	    prd_key ,
		prd_nm,
		prd_cost ,
		prd_line ,
		prd_start_dt ,
		prd_end_dt 
	)
	SELECT
	       prd_id
	      ,REPLACE(SUBSTRING(prd_key,1,5),'-','_') cat_id
	      ,REPLACE(SUBSTRING(prd_key,7),'-','_') prd_key
	      ,TRIM(prd_nm) prd_nm
	      ,ISNULL(prd_cost,0) prd_cost
	      ,CASE WHEN UPPER(TRIM(prd_line))='M' THEN 'Mountain'
	            WHEN UPPER(TRIM(prd_line))='R' THEN 'Road'
	            WHEN UPPER(TRIM(prd_line))='S'THEN 'Other Sale'
	            WHEN UPPER(TRIM(prd_line))='T' THEN 'Travel'
	            ELSE 'n/a'
	        END prd_line
	      ,CAST(prd_start_dt AS DATE) prd_start_dt
	      ,CAST(LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt) - 1 AS DATE) prd_end_dt
	  FROM bronze.[crm_prd_info]
	
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	TRUNCATE TABLE silver.crm_sales_details;
	INSERT INTO
	silver.crm_sales_details
	(
		sls_ord_num,
		sls_cust_id,
		sls_prd_key,
		sls_order_dt,
		sls_due_dt,
		sls_ship_dt,
		sls_sales,
		sls_price,
		sls_quantity	
	)
	SELECT
	sls_ord_num,
	sls_cust_id,
	REPLACE(TRIM(sls_prd_key),'-','_') sls_prd_key,
	CASE WHEN sls_order_dt <=0 OR LEN(sls_order_dt) != 8 THEN NULL
		ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE)
	END sls_order_dt,
	CASE WHEN sls_due_dt <=0 OR LEN(sls_due_dt) != 8 THEN NULL
		ELSE CAST(CAST(sls_due_dt AS VARCHAR) AS DATE)
	END sls_due_dt,
	CASE WHEN sls_ship_dt <=0 OR LEN(sls_ship_dt) != 8 THEN NULL
		ELSE CAST(CAST(sls_ship_dt AS VARCHAR) AS DATE)
	END sls_ship_dt,
	CASE WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity*ABS(sls_price)
		THEN sls_quantity*ABS(sls_price)
		ELSE sls_sales
	END sls_sales,
	CASE WHEN sls_price IS NULL OR sls_price <= 0 THEN sls_sales/NULLIF(sls_quantity,0)
		ELSE sls_price
	END sls_price,
	sls_quantity
	FROM
	bronze.crm_sales_details
	
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	TRUNCATE TABLE silver.erp_cust_az12;
	INSERT INTO silver.erp_cust_az12
	(
		cid,
		bdate,
		gen
	)
	SELECT
	CASE WHEN cid LIKE 'NAS%' THEN REPLACE(TRIM(cid),'NAS','')
		ELSE cid
	END cid,
	CASE WHEN bdate> GETDATE() THEN NULL
		ELSE bdate
	END bdate,
	CASE WHEN UPPER(TRIM(gen)) = 'M' THEN 'Male'
		WHEN UPPER(TRIM(gen)) = 'F' THEN 'Female'
		WHEN TRIM(gen) = '' THEN 'n/a'
		WHEN gen IS NULL THEN 'n/a'
		ELSE TRIM(gen)
	END gen
	FROM bronze.erp_cust_az12
	
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	TRUNCATE TABLE silver.erp_loc_a101;
	INSERT INTO 
	silver.erp_loc_a101
	(cid,cntry)
	SELECT
	REPLACE(cid,'-','') cid,
	CASE WHEN TRIM(cntry) = 'DE' THEN 'Germany'
		WHEN TRIM(cntry) IN ('US', 'USA') THEN 'United States'
		WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
		ELSE TRIM(cntry)
	END cntry
	FROM 
	bronze.erp_loc_a101
	
	--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	TRUNCATE TABLE silver.erp_px_cat_g1v2;
	INSERT INTO
	silver.erp_px_cat_g1v2
	(
		id,
		cat,
		subcat,
		maintenance
	)
	SELECT
	TRIM(id) id,
	TRIM(cat) cat,
	TRIM(subcat) subcat,
	TRIM(maintenance) maintenance
	FROM bronze.erp_px_cat_g1v2
END

EXEC silver.load_silver
