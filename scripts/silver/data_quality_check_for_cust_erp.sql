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


