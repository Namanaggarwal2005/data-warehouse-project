-- PRIMARY KEY CHECK
SELECT
  *
FROM
(
		SELECT
		*,
		ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) flag
		FROM bronze.crm_cust_info
		WHERE cst_id IS NOT NULL
	)t
	WHERE flag = 1;

-- Whitespaces in firstname and lastname
SELECT 
*
FROM bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname) OR cst_lastname != TRIM(cst_lastname);

-- marital status values checking for data normalisation and standardisation
SELECT DISTINCT
cst_marital_status
FROM bronze.crm_cust_info


--Casting check
SELECT
ISDATE(cst_create_date)
FROM bronze.crm_cust_info

-- Error reason checking
SELECT *
FROM bronze.crm_cust_info
WHERE TRY_CAST(TRIM(cst_create_date) AS DATE) IS NULL
  AND cst_create_date IS NOT NULL;
