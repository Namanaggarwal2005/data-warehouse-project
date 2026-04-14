CREATE VIEW gold.dim_customers AS
SELECT
	ROW_NUMBER() OVER(ORDER BY ci.cst_id) AS customer_key,
	ci.cst_id AS cutomer_id,
	ci.cst_key AS customer_number,
	ci.cst_firstname AS first_name,
	ci.cst_lastname AS last_name,
	ci.cst_marital_status AS marital_status,
	ca.bdate AS birthdate,
	ci.cst_create_date AS create_date,
	cl.cntry AS country,
	CASE WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr
		ELSE ISNULL(ca.gen, 'n/a')
	END gender
FROM 
	silver.crm_cust_info ci
LEFT JOIN
	silver.erp_cust_az12 ca
ON ca.cid = ci.cst_key
LEFT JOIN
	silver.erp_loc_a101 cl
ON cl.cid = ci.cst_key
