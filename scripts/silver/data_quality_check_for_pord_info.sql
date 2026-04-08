-- for primry key
SELECT
  *
FROM
(
		SELECT
		*,
		ROW_NUMBER() OVER(PARTITION BY prd_id ORDER BY prd_start_dt DESC) flag
		FROM bronze.crm_prd_info
		WHERE prd_id IS NOT NULL
	)t
	WHERE flag = 1;


-- Breaking prd_key into two parts
SELECT
	REPLACE(SUBSTRING(prd_key,1,5),'-','_') cat_id
FROM bronze.crm_prd_info

SELECT
	REPLACE(SUBSTRING(prd_key,7),'-','_') prd_key
FROM bronze.crm_prd_info
