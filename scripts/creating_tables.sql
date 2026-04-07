IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL
	DROP TABLE bronze.crm_cust_info;
CREATE TABLE bronze.crm_cust_info(
	cst_id INT,
	cst_key NVARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR(50),
	cst_marital_status NVARCHAR(1),
	cst_gndr NVARCHAR(1),
	cst_create_date DATE
);
GO;
IF OBJECT_ID('bronze.crm_prod_info', 'U') IS NOT NULL
	DROP TABLE bronze.crm_prod_info;
CREATE TABLE bronze.crm_prod_info(
	prod_id INT,
	prod_key NVARCHAR(50),
	prod_nm NVARCHAR(50),
	prod_cost INT,
	prod_line NVARCHAR(10),
	prd_start_dt DATE,
	prd_end_dt DATE
)

GO;
IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL
	DROP TABLE bronze.crm_sales_details;
CREATE TABLE bronze.crm_sales_details(
	sls_ord_num NVARCHAR(50),
	sls_prd_key	NVARCHAR(50),
	sls_cust_id INT,
	sls_order_dt DATE,
	sls_ship_dt DATE,
	sls_due_dt	DATE,
	sls_sales INT,
	sls_quantity INT,
	sls_price FLOAT
)

GO;
IF OBJECT_ID('bronze.erp_CUST_AZ12', 'U') IS NOT NULL
	DROP TABLE bronze.erp_CUST_AZ12;
CREATE TABLE bronze.erp_CUST_AZ12(
	CID NVARCHAR(50),
	BDATE DATE,
	GEN NVARCHAR(10)
)

GO;
IF OBJECT_ID('bronze.erp_LOC_A101', 'U') IS NOT NULL
	DROP TABLE bronze.erp_LOC_A101;
CREATE TABLE bronze.erp_LOC_A101(
	CID NVARCHAR(50),
	CNTRY NVARCHAR(50)
)

GO;
IF OBJECT_ID('bronze.erp_PX_CAT_G1V2', 'U') IS NOT NULL
	DROP TABLE bronze.erp_PX_CAT_G1V2;
CREATE TABLE bronze.erp_PX_CAT_G1V2(
	ID NVARCHAR(50),
	CAT NVARCHAR(50),
	SUBCAT NVARCHAR(50),
	MAINTENANCE NVARCHAR(10)
)
