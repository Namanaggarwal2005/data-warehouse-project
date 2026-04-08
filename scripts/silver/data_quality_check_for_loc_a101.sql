--cid check
SELECT TOP 10
REPLACE(cid,'-','') cid
FROM 
bronze.erp_loc_a101;


SELECT TOP 10
cst_key
FROM silver.crm_cust_info
