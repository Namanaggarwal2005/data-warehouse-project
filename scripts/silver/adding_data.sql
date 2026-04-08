TRUNCATE TABLE silver.crm_cust_info;

INSERT INTO silver.crm_cust_info
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
      ,CASE WHEN prd_line='M' THEN 'Mountain'
            WHEN prd_line='R' THEN 'Road'
            WHEN prd_line='S'THEN 'Other Sale'
            WHEN prd_line='T' THEN 'Travel'
            ELSE 'n/a'
        END prd_line
      ,CAST(prd_start_dt AS DATE) prd_start_dt
      ,CAST(LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt) - 1 AS DATE) prd_end_dt
  FROM bronze.[crm_prd_info]
