-- Relationship checking
SELECT TOP 10
CASE WHEN cid LIKE 'NAS%' THEN REPLACE(cid,'NAS','') 
	ELSE cid
END cid
FROM 
bronze.erp_cust_az12;


SELECT TOP 10
cst_key
FROM silver.crm_cust_info

-- Date Checking
SELECT
bdate
FROM bronze.erp_cust_az12
WHERE bdate > GETDATE();

--gen
SELECT DISTINCT
gen
FROM
(
SELECT
CASE WHEN UPPER(TRIM(gen)) = 'M' THEN 'Male'
	WHEN UPPER(TRIM(gen)) = 'F' THEN 'Female'
	WHEN TRIM(gen) = '' THEN 'n/a'
	WHEN gen IS NULL THEN 'n/a'
	ELSE TRIM(gen)
END gen
FROM bronze.erp_cust_az12)t

