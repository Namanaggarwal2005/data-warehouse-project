--Primary key checking
SELECT cst_id, COUNT(*)
FROM(
SELECT
	ci.cst_id,
	ci.cst_key,
	ci.cst_firstname,
	ci.cst_lastname,
	ci.cst_marital_status,
	ci.cst_gndr,
	ci.cst_create_date,
	ca.bdate,
	ca.gen,
	cl.cntry
FROM 
	silver.crm_cust_info ci
LEFT JOIN
	silver.erp_cust_az12 ca
ON ca.cid = ci.cst_key
LEFT JOIN
	silver.erp_loc_a101 cl
ON cl.cid = ci.cst_key
)t GROUP BY cst_id
HAVING COUNT(*) > 1;

--Making the gender clear
SELECT DISTINCT
	ci.cst_gndr,
	ca.gen,
	CASE WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr
		ELSE ISNULL(ca.gen, 'n/a')
	END
FROM 
	silver.crm_cust_info ci
LEFT JOIN
	silver.erp_cust_az12 ca
ON ca.cid = ci.cst_key
ORDER BY 1,2
